import 'package:flutter/material.dart';
import 'package:kick_n_cart/screens/productlist_form.dart'; // Halaman form produk baru

// Kelas model untuk tombol di halaman utama
class ProductButton {
  final String name;
  final IconData icon;
  final Color color;
  final String snackbarText;

  ProductButton(this.name, this.icon, this.color, this.snackbarText);
}

// Widget product card utama di halaman Home
class ProductCard extends StatelessWidget {
  final ProductButton button;

  const ProductCard(this.button, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: button.color,
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        onTap: () {
          // Menampilkan snackbar dengan pesan sesuai tombol
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(button.snackbarText)),
            );

          // Jika tombol Create Product ditekan, arahkan ke halaman form produk
          if (button.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductListFormPage(),
              ),
            );
          }
        },

        // Isi tampilan card
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  button.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const SizedBox(height: 6),
                Text(
                  button.name,
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
      ),
    );
  }
}
