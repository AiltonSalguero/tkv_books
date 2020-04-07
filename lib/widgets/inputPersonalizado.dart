import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget inputPrincipal(String texto, TextEditingController controller) {
  return Container(
    height: 100.0,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(
        24.0,
      ),
      child: TextField(
        inputFormatters: [
          WhitelistingTextInputFormatter(
            RegExp("[a-zA-Z]"),
          ),
        ],
        textCapitalization: TextCapitalization.words,
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
          hintText: texto,
          fillColor: Colors.white,
        ),
      ),
    ),
  );
}

Widget inputSecundario(String texto, TextEditingController controller) {
  bool ocultarTexto = true;
  return Container(
    height: 100.0,
    width: double.infinity,
    child: Padding(
      padding: const EdgeInsets.all(
        24.0,
      ),
      child: TextField(
        obscureText: ocultarTexto,
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1.0,
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

Widget inputDialogText(
    String texto, TextEditingController controlador, String textoAdvertencia) {
  return Padding(
    padding: EdgeInsets.all(
      8.0,
    ),
    child: TextFormField(
      inputFormatters: [
        WhitelistingTextInputFormatter(RegExp(r'\p{Letter}|\d| ', unicode: true)),
      ],
      textCapitalization: texto == "Autor"
          ? TextCapitalization.words
          : TextCapitalization.sentences,
      decoration: InputDecoration.collapsed(
        hintText: texto,
      ),
      controller: controlador,
      validator: (value) {
        if (value.isEmpty)
          return textoAdvertencia;
        else
          return null;
      },
    ),
  );
}

Widget inputDialogNumber(
    String texto, TextEditingController controlador, String textoAdvertencia) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: TextFormField(
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      decoration: InputDecoration.collapsed(
        hintText: texto,
      ),
      controller: controlador,
      validator: (value) {
        if (value.isEmpty)
          return textoAdvertencia;
        else
          return null;
      },
    ),
  );
}
