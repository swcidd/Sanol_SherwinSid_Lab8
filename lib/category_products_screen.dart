import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'store.dart';
import 'product_detail_screen.dart';
import 'theme.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Product> filteredProducts = allProducts
        .where((product) => product.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: LuminousColors.containerLow,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          product.icon,
                          color: LuminousColors.onSurface.withValues(alpha: 0.3),
                        ),
                      );
                    },
                  ),
                ),
              ),
              title: Text(
                product.name,
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                product.subcategory,
                style: GoogleFonts.plusJakartaSans(
                  color: LuminousColors.onSurface.withValues(alpha: 0.6),
                ),
              ),
              trailing: Text(
                '₱${product.price.toStringAsFixed(0)}',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(product: product),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
