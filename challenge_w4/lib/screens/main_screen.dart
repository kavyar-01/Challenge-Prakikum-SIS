/*
    Nama: Fajar Perdana Kurniawan Siagian
    Nrp: 162024007
    Challenge Week 4
 */

import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/drink.dart';
import 'cart_page.dart';
import 'home_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<CartItem> _cartItems = [];

  final List<Drink> _drinkList = const [
    Drink(
      id: 'd1',
      name: 'Espresso',
      price: 15000,
      imageUrl: 'assets/drinks/espresso.png',
    ),
    Drink(
      id: 'd2',
      name: 'Americano',
      price: 18000,
      imageUrl: 'assets/drinks/americano.png',
    ),
    Drink(
      id: 'd3',
      name: 'Matcha Latte',
      price: 25000,
      imageUrl: 'assets/drinks/matchalatte.png',
    ),
    Drink(
      id: 'd4',
      name: 'Chocolate Frappe',
      price: 28000,
      imageUrl: 'assets/drinks/chocolatefrappe.png',
    ),
  ];

  void _addToCart(Drink drink, int quantity) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.drink.id == drink.id);
      if (index != -1) {
        _cartItems[index].quantity += quantity;
      } else {
        _cartItems.add(CartItem(drink: drink, quantity: quantity));
      }
    });
  }

  void _removeFromCart(String drinkId) {
    setState(() {
      _cartItems.removeWhere((item) => item.drink.id == drinkId);
    });
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalQty = _cartItems.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    final List<Widget> pages = [
      HomePage(drinkList: _drinkList, onAddToCart: _addToCart),
      CartPage(
        cartItems: _cartItems,
        onRemoveFromCart: _removeFromCart,
        onCheckout: _clearCart,
      ),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromRGBO(171, 129, 81, 1),
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: totalQty > 0,
              label: Text('$totalQty'),
              child: const Icon(Icons.shopping_cart),
            ),
            label: 'Keranjang',
          ),
        ],
      ),
    );
  }
}
