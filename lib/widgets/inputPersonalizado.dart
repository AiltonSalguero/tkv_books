import 'package:flutter/material.dart';

Widget inputPrincipal(String texto, TextEditingController controller) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(
                28.0,
              ),
            ),
          ),
          filled: true,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
          hintText: texto,
          fillColor: Colors.white,
        ),
      ),
    ),
  );
}

Widget inputSecundario(String texto, TextEditingController controller) {
  bool mostrarTexto = false;
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextField(
        obscureText: mostrarTexto,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: const BorderRadius.all(
              const Radius.circular(
                28.0,
              ),
            ),
          ),
          filled: true,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 16.0,
          ),
          hintText: texto,
          fillColor: Colors.white,
        ),
      ),
    ),
  );
}
