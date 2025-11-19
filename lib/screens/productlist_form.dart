import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kick_n_cart/widgets/left_drawer.dart';
import 'package:kick_n_cart/screens/menu.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProductListFormPage extends StatefulWidget {
  const ProductListFormPage({super.key});

  @override
  State<ProductListFormPage> createState() => _ProductListFormPageState();
}

class _ProductListFormPageState extends State<ProductListFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _priceStr = "";
  String _description = "";
  String _thumbnail = "";
  String _category = "shoes";
  bool _isFeatured = false;

  final List<String> _categories = const [
    'shoes',
    'jersey',
    'ball',
    'accessories',
    'others',
  ];

  bool _isValidUrl(String v) {
    final u = Uri.tryParse(v);
    return u != null && (u.isScheme('http') || u.isScheme('https'));
  }

  static const Color _darkBlue = Color(0xFF1A0089);
  static const Color _whiteChocolate = Color(0xFFEFE7D3);

  @override
  Widget build(BuildContext context) {
    // Hubungkan dengan CookieRequest
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Tambah Produk'),
        centerTitle: true,
        backgroundColor: _darkBlue,
        foregroundColor: Colors.white,
        elevation: 2,
      ),
      drawer: const LeftDrawer(),
      body: Container(
        color: _whiteChocolate,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Card(
            elevation: 10,
            shadowColor: Colors.black.withValues(alpha: 0.06),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Section title
                    const Text(
                      'Form Tambah Produk',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 16),

                    // name
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Product Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                      ),
                      onChanged: (v) => _name = v.trim(),
                      onSaved: (v) => _name = (v ?? '').trim(),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return "Nama tidak boleh kosong!";
                        if (value.length < 3) return "Nama minimal 3 karakter";
                        if (value.length > 50) return "Nama maksimal 50 karakter";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // price
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Price (IDR)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (v) => _priceStr = v.trim(),
                      onSaved: (v) => _priceStr = (v ?? '').trim(),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return "Harga tidak boleh kosong!";
                        final num? parsed = num.tryParse(value);
                        if (parsed == null) return "Harga harus angka";
                        if (parsed <= 0) return "Harga harus lebih dari 0";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // description
                    TextFormField(
                      maxLines: 4,
                      decoration: InputDecoration(
                        labelText: "Description",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                      ),
                      onChanged: (v) => _description = v.trim(),
                      onSaved: (v) => _description = (v ?? '').trim(),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return "Deskripsi tidak boleh kosong!";
                        if (value.length < 10) {
                          return "Deskripsi minimal 10 karakter";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // thumbnail URL
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Thumbnail URL (opsional)",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                      ),
                      onChanged: (v) => _thumbnail = v.trim(),
                      onSaved: (v) => _thumbnail = (v ?? '').trim(),
                      validator: (v) {
                        final value = v?.trim() ?? '';
                        if (value.isEmpty) return null;
                        if (!_isValidUrl(value)) return "URL tidak valid";
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // category
                    DropdownButtonFormField<String>(
                      initialValue: _category,
                      decoration: InputDecoration(
                        labelText: "Category",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                      ),
                      items: _categories
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (val) => setState(() => _category = val ?? 'others'),
                    ),
                    const SizedBox(height: 8),

                    // featured
                    Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: SwitchListTile(
                        title: const Text("Featured Product"),
                        value: _isFeatured,
                        onChanged: (v) => setState(() => _isFeatured = v),
                        activeThumbColor: _darkBlue,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // save button
                    SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            final price = num.tryParse(_priceStr) ?? 0;
                            final response = await request.postJson(
                              "http://localhost:8000/create-product-flutter/",
                              jsonEncode({
                                "name": _name,
                                "price": price,
                                "description": _description,
                                "thumbnail": _thumbnail,
                                "category": _category,
                                "is_featured": _isFeatured,
                              }),
                            );

                            if (!context.mounted) return;

                            if (response['status'] == 'success') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Product successfully saved!"),
                                ),
                              );

                              // Kembali ke halaman utama
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyHomePage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    response['message'] ??
                                        "Something went wrong, please try again.",
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _darkBlue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
