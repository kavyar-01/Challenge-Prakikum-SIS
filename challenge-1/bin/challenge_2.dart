/*
  1 October 2026
  Nama: Fajar Perdana Kurniawan Siagian
  NRP: 162024007
  Challenge - soal 2
*/

import 'package:challenge_1/challenge_1.dart' as challenge_1;
import 'dart:io';

import 'dart:io';

void main(List<String> arguments) {
  List<String> daftar = [];
  String lagi;

  do {
    stdout.write('Masukkan nama barang: ');
    daftar.add(stdin.readLineSync() ?? '');

    stdout.write('Tambah lagi? (y/n): ');
    lagi = stdin.readLineSync() ?? 'n';
    print(''); 
  } while (lagi.toLowerCase() == 'y');

  print('Daftar Belanja Hari Ini:');
  for (int i = 0; i < daftar.length; i++) {
    print('${i + 1}. ${daftar[i]}');
  }
}

