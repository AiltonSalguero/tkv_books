import 'package:flutter/material.dart';

Widget titulo1Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget titulo2Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 18.0,
    ),
  );
}

Widget titulo3Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      color: Colors.black,
      fontSize: 12.0,
      //fontWeight: FontWeight.bold,
    ),
  );
}

Widget subTitulo1Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 24.0,
      color: Colors.white,
    ),
  );
}

Widget subTitulo2Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 16.0,
      color: Colors.white,
    ),
  );
}

Widget subTitulo3Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 10.0,
      color: Colors.grey,
    ),
  );
}
