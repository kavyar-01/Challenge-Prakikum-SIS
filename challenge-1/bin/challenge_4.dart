/*
  1 October 2026
  Nama: Fajar Perdana Kurniawan Siagian
  NRP: 162024007
  Challenge 1 - soal 4
*/

import 'package:challenge_1/challenge_1.dart' as challenge_1;
import 'dart:io';

Future<String> fetchData() async{
  await Future.delayed(Duration(seconds: 4));

  return "Proses unduh data selesai ✔";
}

void main(List<String> arguments) async {
  print("Mulai proses unduh....");
  await Future.delayed(Duration(seconds: 1));
  print("Sedang mengunduh data...");

  String data = await fetchData();

  print(data);

}