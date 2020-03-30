import 'package:flutter/material.dart';

String porcentajeString(int numMenor, int numMayor) {
  return (numMenor * 100 / numMayor).toStringAsFixed(2) + "%";
}

double porcentajeDouble(int numMenor, int numMayor) {
  return double.parse((numMenor / numMayor).toStringAsFixed(2));
}

Color colorProgressBar(double porcentaje) {
  Color colorBarra = Colors.white;
  if (porcentaje == 1.00) colorBarra = Color(0xFFFFD938); // Amarillo
  if (porcentaje < 1.00) colorBarra = Color(0xFF5CC5E5); // Amarillo
  if (porcentaje < 0.75) colorBarra = Color(0xFF35A8A1); // Turquesa
  if (porcentaje < 0.25) colorBarra = Color(0xFFF37D93); // Naranja
  if (porcentaje < 0.15) colorBarra = Color(0xFFEE5F35); // Rosa
  return colorBarra;
}
