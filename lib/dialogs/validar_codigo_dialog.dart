import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/cognito/registro_cognito.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/widgets/inputs/rounded_input.dart';

/*
  Dialog que aparece para que escriba el codigo de validacion
  Por limpiar
*/
class ValidarCodigoDialog {
  final _formKey = GlobalKey<FormState>();
  final _codigo = TextEditingController();
  BuildContext context;
  ValidarCodigoDialog({@required this.context});

  Future<void> build() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Validar codigo"),
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
                  inputDialogText("Código", _codigo, "Ingrese el código"),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Reenviar",
              ),
              onPressed: _reenviarCodigo,
            ),
            FlatButton(
              child: Text(
                "OK",
              ),
              onPressed: _validarCodigo,
            )
          ],
        );
      },
    );
  }

  _reenviarCodigo() {
    RegistroCognito.reenviarCodigo();
  }

  _validarCodigo() {
    RegistroCognito.validarCodigo();
  }

  _registrarUsuario(context) {
    UsuarioDao.postUsuario(Sesion.usuarioRegistro).then((value) {
      _iniciarSesion();
      _irAperfil();
    });
  }

  _iniciarSesion() {
    Sesion.usuarioLogeado = Sesion.usuarioRegistro;
  }

  _irAperfil() {
    Navigator.of(context).pushNamed('/perfil');
  }
}
