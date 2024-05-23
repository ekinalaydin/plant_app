import 'package:flutter/material.dart';

class AppColors {
  static const primary =
      Color.fromRGBO(164, 209, 39, 1); // apple-green uygulamanin ana tema rengi
  static const primaryVariant =
      Color.fromRGBO(214, 247, 140, 1); // mindaro primarynin turevi
  static const secondary = Color(
      0xFF5F706B); // seasalt-2 primary rengine karşı kontrast oluşturmak için kullanılır. Örneğin, bir fitness uygulamasında, egzersiz detaylarının bulunduğu bir ekranın arka plan rengi secondary olarak seçilebilir.
  static const secondaryVariant =
      Color.fromARGB(1104, 122, 116, 1); // hookers-green
  static const background =
      Color.fromRGBO(250, 250, 250, 1); // seasalt // uygulamanin arka plani
  static const surface = Color.fromRGBO(231, 236, 236,
      1); // antiflash-white (örneğin, kağıt, kartlar) arka plan rengi olarak kullanılır.
  static const error =
      Color.fromRGBO(231, 236, 236, 1); // dark-slate-gray ERROR ARKA PLANI
  static const Color warning = Color.fromARGB(255, 222, 172, 23);
  static const onPrimary = Color.fromRGBO(
      253, 254, 251, 1); // baby-powder PRIMARY UZERINDEKILERIN RENGI.
  static const onSecondary =
      Color.fromRGBO(158, 159, 159, 1); // SECONDARYNIN USTUNE KONULACAK RENK
  static const onBackground = Color.fromRGBO(
      68, 89, 83, 1); // feldgrau ARKA PLAN RENGININ UZERINDEKI YAZILAR
  static const onSurface =
      Color.fromRGBO(43, 67, 61, 1); //dark-slate-gray KARTLARIN USTUNUN RENGI
  static const onError = Color.fromRGBO(208, 21, 31, 1); // red
}
