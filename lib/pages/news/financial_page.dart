import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'company_info_page.dart'; 

class FinancialPage extends StatefulWidget {
  const FinancialPage({super.key});

  @override
  State<FinancialPage> createState() => _FinancialPageState();
}

class _FinancialPageState extends State<FinancialPage> {
  List<CompanyFinancials> companyFinancials = [];
  bool isLoading = true;
  String errorMessage = '';
  int currentCompanyIndex = 0;

  // Get API key from environment variables
  String get apiKey => dotenv.env['FINNHUB_API_KEY'] ?? '';

  final List<Map<String, String>> companies = [
    {'symbol': 'AAPL', 'name': 'Apple Inc.'},
    {'symbol': 'MSFT', 'name': 'Microsoft Corp.'},
    {'symbol': 'GOOGL', 'name': 'Alphabet Inc.'},
    {'symbol': 'TSLA', 'name': 'Tesla Inc.'},
    {'symbol': 'AMZN', 'name': 'Amazon.com Inc.'},
    {'symbol': 'NVDA', 'name': 'NVIDIA Corp.'},
    {'symbol': 'META', 'name': 'Meta Platforms, Inc.'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    if (apiKey.isEmpty) {
      setState(() {
        errorMessage = 'API key not found.';
        isLoading = false;
      });
      return;
    }

    await fetchCompanyFinancials();
  }

  Future<void> fetchCompanyFinancials() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
        companyFinancials.clear();
        currentCompanyIndex = 0;
      });

      await _fetchNextCompany();
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load data: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _fetchNextCompany() async {
    if (currentCompanyIndex >= companies.length) {
      setState(() {
        isLoading = false;
        if (companyFinancials.isEmpty) {
          errorMessage = 'No financial data available.';
        }
      });
      return;
    }

    final company = companies[currentCompanyIndex];
    final symbol = company['symbol']!;
    final name = company['name']!;

    try {
      final response = await http.get(
        Uri.parse(
          'https://finnhub.io/api/v1/stock/metric?symbol=$symbol&metric=all&token=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['metric'] != null) {
          CompanyFinancials financials = CompanyFinancials.fromJson(
            responseData,
            symbol,
            name,
          );

          setState(() {
            companyFinancials.add(financials);
          });
        } else {
          setState(() {
            errorMessage = 'No financial data for $symbol';
            isLoading = false;
          });
        }
      } else if (response.statusCode == 429) {
        setState(() {
          errorMessage =
              'Rate limit exceeded. Please wait a moment before trying again.';
          isLoading = false;
        });
        return;
      } else {
        setState(() {
          errorMessage = 'HTTP Error for $symbol: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching $symbol: $e';
        isLoading = false;
      });
    }

    currentCompanyIndex++;

    if (currentCompanyIndex < companies.length) {
      await _fetchNextCompany();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Company Financials"),
        actions: [
          IconButton(
            onPressed: isLoading ? null : fetchCompanyFinancials,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body:
          isLoading
              ? _buildLoading()
              : errorMessage.isNotEmpty
              ? _buildError()
              : companyFinancials.isEmpty
              ? _buildNoData()
              : _buildCompanyList(),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Loading ${currentCompanyIndex + 1}/${companies.length}...',
            style: const TextStyle(fontSize: 16),
          ),
          if (currentCompanyIndex < companies.length)
            Text(
              'Fetching ${companies[currentCompanyIndex]['name']}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: fetchCompanyFinancials,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoData() {
    return const Center(
      child: Text(
        'No financial data available.\nTry refreshing or check back later.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildCompanyList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: companyFinancials.length,
      itemBuilder: (context, index) {
        final company = companyFinancials[index];
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CompanyInfoPage(company: company),
              ),
            );
          },
          child: Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        company.symbol,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        company.companyName,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  if (company.currentPrice != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '\$${company.currentPrice!.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Current Price',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class CompanyFinancials {
  final String symbol;
  final String companyName;
  final double? currentPrice;
  final double? peRatio;
  final double? pbRatio;
  final double? evRevenue;
  final double? evEbitda;
  final double? grossMargin;
  final double? operatingMargin;
  final double? netMargin;
  final double? roe;
  final double? roa;
  final double? week52High;
  final double? week52Low;
  final double? beta;
  final double? revenueGrowth;
  final double? epsGrowth;
  final double? assetTurnover;

  CompanyFinancials({
    required this.symbol,
    required this.companyName,
    this.currentPrice,
    this.peRatio,
    this.pbRatio,
    this.evRevenue,
    this.evEbitda,
    this.grossMargin,
    this.operatingMargin,
    this.netMargin,
    this.roe,
    this.roa,
    this.week52High,
    this.week52Low,
    this.beta,
    this.revenueGrowth,
    this.epsGrowth,
    this.assetTurnover,
  });

  factory CompanyFinancials.fromJson(
    Map<String, dynamic> json,
    String symbol,
    String companyName,
  ) {
    final metric = json['metric'] as Map<String, dynamic>? ?? {};

    return CompanyFinancials(
      symbol: symbol,
      companyName: companyName,
      currentPrice: _parseDouble(metric['currentPrice']),
      peRatio: _parseDouble(metric['peBasicExclExtraTTM']),
      pbRatio: _parseDouble(metric['pbQuarterly']),
      evRevenue: _parseDouble(metric['evRevenueQuarterly']),
      evEbitda: _parseDouble(metric['evEbitdaQuarterly']),
      grossMargin: _parseDouble(metric['grossMarginTTM']),
      operatingMargin: _parseDouble(metric['operatingMarginTTM']),
      netMargin: _parseDouble(metric['netProfitMarginTTM']),
      roe: _parseDouble(metric['roeTTM']),
      roa: _parseDouble(metric['roaTTM']),
      week52High: _parseDouble(metric['52WeekHigh']),
      week52Low: _parseDouble(metric['52WeekLow']),
      beta: _parseDouble(metric['beta']),
      revenueGrowth: _parseDouble(metric['revenueGrowthTTMYoy']),
      epsGrowth: _parseDouble(metric['epsGrowthTTMYoy']),
      assetTurnover: _parseDouble(metric['assetTurnoverTTM']),
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
