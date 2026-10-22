
/*
    Nama: Fajar Perdana Kurniawan Siagian
    Nrp: 162024007
    Challenge 3
 */

import 'dart:async';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Warung IS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
  @override
  void initState(){
    super.initState();
    _goToNavigateToHome();
  }

  _goToNavigateToHome() async{
    await Future.delayed(Duration(seconds: 4));
    Navigator.pushReplacement(context, 
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/cafe.png'),
        width: 150,
        height: 150,),
      ),
    );
  }
}

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final List<String> foodlist = [
    'Espresso',
    'Americano',
    'Matcha Latte',
    'Chocolate Frappe',
  ];

  String searchText = "";

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cari Minuman',
              ),
              onChanged: (value){
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(8.0),
              children: foodlist
                  .where((food) => food.toLowerCase().contains(searchText))
                  .map((food) {
                return Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ), 
                  child: ListTile(
                    leading: Icon(Icons.food_bank_rounded),
                    title: Text(food, style: TextStyle(fontSize: 20)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DrinkDetailPage(drinkName: food),
                              ),
                            );
                          },
                          child: Text('Detail', style: TextStyle(fontSize: 16, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(171, 129, 81, 1),
                          ),
                        ),
                        SizedBox(width: 8), 
                        ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(context, food);
                          },
                          child: Text('Pesan', style: TextStyle(fontSize: 16)),
                        ),
                      ],
                    ),
                  ), 
                ); 
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String foodName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Pesanan'),
          content: Text('Apakah Anda yakin ingin memesan $foodName?'),
          actions: [
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ), 
            TextButton(
              child: Text('Ya'),
              onPressed: () {
                Navigator.of(context).pop();
                _showSuccessDialog(context, foodName);
              },
            ), 
          ],
        ); 
      },
    );
  }

  void _showSuccessDialog(BuildContext context, String foodName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pesanan Berhasil'),
          content: Text('Anda telah memesan $foodName.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ), 
          ],
        );
      },
    );
  }
}

class DrinkDetailPage extends StatefulWidget {
  final String drinkName;

  const DrinkDetailPage({super.key, required this.drinkName});

  @override
  _DrinkDetailPageState createState() => _DrinkDetailPageState();
}

class _DrinkDetailPageState extends State<DrinkDetailPage> {
  int _quantity = 1;

  void _increment() {
    setState(() {
      _quantity++;
    });
  }

  void _decrement() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      }
    });
  }

  void _showOrderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pesanan Berhasil'),
          content: Text('Anda telah menambahkan ${widget.drinkName} sebanyak $_quantity ke pesanan.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drinkName),
        centerTitle: true,
      ),
      backgroundColor: Colors.purple[50], 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Icon(Icons.coffee_rounded, size: 60, color: Colors.brown),
                  SizedBox(height: 10),
                  Text(
                    widget.drinkName,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            Text('Jumlah', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _decrement,
                  child: Icon(Icons.remove_circle, color: Colors.red, size: 40),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    '$_quantity',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: _increment,
                  child: Icon(Icons.add_circle, color: Colors.green, size: 40),
                ),
              ],
            ),
            SizedBox(height: 40),

            ElevatedButton(
              onPressed: _showOrderDialog,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text('Tambah Pesanan', style: TextStyle(fontSize: 16, color: Colors.purple[150])),
            ),
          ],
        ),
      ),
    );
  }
}