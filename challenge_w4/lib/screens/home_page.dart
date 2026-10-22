/*
    Nama: Fajar Perdana Kurniawan Siagian
    Nrp: 162024007
    Challenge Week 4
 */

import 'package:flutter/material.dart';

import '../models/drink.dart';
import '../utils/currency_format.dart';
import 'drink_detail_page.dart';

class HomePage extends StatefulWidget {
  final List<Drink> drinkList;
  final Function(Drink, int) onAddToCart;

  const HomePage({
    super.key,
    required this.drinkList,
    required this.onAddToCart,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    final filteredDrinks = widget.drinkList
        .where((drink) => drink.name.toLowerCase().contains(searchText))
        .toList();

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Welcome')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cari Minuman',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: filteredDrinks.isEmpty
                ? const Center(child: Text('Minuman tidak ditemukan'))
                : ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: filteredDrinks.length,
                    itemBuilder: (context, index) {
                      final drink = filteredDrinks[index];
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: AssetImage(drink.imageUrl),
                          ),
                          title: Text(
                            drink.name,
                            style: const TextStyle(fontSize: 18),
                          ),
                          subtitle: Text(formatRupiah(drink.price)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DrinkDetailPage(
                                        drink: drink,
                                        onAddToCart: widget.onAddToCart,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromRGBO(
                                    171,
                                    129,
                                    81,
                                    1,
                                  ),
                                ),
                                child: const Text(
                                  'Detail',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  widget.onAddToCart(drink, 1);
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${drink.name} ditambahkan ke keranjang',
                                        ),
                                        duration: const Duration(seconds: 1),
                                      ),
                                    );
                                },
                                child: const Text('Pesan'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
