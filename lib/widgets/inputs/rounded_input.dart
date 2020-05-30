import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedInput extends StatelessWidget {
  final String nombre;
  final TextEditingController controller;
  final TextInputType tipoInput;
  final bool ocultarDatos;

  RoundedInput(
      {@required this.nombre,
      @required this.controller,
      @required this.tipoInput,
      this.ocultarDatos});
  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatos = [];
    if (tipoInput == TextInputType.text) {
      inputFormatos = [
        WhitelistingTextInputFormatter(
          RegExp(r'\p{Letter}|\d| ', unicode: true),
        ),
      ];
    }
    return Container(
      height: 100.0,
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(
          24.0,
        ),
        child: TextField(
          inputFormatters: inputFormatos,
          obscureText: ocultarDatos == null ? false : ocultarDatos,
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
