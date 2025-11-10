import 'package:flutter/material.dart';
import 'package:kick_n_cart/widgets/left_drawer.dart';
import 'package:kick_n_cart/widgets/product_card.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Identitas
  final String nama = "Felicia Evangeline Mubarun";
  final String npm = "2406437054";
  final String kelas = "E";

  @override
  Widget build(BuildContext context) {
    // Spesifikasi 3 tombol
    final List<ProductButton> buttons = [
      ProductButton(
        'All Products',
        Icons.list_alt,
        Colors.blue,
        'Kamu telah menekan tombol All Products',
      ),
      ProductButton(
        'My Products',
        Icons.inventory_2,
        Colors.green,
        'Kamu telah menekan tombol My Products',
      ),
      ProductButton(
        'Create Product',
        Icons.add_box,
        Colors.red,
        'Kamu telah menekan tombol Create Product',
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
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),

      drawer: const LeftDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 3 InfoCard
            Row(
              children: [
                Expanded(child: InfoCard(title: 'NPM', content: npm)),
                const SizedBox(width: 12),
                Expanded(child: InfoCard(title: 'Name', content: nama)),
                const SizedBox(width: 12),
                Expanded(child: InfoCard(title: 'Class', content: kelas)),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Selamat datang di Kick n Cart',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Grid 3 kolom berisi 3 tombol
            GridView.count(
              primary: false,
              shrinkWrap: true, // biar tinggi menyesuaikan konten
              padding: const EdgeInsets.all(12),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              crossAxisCount: 3,
              children: buttons.map((btn) => ProductCard(btn)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }
}
