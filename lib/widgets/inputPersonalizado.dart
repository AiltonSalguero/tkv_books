import 'package:flutter/material.dart';

Widget inputPrincipal(String texto, TextEditingController controller) {
  return Container(
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: TextField(
        textCapitalization: TextCapitalization.words,
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
  bool mostrarTexto = true;
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

Widget inputDialogText(String texto, TextEditingController controlador) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: TextFormField(
      textCapitalization: texto == "Autor"
          ? TextCapitalization.words
          : TextCapitalization.sentences,
      decoration: InputDecoration.collapsed(
        hintText: texto,
      ),
      controller: controlador,
      validator: (value) {
        if (value.isEmpty)
          return "Complete el campo";
        else
          return null;
      },
    ),
  );
}

Widget inputDialogNumber(String texto, TextEditingController controlador) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration.collapsed(
        hintText: texto,
      ),
      controller: controlador,
      validator: (value) {
        if (value.isEmpty)
          return "Complete el campo";
        else
          return null;
      },
    ),
  );
}
