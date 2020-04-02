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

List<int> experienciaRequerida = [
  0, // Lv 1
  15, // Lv 2
  49, // Lv 3
  106, // Lv 4
  198, // Lv 5
  333, // Lv 6
  705, // Lv 7
  1265, // Lv 8
  2105, // Lv 9
  3347, // Lv 10
  4589,
  5831,
  7073,
  8315,
  9557,
  11047,
  12835,
  14980,
  17554,
];

int calcularLevelUsuario(int puntaje) {
  int level = 1;
  for (int i = 0; i < experienciaRequerida.length; i++) {
    if (puntaje > experienciaRequerida[i]) level = i + 1;
  }
  return level;
}

int calcularExperienciaRequerida(int level) {
  if (level == 1) return 15;
  return experienciaRequerida[level] - experienciaRequerida[level - 1];
}

int calcularExperienciaRequeridaTotal(int level) {
  return experienciaRequerida[level];
}
