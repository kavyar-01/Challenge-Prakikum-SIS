/*
    Nama: Fajar Perdana Kurniawan Siagian
    Nrp: 162024007
    Tugas Akhir 3
 */

class Drink {
  final String id;
  final String name;
  final int price;
  final String imageUrl;

  const Drink({
    required this.id,
    required this.name,
    required this.price,
    this.imageUrl = 'assets/cafe.png',
  });
}
