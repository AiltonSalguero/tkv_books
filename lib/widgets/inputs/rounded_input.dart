import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  String nombre;
  TextEditingController controller;
  TextInputType tipoInput;
  bool ocultarDatos;

  RoundedInput(
      {this.nombre, this.controller, this.tipoInput, this.ocultarDatos});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(
          24.0,
        ),
        child: TextField(
          obscureText: ocultarDatos,
          keyboardType: tipoInput,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 4.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  28.0,
                ),
              ),
            ),
            filled: true,
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            hintText: nombre,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}