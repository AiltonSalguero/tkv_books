import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/util/confirmAction.dart';
import 'package:tkv_books/widgets/inputPersonalizado.dart';


Future<ConfirmAction> editarLibroDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  final nombre = TextEditingController();
  final autor = TextEditingController();
  final paginasLeidas = TextEditingController();
  final paginasTotales = TextEditingController();

  void _cerrarDialog() {
    Sesion.libroAgregado.codUsuario = Sesion.usuarioLogeado.codUsuario;
    Sesion.libroAgregado.nombre = nombre.text;
    Sesion.libroAgregado.autor = autor.text;
    Sesion.libroAgregado.paginasLeidas = int.parse(paginasLeidas.text);
    Sesion.libroAgregado.paginasTotales = int.parse(paginasTotales.text);
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                inputDialogText("Nombre", nombre),
                inputDialogText("Autor", autor),
                inputDialogNumber("Paginas leidas", paginasLeidas),
                inputDialogNumber("Paginas totales", paginasTotales),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Cancelar",
            ),
            onPressed: () => Navigator.pop(context),
          ),
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
