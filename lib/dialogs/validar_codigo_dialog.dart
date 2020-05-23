import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/widgets/inputs/inputPersonalizado.dart';

/*


  Por limpiar
*/
class ValidarCodigo {
  final _formKey = GlobalKey<FormState>();
  final _codigo = TextEditingController();

  Future<void> dialog(BuildContext context) {
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
                onPressed: _reenviarCodigo),
            FlatButton(
              child: Text(
                "OK",
              ),
              onPressed: () => _validarCodigo(context),
            )
          ],
        );
      },
    );
  }

  _reenviarCodigo() {
    FlutterAwsAmplifyCognito.resendSignUp(Sesion.usuarioRegistro.nickname)
        .then((SignUpResult result) {
      print("codigo reenviado");
    }).catchError((error) {
      print(error);
    });
  }

  _validarCodigo(BuildContext context) {
    FlutterAwsAmplifyCognito.confirmSignUp(
            Sesion.usuarioRegistro.nickname, _codigo.text)
        .then((SignUpResult result) {
      if (!result.confirmationState) {
        final UserCodeDeliveryDetails details = result.userCodeDeliveryDetails;
        print(details.destination);
      } else {
        _registrarUsuario(context);
      }
    }).catchError((error) {
      print(error);
    });
  }

  _registrarUsuario(context) {
    UsuarioDao.postUsuario(Sesion.usuarioRegistro).then((value) {
      _iniciarSesion();
      _irAperfil(context);
    });
  }

  _iniciarSesion() {
    Sesion.usuarioLogeado = Sesion.usuarioRegistro;
  }

  _cerrarDialog(BuildContext context) {
    Navigator.pop(context);
  }

  _irAperfil(BuildContext context) {
    Navigator.of(context).pushNamed('/perfil');
  }
}
