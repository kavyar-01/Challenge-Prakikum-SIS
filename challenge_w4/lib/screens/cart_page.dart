/*
    Nama: Fajar Perdana Kurniawan Siagian
    Nrp: 162024007
    Challenge Week 4
 */

import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../utils/currency_format.dart';

class CartPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Function(String) onRemoveFromCart;
  final VoidCallback? onCheckout;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onRemoveFromCart,
    this.onCheckout,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _noMejaController = TextEditingController();

  int get _totalPrice =>
      widget.cartItems.fold(0, (sum, item) => sum + item.subtotal);

  @override
  void dispose() {
    _nameController.dispose();
    _noMejaController.dispose();
    super.dispose();
  }

  void _showCheckoutDialog(
    BuildContext context, {
    required String customerName,
    required String tableNumber,
  }) {
    final total = _totalPrice;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Checkout Berhasil!'),
          content: Text(
            'Nama Pemesan: $customerName\n'
            'Nomor Meja: $tableNumber\n'
            'Total belanja: ${formatRupiah(total)}.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                widget.onCheckout?.call();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _checkout(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _showCheckoutDialog(
      context,
      customerName: _nameController.text.trim(),
      tableNumber: _noMejaController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Keranjang')),
      body: widget.cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 12),
                  const Text('Keranjang masih kosong'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(item.drink.imageUrl),
                    ),
                    title: Text(item.drink.name),
                    subtitle: Text(
                      '${item.quantity} x ${formatRupiah(item.drink.price)} = ${formatRupiah(item.subtotal)}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Hapus',
                      onPressed: () => widget.onRemoveFromCart(item.drink.id),
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.cartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nama Pemesan',
                        hintText: 'Masukkan nama pemesan',
                        prefixIcon: Icon(Icons.person_3_outlined),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Nama Pemesan tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _noMejaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Nomor Meja',
                        hintText: 'Masukkan nomor meja (1 - 21)',
                        prefixIcon: Icon(Icons.table_bar_sharp),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        final tableNumber = value?.trim() ?? '';
                        if (tableNumber.isEmpty) {
                          return 'Nomor Meja tidak boleh kosong';
                        }
                        if (!RegExp(r'^\d+$').hasMatch(tableNumber)) {
                          return 'Nomor Meja harus berupa angka';
                        }

                        final parsedTableNumber = int.tryParse(tableNumber);
                        if (parsedTableNumber == null ||
                            parsedTableNumber < 1 ||
                            parsedTableNumber > 21) {
                          return 'Rentang No meja harus 1 - 21';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Total Harga'),
                              Text(
                                formatRupiah(_totalPrice),
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => _checkout(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                              171,
                              129,
                              81,
                              1,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 14,
                            ),
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
