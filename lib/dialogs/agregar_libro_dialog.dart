import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/model/libro.dart';

Future agregarLibroDialog(BuildContext context) {
  

  void _cerrarDialog() {
    Sesion.libroAgregado.codUsuario = Sesion.usuarioLogeado.codUsuario;
    Navigator.pop(context);
  }

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Nuevo libro"),
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Nombre",
                ),
                onChanged: (nombre) {
                  print("nomnaaaaaaare");
                  Sesion.libroAgregado.nombre = nombre;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Autor",
                ),
                onChanged: (autor) {
                  Sesion.libroAgregado.autor = autor;
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Numero total de paginas",
                ),
                onChanged: (paginasTotales) {
                  Sesion.libroAgregado.paginasTotales = int.parse(paginasTotales);
                },
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Numero de paginas leidas",
                ),
                onChanged: (paginasLeidas) {
                  Sesion.libroAgregado.paginasLeidas = int.parse(paginasLeidas);
                },
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Agregar",
            ),
            onPressed: () => _cerrarDialog(),
          )
        ],
      );
    },
  );
}
