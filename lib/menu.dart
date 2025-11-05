import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  // Identitas
  final String nama = "Felicia Evangeline Mubarun";
  final String npm = "2406437054";
  final String kelas = "E";

  @override
  Widget build(BuildContext context) {
    // Spesifikasi 3 tombol
    final buttons = <_ButtonSpec>[
      _ButtonSpec(
        label: 'All Products',
        icon: Icons.list_alt,
        color: Colors.blue, 
        snackbarText: 'Kamu telah menekan tombol All Products',
      ),
      _ButtonSpec(
        label: 'My Products',
        icon: Icons.inventory_2,
        color: Colors.green, 
        snackbarText: 'Kamu telah menekan tombol My Products',
      ),
      _ButtonSpec(
        label: 'Create Product',
        icon: Icons.add_box,
        color: Colors.red, 
        snackbarText: 'Kamu telah menekan tombol Create Product',
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
              children: buttons.map((b) {
                return _ActionCard(
                  label: b.label,
                  icon: b.icon,
                  color: b.color,
                  onTap: () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(content: Text(b.snackbarText)),
                      );
                  },
                );
              }).toList(),
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

class _ActionCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 32),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonSpec {
  final String label;
  final IconData icon;
  final Color color;
  final String snackbarText;
  const _ButtonSpec({
    required this.label,
    required this.icon,
    required this.color,
    required this.snackbarText,
  });
}
