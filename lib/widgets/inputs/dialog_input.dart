import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogInput extends StatelessWidget {
  TextInputType tecladoTipo = TextInputType.text;
  final String texto;
  final TextEditingController controlador;
  final String textoAdvertencia;

  List<TextInputFormatter> _formatos = List<TextInputFormatter>();

  DialogInput(
      {this.tecladoTipo,
      @required this.texto,
      @required this.controlador,
      @required this.textoAdvertencia});

  _cargarFormatos() {
    tecladoTipo == TextInputType.number
        ? _formatos.add(WhitelistingTextInputFormatter.digitsOnly)
        : _formatos.add(
            WhitelistingTextInputFormatter(
              RegExp(r'\p{Letter}|\d| ', unicode: true),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    _cargarFormatos();
    return Padding(
      padding: EdgeInsets.all(
        8.0,
      ),
      child: TextFormField(
        inputFormatters: _formatos,
        keyboardType: tecladoTipo,
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
}
