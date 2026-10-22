/*
    Nama: Fajar Perdana Kurniawan Siagian
    Nrp: 162024007
    Tugas Akhir 3
 */

import 'drink.dart';

class CartItem {
  final Drink drink;
  int quantity;

  CartItem({required this.drink, this.quantity = 1});

  int get subtotal => drink.price * quantity;
}
