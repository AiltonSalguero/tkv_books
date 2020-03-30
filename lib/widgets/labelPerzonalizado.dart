import 'package:flutter/material.dart';

Widget titulo1Label(String texto) {
  return Text(
    texto,
    style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
  );
}

Widget titulo2Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 16.0,
    ),
  );
}

Widget titulo3Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      color: Colors.black,
      fontSize: 14.0,
      //fontWeight: FontWeight.bold,
    ),
  );
}

Widget subTitulo1Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 14.0,
      color: Colors.grey,
    ),
  );
}

Widget subTitulo2Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 12.0,
      color: Colors.grey,
    ),
  );
}

Widget subTitulo3Label(String texto) {
  return Text(
    texto,
    style: TextStyle(
      fontSize: 11.0,
      color: Colors.grey,
    ),
  );
}
