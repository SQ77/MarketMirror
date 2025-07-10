import 'package:flutter/material.dart';

// Stock model
class Stock {
  final String symbol;
  final String name;
  final String logoPath;

  Stock({required this.symbol, required this.name, required this.logoPath});
}

// Main predictions page
class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  PredictPageState createState() => PredictPageState();
}

class PredictPageState extends State<PredictPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<Stock> stocks = [
    Stock(
      symbol: 'AAPL',
      name: 'Apple',
      logoPath: 'assets/company_logos/AAPL.png',
    ),
    Stock(
      symbol: 'MSFT',
      name: 'Microsoft',
      logoPath: 'assets/company_logos/MSFT.png',
    ),
    Stock(
      symbol: 'GOOGL',
      name: 'Google',
      logoPath: 'assets/company_logos/GOOGL.png',
    ),
    Stock(
      symbol: 'TSLA',
      name: 'Tesla',
      logoPath: 'assets/company_logos/TSLA.png',
    ),
    Stock(
      symbol: 'AMZN',
      name: 'Amazon',
      logoPath: 'assets/company_logos/AMZN.png',
    ),
    Stock(
      symbol: 'NVDA',
      name: 'NVIDIA',
      logoPath: 'assets/company_logos/NVDA.png',
    ),
    Stock(
      symbol: 'META',
      name: 'Meta',
      logoPath: 'assets/company_logos/META.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSwipe(bool isUp) {
    String direction = isUp ? 'UP' : 'DOWN';
    String stockName = stocks[_currentIndex].name;

    // Show prediction result
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isUp ? Icons.trending_up : Icons.trending_down,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              'Predicted $stockName will go $direction',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
          ],
        ),
        backgroundColor:
            isUp ? const Color(0xFF00C896) : const Color(0xFFFF4757),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(milliseconds: 1500),
      ),
    );

    // Move to next card
    _nextCard();
  }

  void _nextCard() {
    if (_currentIndex < stocks.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      // Show completion dialog
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF00C896),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.black,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'All Done!',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          content: Text(
            'You\'ve made predictions for all ${stocks.length} stocks. Great job!',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetCards();
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF00C896),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: const Text('Start Over'),
            ),
          ],
        );
      },
    );
  }

  void _resetCards() {
    setState(() {
      _currentIndex = 0;
    });
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Progress indicator
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF30363D)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFF00C896),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.bar_chart,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${_currentIndex + 1} / ${stocks.length}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Instructions
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.5 * 255),
              ),
            ),
            child: Column(
              children: [
                Text(
                  'Make Your Prediction',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF00C896),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Swipe up if you think the stock will go UP\nSwipe down if you think it will go DOWN',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(height: 1.4),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Cards
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: stocks.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: StockCard(stock: stocks[index], onSwipe: _onSwipe),
                );
              },
            ),
          ),

          // Action buttons
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.3 * 255),
              border: Border(
                top: BorderSide(
                  color: Colors.black.withValues(alpha: 0.5 * 255),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ActionButton(
                  onPressed: () => _onSwipe(false),
                  color: const Color(0xFFFF4757),
                  icon: Icons.trending_down,
                  label: 'DOWN',
                ),
                const SizedBox(width: 20),
                _ActionButton(
                  onPressed: () => _onSwipe(true),
                  color: const Color(0xFF00C896),
                  icon: Icons.trending_up,
                  label: 'UP',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Action button component
class _ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color color;
  final IconData icon;
  final String label;

  const _ActionButton({
    required this.onPressed,
    required this.color,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          elevation: 4,
          shadowColor: color.withValues(alpha: 0.3 * 255),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.black, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// Stock card component
class StockCard extends StatefulWidget {
  final Stock stock;
  final Function(bool) onSwipe;

  const StockCard({super.key, required this.stock, required this.onSwipe});

  @override
  StockCardState createState() => StockCardState();
}

class StockCardState extends State<StockCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  double _dragDistance = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onPanStart: (details) {
        _animationController.forward();
      },
      onPanUpdate: (details) {
        setState(() {
          _dragDistance += details.delta.dy;
        });
      },
      onPanEnd: (details) {
        _animationController.reverse();

        if (_dragDistance.abs() > 60) {
          bool isUp = _dragDistance < 0;
          widget.onSwipe(isUp);
        }

        setState(() {
          _dragDistance = 0;
        });
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Transform.rotate(
              angle:
                  _dragDistance > 0
                      ? _rotationAnimation.value
                      : -_rotationAnimation.value,
              child: Transform.translate(
                offset: Offset(0, _dragDistance * 0.2),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF30363D),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2 * 255),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1 * 255),
                        blurRadius: 40,
                        offset: const Offset(0, 0),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Stock logo
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.08 * 255),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.2 * 255),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            widget.stock.logoPath,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(
                                    alpha: 0.1 * 255,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.business,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Stock symbol
                      Text(
                        widget.stock.symbol,
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 36,
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Company name
                      Text(
                        widget.stock.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Drag indicator
                      Column(
                        children: [
                          Container(
                            width: 50,
                            height: 4,
                            decoration: BoxDecoration(
                              color: const Color(0xFF30363D),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Drag to predict',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
