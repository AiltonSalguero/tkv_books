import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/cognito/registro_cognito.dart';
import 'package:tkv_books/cognito/sesion_cognito.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/widgets/inputs/rounded_input.dart';
import 'package:tkv_books/widgets/labels/labelPerzonalizado.dart';

/*
  Dialog que aparece para que escriba el codigo de validacion
  Por limpiar
*/
class ValidarCodigoDialog {
  final _formKey = GlobalKey<FormState>();
  final _codigo = TextEditingController();
  BuildContext context;
  ValidarCodigoDialog({@required this.context});
  // TODO mensaje que muestre errores o info dentro del dialog
  Future<void> build() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                      titulo3Label(Sesion.errorValidacion),
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
                  onPressed: () {
                    setState(() {
                      _reenviarCodigo();
                    });
                  },
                ),
                FlatButton(
                  child: Text(
                    "OK",
                  ),
                  onPressed: () {
                    setState(() {
                      _validarCodigo();
                    });
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  _reenviarCodigo() {
    Sesion.errorValidacion = "Escriba el codigo que se le ha sido reenviado.";
    _codigo.text = "";
    RegistroCognito.reenviarCodigo();
  }

  _validarCodigo() {
    Sesion.codigoValidacion = _codigo.text;
    RegistroCognito.validarCodigo();
    if (Sesion.codigoValidado) {
      Sesion.usuarioLogeado = Sesion.usuarioRegistro;
      SesionCognito.iniciarSesion();
    }
  }

  _registrarUsuario() {
    Sesion.usuarioLogeado = Sesion.usuarioRegistro;
    UsuarioDao.postUsuario(Sesion.usuarioRegistro).then((value) {
      SesionCognito.iniciarSesion();
      _irAperfil();
    });
  }

  _irAperfil() {
    Navigator.of(context).pushNamed('/perfil');
  }
}
