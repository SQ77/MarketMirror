import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  List<NewsItem> newsItems = [];
  bool isLoading = true;
  String errorMessage = '';

  // Get API key from environment variables
  String get apiKey => dotenv.env['FINNHUB_API_KEY'] ?? '';

  // List of North American companies
  final List<String> companies = [
    'AAPL', // Apple
    'MSFT', // Microsoft
    'GOOGL', // Google
    'TSLA', // Tesla
    'AMZN', // Amazon
    'NVDA', // NVIDIA
    'META', // Meta
    'NFLX', // Netflix
  ];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    if (apiKey.isEmpty) {
      setState(() {
        errorMessage = 'API key not found. Please check your .env file.';
        isLoading = false;
      });
      return;
    }

    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      List<NewsItem> allNews = [];

      // Get current date and 3 days ago
      DateTime now = DateTime.now();
      DateTime threeDaysAgo = now.subtract(const Duration(days: 3));

      String toDate = now.toIso8601String().split('T')[0];
      String fromDate = threeDaysAgo.toIso8601String().split('T')[0];

      // Fetch news for each company
      for (String symbol in companies) {
        try {
          final response = await http.get(
            Uri.parse(
              'https://www.finnhub.io/api/v1/company-news?symbol=$symbol&from=$fromDate&to=$toDate&token=$apiKey',
            ),
          );

          if (response.statusCode == 200) {
            List<dynamic> data = json.decode(response.body);

            // Convert to NewsItem objects and add company symbol
            List<NewsItem> companyNews =
                data.map((item) => NewsItem.fromJson(item, symbol)).toList();
            allNews.addAll(companyNews);
          }
        } catch (e) {
          print('Error fetching news for $symbol: $e');
        }
      }

      // Sort by date (newest first) and take top 20
      allNews.sort((a, b) => b.datetime.compareTo(a.datetime));
      allNews = allNews.take(20).toList();

      setState(() {
        newsItems = allNews;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load news: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: fetchNews),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : errorMessage.isNotEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: fetchNews,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
              : newsItems.isEmpty
              ? const Center(child: Text('No news available'))
              : RefreshIndicator(
                onRefresh: fetchNews,
                child: ListView.builder(
                  itemCount: newsItems.length,
                  itemBuilder: (context, index) {
                    final news = newsItems[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading:
                            news.image.isNotEmpty
                                ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    news.image,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.grey[300],
                                        child: const Icon(
                                          Icons.image_not_supported,
                                        ),
                                      );
                                    },
                                  ),
                                )
                                : Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.article),
                                ),
                        title: Text(
                          news.headline,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              news.summary,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    news.symbol,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  news.formattedDate,
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () => _launchUrl(news.url),
                        isThreeLine: true,
                      ),
                    );
                  },
                ),
              ),
    );
  }
}

class NewsItem {
  final String headline;
  final String summary;
  final String url;
  final String image;
  final int datetime;
  final String symbol;

  NewsItem({
    required this.headline,
    required this.summary,
    required this.url,
    required this.image,
    required this.datetime,
    required this.symbol,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json, String symbol) {
    return NewsItem(
      headline: json['headline'] ?? '',
      summary: json['summary'] ?? '',
      url: json['url'] ?? '',
      image: json['image'] ?? '',
      datetime: json['datetime'] ?? 0,
      symbol: symbol,
    );
  }

  String get formattedDate {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(datetime * 1000);
    return '${date.day}/${date.month}/${date.year}';
  }
}
