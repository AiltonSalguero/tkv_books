import 'package:flutter/material.dart';

class TituloLabel extends StatelessWidget {
  final String texto;
  final int numeroTitulo;
  double _tamanioFuente;
  TituloLabel({@required this.texto, @required this.numeroTitulo}) {
    switch (numeroTitulo) {
      case 1:
        _tamanioFuente = 28.0;
        break;
      case 2:
        _tamanioFuente = 18.0;
        break;
      default:
        _tamanioFuente = 12.0;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: TextStyle(
        fontSize: _tamanioFuente,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
