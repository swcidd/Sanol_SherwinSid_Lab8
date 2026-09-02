import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'store.dart';
import 'theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              if (cart.items.isEmpty) return const SizedBox();
              return TextButton(
                onPressed: () {
                  cart.selectAll(true);
                },
                child: Text(
                  'Select All',
                  style: GoogleFonts.plusJakartaSans(
                    color: LuminousColors.onSurface,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.shoppingBag,
                    size: 64,
                    color: LuminousColors.onSurface.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Your cart is empty',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add items to get started',
                    style: GoogleFonts.plusJakartaSans(
                      color: LuminousColors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return _CartItemTile(
                      item: item,
                      onToggle: () => cart.toggleSelection(item.product.id),
                      onIncrement: () => cart.updateQuantity(
                        item.product.id,
                        item.quantity + 1,
                      ),
                      onDecrement: () => cart.updateQuantity(
                        item.product.id,
                        item.quantity - 1,
                      ),
                      onRemove: () => cart.removeItem(item.product.id),
                    );
                  },
                ),
              ),
              _CheckoutSummary(cart: cart),
            ],
          );
        },
      ),
    );
  }
}

class _CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onToggle;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;

  const _CartItemTile({
    required this.item,
    required this.onToggle,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: item.isSelected
            ? LuminousColors.containerLow
            : LuminousColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: item.isSelected
              ? LuminousColors.onSurface.withValues(alpha: 0.2)
              : LuminousColors.containerLow,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: item.isSelected,
            onChanged: (_) => onToggle(),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: LuminousColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                item.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Icon(
                      item.product.icon,
                      color: LuminousColors.onSurface.withValues(alpha: 0.3),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '₱${item.product.price.toStringAsFixed(0)}',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.bold,
                    color: LuminousColors.onSurface,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(LucideIcons.trash2, size: 18),
                onPressed: onRemove,
                color: Colors.red.withValues(alpha: 0.7),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: LuminousColors.surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(LucideIcons.minus, size: 16),
                      onPressed: onDecrement,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(
                        item.quantity.toString(),
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LucideIcons.plus, size: 16),
                      onPressed: onIncrement,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CheckoutSummary extends StatelessWidget {
  final CartProvider cart;

  const _CheckoutSummary({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: LuminousColors.surface,
        border: Border(
          top: BorderSide(
            color: LuminousColors.onSurface.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subtotal (${cart.selectedCount} items)',
                  style: GoogleFonts.plusJakartaSans(
                    color: LuminousColors.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  '₱${cart.selectedTotal.toStringAsFixed(0)}',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Shipping',
                  style: GoogleFonts.plusJakartaSans(
                    color: LuminousColors.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  'Free',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₱${cart.selectedTotal.toStringAsFixed(0)}',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cart.selectedCount > 0
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Proceeding to checkout...',
                              style: GoogleFonts.plusJakartaSans(),
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Checkout',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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
