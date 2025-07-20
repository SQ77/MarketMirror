import 'package:flutter/material.dart';
import 'financial_page.dart'; // Import your model if it's in a separate file

class CompanyInfoPage extends StatelessWidget {
  final CompanyFinancials company;

  const CompanyInfoPage({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(company.companyName)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _buildCompanyCard(company),
      ),
    );
  }

  Widget _buildCompanyCard(CompanyFinancials company) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
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
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
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
            const SizedBox(height: 20),

            const Text(
              'Key Financial Metrics',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            _buildMetricsSection('Valuation', [
              _buildMetricRow('P/E Ratio', company.peRatio),
              _buildMetricRow('P/B Ratio', company.pbRatio),
              _buildMetricRow('EV/Revenue', company.evRevenue),
              _buildMetricRow('EV/EBITDA', company.evEbitda),
            ]),

            _buildMetricsSection('Profitability', [
              _buildMetricRow(
                'Gross Margin',
                company.grossMargin,
                isPercentage: true,
              ),
              _buildMetricRow(
                'Operating Margin',
                company.operatingMargin,
                isPercentage: true,
              ),
              _buildMetricRow(
                'Net Margin',
                company.netMargin,
                isPercentage: true,
              ),
              _buildMetricRow('ROE', company.roe, isPercentage: true),
              _buildMetricRow('ROA', company.roa, isPercentage: true),
            ]),

            _buildMetricsSection('Price Performance', [
              _buildMetricRow('52W High', company.week52High),
              _buildMetricRow('52W Low', company.week52Low),
              _buildMetricRow('Beta', company.beta),
            ]),

            _buildMetricsSection('Growth & Efficiency', [
              _buildMetricRow(
                'Revenue Growth',
                company.revenueGrowth,
                isPercentage: true,
              ),
              _buildMetricRow(
                'EPS Growth',
                company.epsGrowth,
                isPercentage: true,
              ),
              _buildMetricRow('Asset Turnover', company.assetTurnover),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricsSection(String title, List<Widget> metrics) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 33, 85, 161),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(children: metrics),
        ),
      ],
    );
  }

  Widget _buildMetricRow(
    String label,
    double? value, {
    bool isPercentage = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14)),
          Text(
            value != null
                ? isPercentage
                    ? '${(value * 100).toStringAsFixed(2)}%'
                    : value.toStringAsFixed(2)
                : 'N/A',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black
            ),
          ),
        ],
      ),
    );
  }
}
