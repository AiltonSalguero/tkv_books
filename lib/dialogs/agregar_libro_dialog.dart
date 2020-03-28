import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';

Future agregarLibroDialog(BuildContext context) {
  void _cerrarDialog() {
    Sesion.libroAgregado.codUsuario = Sesion.usuarioLogeado.codUsuario;
    Sesion.libroAgregado.paginasLeidas < Sesion.libroAgregado.paginasTotales
        ? Navigator.pop(context)
        : null;
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
              TextFormField(
                decoration: InputDecoration.collapsed(hintText: "Nombre"),
                validator: (value) {
                  if (value.isEmpty) return "Ingrese el nombre";
                },
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Nombre",
                ),
                onChanged: (nombre) {
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
                  Sesion.libroAgregado.paginasTotales =
                      int.parse(paginasTotales);
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
