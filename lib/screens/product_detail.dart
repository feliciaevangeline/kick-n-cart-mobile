import 'package:flutter/material.dart';
import 'package:kick_n_cart/models/product.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  static const Color _darkBlue = Color(0xFF1A0089);
  static const Color _portlandOrange = Color(0xFFFF5E33);
  static const Color _whiteChocolate = Color(0xFFEFE7D3);

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}, '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  String _formatPrice(num price) {
    final s = price.toStringAsFixed(0);
    final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return s.replaceAllMapped(reg, (m) => '.');
  }

  @override
  Widget build(BuildContext context) {
    final p = product.fields;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        backgroundColor: _darkBlue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      backgroundColor: _whiteChocolate,
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (p.thumbnail.isNotEmpty)
              Container(
                color: Colors.grey.shade200,
                child: Image.network(
                  p.thumbnail,
                  width: double.infinity,
                  height: 260,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 260,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Icon(Icons.broken_image, size: 56),
                    ),
                  ),
                ),
              )
            else
              Container(
                height: 160,
                color: Colors.grey.shade200,
                child: const Center(
                  child: Icon(Icons.image, size: 56),
                ),
              ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                margin: const EdgeInsets.only(top: 12, bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 6,
                shadowColor: Colors.black.withValues(alpha: 0.06),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Featured badge
                      if (p.isFeatured)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 6.0),
                          margin: const EdgeInsets.only(bottom: 12.0),
                          decoration: BoxDecoration(
                            color: _portlandOrange,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Text(
                            'FEATURED',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),

                      // Nama produk
                      Text(
                        p.name,
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Brand
                      if (p.brand.isNotEmpty)
                        Text(
                          'Brand: ${p.brand}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),

                      const SizedBox(height: 8),

                      // Category chip & createdAt
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            decoration: BoxDecoration(
                              color: _darkBlue.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Text(
                              p.category.toUpperCase(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _darkBlue,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            _formatDate(p.createdAt),
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Harga & stok
                      Row(
                        children: [
                          Text(
                            'Price: Rp ${_formatPrice(p.price)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Text(
                            'Stock: ${p.stock}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),

                      const Divider(height: 28),

                      // Deskripsi
                      Text(
                        p.description,
                        style: const TextStyle(
                          fontSize: 16.0,
                          height: 1.6,
                        ),
                        textAlign: TextAlign.justify,
                      ),

                      const SizedBox(height: 20),

                      // Tombol kembali
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Kembali ke Daftar Produk'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _darkBlue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
