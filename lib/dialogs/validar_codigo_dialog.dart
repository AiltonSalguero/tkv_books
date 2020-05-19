import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/cognito/registro_cognito.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/widgets/inputPersonalizado.dart';

/*


  Por limpiar
*/
Future<void> validarCodigoDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final _codigo = TextEditingController();

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
            onPressed:
                RegistroCognito.reenviarCodigo(Sesion.usuarioRegistro.nickname),
          ),
          FlatButton(
            child: Text(
              "OK",
            ),
            onPressed: _validarCodigo(context),
          )
        ],
      );
    },
  );
}

_cerrarDialog(BuildContext context) {
  Navigator.pop(context);
}

_irAPerfil(BuildContext context) {
  Navigator.of(context).pushNamed('/perfil');
}

_validarCodigo(BuildContext context) {
  //_cerrarDialog();
  _irAPerfil(context);
  /*FlutterAwsAmplifyCognito.confirmSignUp(
            Sesion.usuarioLogeado.nickname, _codigo.text)
        .then((SignUpResult result) {
      if (!result.confirmationState) {
        final UserCodeDeliveryDetails details = result.userCodeDeliveryDetails;
        print(details.destination);
      } else {
        _cerrarDialog();
        _irAPerfil();
      }
    }).catchError((error) {
      print(error);
    });*/
}
