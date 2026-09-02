import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final String subcategory;
  final double price;
  final double rating;
  final String imageUrl;
  final String description;
  final IconData icon;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.subcategory,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.description,
    required this.icon,
  });
}

const List<Product> allProducts = [
  Product(
    id: '1',
    name: 'Minimalist Lounge Chair',
    category: 'Chairs',
    subcategory: 'Lounge',
    price: 24999,
    rating: 4.8,
    imageUrl: 'https://images.unsplash.com/photo-1567538096630-e0c55bd6374c?w=800',
    description: 'A beautifully crafted lounge chair with clean lines and premium upholstery. Perfect for modern living spaces.',
    icon: Icons.event_seat,
  ),
  Product(
    id: '2',
    name: 'Oak Dining Table',
    category: 'Tables',
    subcategory: 'Dining',
    price: 34999,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1604074131665-7a4b13870ab3?w=800',
    description: 'Solid oak dining table with a natural finish. Seats 6-8 people comfortably.',
    icon: Icons.dining,
  ),
  Product(
    id: '3',
    name: 'Emerald Velvet Accent Chair',
    category: 'Chairs',
    subcategory: 'Lounge',
    price: 18999,
    rating: 4.7,
    imageUrl: 'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=800',
    description: 'Luxurious emerald velvet accent chair with gold legs. A statement piece for any room.',
    icon: Icons.event_seat,
  ),
  Product(
    id: '4',
    name: 'Modern Cupboard',
    category: 'Cupboards',
    subcategory: 'Storage',
    price: 28999,
    rating: 4.6,
    imageUrl: 'https://images.unsplash.com/photo-1595428774223-ef52624120d2?w=800',
    description: 'Sleek modern cupboard with ample storage space. Minimalist design meets functionality.',
    icon: Icons.cabin,
  ),
  Product(
    id: '5',
    name: 'Executive Office Chair',
    category: 'Chairs',
    subcategory: 'Office',
    price: 22999,
    rating: 4.8,
    imageUrl: 'https://images.unsplash.com/photo-1580480055273-228ff5388ef8?w=800',
    description: 'Ergonomic executive office chair with lumbar support. Designed for long working hours.',
    icon: Icons.chair,
  ),
  Product(
    id: '6',
    name: 'Glass Coffee Table',
    category: 'Tables',
    subcategory: 'Lounge',
    price: 15999,
    rating: 4.5,
    imageUrl: 'https://images.unsplash.com/photo-1533090481720-856c6e3c1fdc?w=800',
    description: 'Elegant glass coffee table with minimalist metal frame. Perfect for contemporary spaces.',
    icon: Icons.coffee,
  ),
  Product(
    id: '7',
    name: 'Standing Desk',
    category: 'Tables',
    subcategory: 'Office',
    price: 27999,
    rating: 4.9,
    imageUrl: 'https://images.unsplash.com/photo-1611269154421-4e27233ac5c7?w=800',
    description: 'Adjustable standing desk with electric motor. Promotes healthy working posture.',
    icon: Icons.desk,
  ),
  Product(
    id: '8',
    name: 'Velvet Dining Chair',
    category: 'Chairs',
    subcategory: 'Dining',
    price: 8999,
    rating: 4.6,
    imageUrl: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=800',
    description: 'Plush velvet dining chair with sturdy wooden legs. Set of 2.',
    icon: Icons.chair,
  ),
];

class CartItem {
  final Product product;
  int quantity;
  bool isSelected;

  CartItem({
    required this.product,
    this.quantity = 1,
    this.isSelected = true,
  });
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  List<CartItem> get selectedItems =>
      _items.where((item) => item.isSelected).toList();

  double get total => _items.fold(
        0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );

  double get selectedTotal => selectedItems.fold(
        0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );

  int get selectedCount => selectedItems.length;

  void addItem(Product product) {
    final existingIndex = _items.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.product.id == productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void toggleSelection(String productId) {
    final index = _items.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      _items[index].isSelected = !_items[index].isSelected;
      notifyListeners();
    }
  }

  void selectAll(bool select) {
    for (var item in _items) {
      item.isSelected = select;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
