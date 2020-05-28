import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/widgets/inputs/rounded_input.dart';

/*
  

  Por limpiar
*/

Future<void> agregarLibroDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();

  final _nombre = TextEditingController();
  final _autor = TextEditingController();
  final _paginasLeidas = TextEditingController();
  final _paginasTotales = TextEditingController();

  _guardarDatos() {
    Sesion.libroAgregado.codLibro = 1;
    Sesion.libroAgregado.codUsuario = Sesion.usuarioLogeado.codUsuario;
    Sesion.libroAgregado.nombre = _nombre.text;
    Sesion.libroAgregado.autor = _autor.text;
    Sesion.libroAgregado.paginasLeidas = int.parse(_paginasLeidas.text);
    Sesion.libroAgregado.paginasTotales = int.parse(_paginasTotales.text);
    Sesion.libroAgregado.nicknameUsuario = Sesion.usuarioLogeado.nickname;

    // aumentar puntaje y level en sesion y DB
  }

  _cerrarDialog() {
    Navigator.pop(context);
  }

  _validarDatos() {
    print(_nombre.text);
    if (_formKey.currentState.validate()) {
      if (int.parse(_paginasLeidas.text) > int.parse(_paginasTotales.text)) {
        _paginasLeidas.text = null;
        _paginasTotales.text = null;

        if (_formKey.currentState.validate()) {
          print("validado2");
        }
      } else {
        print("validado");
        if (Sesion.usuarioLogeado.codUsuario == 0) {
          UsuarioDao.getUsuarioByNickname(Sesion.usuarioLogeado.nickname)
              .then((user) {
            print(user.toJson());
            Sesion.usuarioLogeado = user;
            _guardarDatos();
            _cerrarDialog();
          });
        } else {
          _guardarDatos();
          _cerrarDialog();
        }
      }
    }
  }

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
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
                inputDialogText("Nombre", _nombre, "Ingrese un nombre"),
                inputDialogText("Autor", _autor, "Ingrese un autor"),
                inputDialogNumber("Paginas leidas", _paginasLeidas,
                    "Paginas leidas deben ser menores a las paginas totales"),
                inputDialogNumber("Paginas totales", _paginasTotales,
                    "Ingrese el numero total de paginas"),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Cancelar",
            ),
            onPressed: () => _cerrarDialog(),
          ),
          FlatButton(
            child: Text(
              "Agregar",
            ),
            onPressed: () => _validarDatos(),
          )
        ],
      );
    },
  );
}
