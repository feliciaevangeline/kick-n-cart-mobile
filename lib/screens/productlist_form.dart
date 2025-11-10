import 'package:flutter/material.dart';
import 'package:kick_n_cart/widgets/left_drawer.dart';

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
    'shoes', 'jersey', 'ball', 'accessories', 'others',
  ];

  bool _isValidUrl(String v) {
    final u = Uri.tryParse(v);
    return u != null && (u.isScheme('http') || u.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Form Tambah Produk')),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _name = v.trim(),
                onSaved:   (v) => _name = (v ?? '').trim(),
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
                decoration: const InputDecoration(
                  labelText: "Price (IDR)",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (v) => _priceStr = v.trim(),
                onSaved:   (v) => _priceStr = (v ?? '').trim(),
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
                decoration: const InputDecoration(
                  labelText: "Description",
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _description = v.trim(),
                onSaved:   (v) => _description = (v ?? '').trim(),
                validator: (v) {
                  final value = v?.trim() ?? '';
                  if (value.isEmpty) return "Deskripsi tidak boleh kosong!";
                  if (value.length < 10) return "Deskripsi minimal 10 karakter";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // thumbnail URL
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Thumbnail URL (opsional)",
                  border: OutlineInputBorder(),
                ),
                onChanged: (v) => _thumbnail = v.trim(),
                onSaved:   (v) => _thumbnail = (v ?? '').trim(),
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
                decoration: const InputDecoration(
                  labelText: "Category",
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) => setState(() => _category = val ?? 'others'),
              ),
              const SizedBox(height: 8),

              // featured
              SwitchListTile(
                title: const Text("Featured Product"),
                value: _isFeatured,
                onChanged: (v) => setState(() => _isFeatured = v),
              ),
              const SizedBox(height: 16),

              // save button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // simpan nilai dari onSaved
                      _formKey.currentState!.save();

                      final price = num.tryParse(_priceStr) ?? 0;

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text('Produk berhasil disimpan!'),
                          content: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nama: $_name'),
                                Text('Harga: Rp $price'),
                                Text('Deskripsi: $_description'),
                                Text('Kategori: $_category'),
                                Text('Thumbnail: ${_thumbnail.isEmpty ? "-" : _thumbnail}'),
                                Text('Featured: ${_isFeatured ? "Ya" : "Tidak"}'),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // reset form & state setelah dialog ditutup
                                _formKey.currentState!.reset();
                                setState(() {
                                  _name = '';
                                  _priceStr = '';
                                  _description = '';
                                  _thumbnail = '';
                                  _category = 'shoes';
                                  _isFeatured = false;
                                });
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
