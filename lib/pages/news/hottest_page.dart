import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HottestPage extends StatefulWidget {
  const HottestPage({super.key});

  @override
  State<HottestPage> createState() => _HottestPageState();
}

class _HottestPageState extends State<HottestPage> {

  List<CandleStick> candlestick = [];

  String get apiKey => dotenv.env['POLYGON_API_KEY'] ?? '';
   
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
    fetchCandle();
  }
  
  Future<void> fetchCandle() async {
    final response = await http.get(Uri.parse("https://api.polygon.io/v2/aggs/ticker/"));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        candlestick = jsonData.map((data) => CandleStick.fromJson(data)).toList();
      });
    } else {
      // Handle error if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Candlestick data'),
      ),
      body: ListView.builder(
        itemCount: candlestick.length, 
        itemBuilder: (context, index) {
          return ProductCard(product: candlestick[index]); 
        },
      ),
    );
  }
}