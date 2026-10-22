/*
  1 October 2026
  Nama: Fajar Perdana Kurniawan Siagian
  NRP: 162024007
  Challenge 1 - soal 3
*/

import 'package:challenge_1/challenge_1.dart' as challenge_1;
import 'dart:io';

String cekKategoriUsia(int umur){

  String? kategoriUsia;

  if(umur < 18){
    return "Anak-anak"; 
  }else if(umur < 50){
    return "Dewasa";
  }else if(umur < 100){
    return "Lansia";
  }else{
    return "Tidak Valid!";
  }

}

void main(List<String> arguments) {

  print("Usia 15 termasuk kategori: ${cekKategoriUsia(15)}");
  print("Usia 25 termasuk kategori: ${cekKategoriUsia(25)}");
  print("Usia 65 termasuk kategori: ${cekKategoriUsia(65)}");

}

