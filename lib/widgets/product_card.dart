import 'package:flutter/material.dart';
import 'package:kick_n_cart/screens/productlist_form.dart'; // Halaman form produk baru
import 'package:kick_n_cart/screens/login.dart'; // Untuk redirect setelah logout
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

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
    // Ambil CookieRequest dari Provider
    final request = context.watch<CookieRequest>();

    final Color bg = button.color;
    final Color iconBg = Colors.white.withValues(alpha: 0.92);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        splashColor: bg.withValues(alpha: 0.14),
        highlightColor: bg.withValues(alpha: 0.08),
        onTap: () async {
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
          // Jika tombol Logout ditekan, lakukan proses logout ke Django
          else if (button.name == "Logout") {
            final response = await request.logout(
              "http://localhost:8000/auth/logout/",
            );

            String message = response["message"];

            if (context.mounted) {
              if (response['status'] == true) {
                String uname = response["username"];
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$message See you again, $uname."),
                  ),
                );
                // Arahkan kembali ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                  ),
                );
              }
            }
          }
        },

        // Isi tampilan card
        child: Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    button.icon,
                    color: bg, 
                    size: 22.0,
                  ),
                ),

                const SizedBox(height: 8),

                // Nama tombol
                Text(
                  button.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
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
