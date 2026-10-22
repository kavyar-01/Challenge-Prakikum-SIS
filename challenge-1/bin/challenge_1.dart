/*
  1 October 2026
  Nama: Fajar Perdana Kurniawan Siagian
  NRP: 162024007
  Challenge 1 - soal 1
*/

import 'package:challenge_1/challenge_1.dart' as challenge_1;
import 'dart:io';

void main(List<String> arguments) {

  print("========= Latihan Input Output Dart =========\n");

  stdout.write("Enter First Number: ");
  int? firstNumber = int.parse(stdin.readLineSync()!);

  stdout.write("Enter Second Number: ");
  int? secondNumber = int.parse(stdin.readLineSync()!);

  print("Sum is ${firstNumber + secondNumber}");
  print("min is ${firstNumber - secondNumber}");
  print("times is ${firstNumber * secondNumber}");
  print("div is ${firstNumber ~/ secondNumber}");


}
