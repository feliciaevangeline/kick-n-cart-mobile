import 'package:flutter/material.dart';
import 'package:kick_n_cart/models/product.dart';
import 'package:kick_n_cart/widgets/left_drawer.dart';
import 'package:kick_n_cart/widgets/product_item_card.dart';
import 'package:kick_n_cart/screens/product_detail.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

class ProductItemListPage extends StatefulWidget {
  const ProductItemListPage({super.key});

  @override
  State<ProductItemListPage> createState() => _ProductItemListPageState();
}

class _ProductItemListPageState extends State<ProductItemListPage> {
  Future<List<Product>> fetchProducts(CookieRequest request) async {
    final response = await request.get('http://localhost:8000/json/');

    List<Product> productList = [];
    for (var d in response) {
      if (d != null) {
        productList.add(Product.fromJson(d));
      }
    }
    return productList;
  }

  static const Color _darkBlue = Color(0xFF1A0089);
  static const Color _whiteChocolate = Color(0xFFEFE7D3);

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 700 ? 3 : 2;
    final childAspectRatio = 0.62;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: _darkBlue,
        title: const Text(
          'Kick n Cart',
          style: TextStyle(
            color: Colors.white,         
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,         
        ),
      ),
      drawer: const LeftDrawer(),
      backgroundColor: _whiteChocolate,
      body: FutureBuilder<List<Product>>(
        future: fetchProducts(request),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Belum ada produk yang tersedia.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff59A5D8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            } else {
              final products = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: GridView.builder(
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemBuilder: (_, index) {
                    final prod = products[index];
                    return ProductItemCard(
                      product: prod,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: prod),
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}