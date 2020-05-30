import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/widgets/inputs/dialog_input.dart';

/*
  
  Por limpiar
*/
class AgregarLibroDialog {
  BuildContext context;

  final _formKey = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _autor = TextEditingController();
  final _paginasLeidas = TextEditingController();
  final _paginasTotales = TextEditingController();
  AgregarLibroDialog({@required this.context});

  build() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text("Nuevo libro"),
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Colors.black,
                width: 2.0,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  28.0,
                ),
              ),
            ),
            content: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    DialogInput(
                      texto: "Nombre",
                      textoAdvertencia: "Ingrese un nombre",
                      controlador: _nombre,
                    ),
                    DialogInput(
                      texto: "Autor",
                      textoAdvertencia: "Ingrese un autor",
                      controlador: _autor,
                    ),
                    DialogInput(
                      texto: "Páginas leidas",
                      textoAdvertencia:
                          "Páginas leidas deben ser menores a las paginas totales",
                      controlador: _paginasLeidas,
                      tecladoTipo: TextInputType.number,
                    ),
                    DialogInput(
                      texto: "Páginas totales",
                      textoAdvertencia: "Ingrese el numero total de paginas",
                      controlador: _paginasTotales,
                      tecladoTipo: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancelar",
                ),
                onPressed: _cerrarDialog,
              ),
              FlatButton(
                child: Text(
                  "Agregar",
                ),
                onPressed: _validarDatos,
              )
            ],
          );
        });
      },
    );
  }

  _cerrarDialog() {
    Navigator.pop(context);
  }

  _validarDatos() {
    if (_formKey.currentState.validate()) {
      if (int.parse(_paginasLeidas.text) > int.parse(_paginasTotales.text)) {
        _paginasLeidas.text = null;
        _paginasTotales.text = null;
      } else {
        _guardarDatos();
        _cerrarDialog();
      }
    }
  }

  _guardarDatos() {
    Sesion.libroAgregado.codLibro = 1;
    Sesion.libroAgregado.codUsuario = Sesion.usuarioLogeado.codUsuario;
    Sesion.libroAgregado.nombre = _nombre.text;
    Sesion.libroAgregado.autor = _autor.text;
    Sesion.libroAgregado.paginasLeidas = int.parse(_paginasLeidas.text);
    Sesion.libroAgregado.paginasTotales = int.parse(_paginasTotales.text);
    Sesion.libroAgregado.nicknameUsuario = Sesion.usuarioLogeado.nickname;
  }
}
