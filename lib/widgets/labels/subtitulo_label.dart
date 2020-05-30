import 'package:flutter/material.dart';

class SubtituloLabel extends StatelessWidget {
  final String texto;
  final int numeroTitulo;
  double _tamanioFuente;
  SubtituloLabel({@required this.texto, @required this.numeroTitulo}) {
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
    return Container();
  }
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
