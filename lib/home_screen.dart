import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'store.dart';
import 'product_card.dart';
import 'product_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Chairs', 'Tables', 'Cupboards'];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discover',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'The Best Furniture',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface
                                  .withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                      ClipOval(
                        child: Image.network(
                          'https://scontent.fcgy2-4.fna.fbcdn.net/v/t39.30808-6/489823654_638527112358797_3786538714552230693_n.jpg?stp=dst-jpg_tt6&cstp=mx960x960&ctp=s960x960&_nc_cat=105&ccb=1-7&_nc_sid=a5f93a&_nc_eui2=AeGKtYf_2vYnWhr_lrZCyxCKXYDAfknq8w1dgMB-SerzDe1rz22A3nDOit6U7IVGr3JbHkA7AhYI2GtHiPdWEbbw&_nc_ohc=3iI6IOOI2CgQ7kNvwEFlRx9&_nc_oc=AdoACfcauzIipAjyejWWXvp09VJ3q7FvqxXlmnVG3roKlONpMwJNGs_wXbu2sdnCRSE&_nc_zt=23&_nc_ht=scontent.fcgy2-4.fna&_nc_gid=4ydoPcG8h-uhmtCXoY3b4g&_nc_ss=7b2a8&oh=00_AQIYcvyQhZKnilM10CqjaJTCdMyC-EfO68Y_uOaFDxReJw&oe=6A9E0E36',
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 40,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final isSelected = index == 0;
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              categories[index],
                              style: GoogleFonts.plusJakartaSans(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = allProducts[index];
                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailScreen(product: product),
                          ),
                        );
                      },
                    );
                  },
                  childCount: allProducts.length,
                ),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
      ),
    );
  }
}
