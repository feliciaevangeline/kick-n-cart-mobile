import 'package:flutter/material.dart';
import 'package:kick_n_cart/widgets/left_drawer.dart';
import 'package:kick_n_cart/widgets/product_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String nama = "Felicia Evangeline Mubarun";
  final String npm = "2406437054";
  final String kelas = "E";

  static const Color _darkBlue = Color(0xFF1A0089);
  static const Color _portlandOrange = Color(0xFFFF5E33);
  static const Color _whiteChocolate = Color(0xFFEFE7D3);
  static const Color _juneBud = Color(0xFFB7CF4F);

  @override
  Widget build(BuildContext context) {
    final List<ProductButton> buttons = [
      ProductButton(
        'All Products',
        Icons.list_alt,
        _darkBlue,
        'Kamu telah menekan tombol All Products',
      ),
      ProductButton(
        'My Products',
        Icons.inventory_2,
        _juneBud,
        'Kamu telah menekan tombol My Products',
      ),
      ProductButton(
        'Create Product',
        Icons.add_box,
        _portlandOrange,
        'Kamu telah menekan tombol Create Product',
      ),
      ProductButton(
        'Logout',
        Icons.logout,
        Colors.grey.shade700,
        'Kamu telah menekan tombol Logout',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kick n Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: _darkBlue,
        elevation: 2,
      ),

      drawer: const LeftDrawer(),

      body: Container(
        color: _whiteChocolate,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // Info cards
              Row(
                children: [
                  Expanded(child: _InfoCard(title: 'NPM', content: npm, accent: _darkBlue)),
                  const SizedBox(width: 12),
                  Expanded(child: _InfoCard(title: 'Name', content: nama, accent: _darkBlue)),
                  const SizedBox(width: 12),
                  Expanded(child: _InfoCard(title: 'Class', content: kelas, accent: _darkBlue)),
                ],
              ),

              const SizedBox(height: 18),

              const Text(
                'Selamat datang di Kick n Cart',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 18),

              // Section header untuk tombol
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.grid_view, color: _darkBlue),
                          const SizedBox(width: 8),
                          Text(
                            'Menu',
                            style: TextStyle(
                              color: _darkBlue,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Grid tombol
              Expanded(
                child: GridView.count(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  crossAxisCount: 3,
                  children: buttons.map((btn) {
                    return ProductCard(
                      btn,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// InfoCard
class _InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final Color accent;

  const _InfoCard({
    required this.title,
    required this.content,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 92,
      child: Card(
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 6,
                height: double.infinity,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      content,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
