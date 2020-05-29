import 'package:flutter/material.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';

class ErrorCognitoDialog {
  var error;
  BuildContext context;
  String _tituloDialog = "Error";
  String _contenidoDialog = "Error desconocido";
  ErrorCognitoDialog({@required this.error, @required this.context});

  build() {
    _completarCampos();
    return SimpleDialogTkv(
      title: _tituloDialog,
      content: _contenidoDialog,
      rightText: "Ok",
    ).build(context);
  }

  _completarCampos() {
    print(error.message);
    print(error.details);
    if (error.details.contains("User already exists")) {
      _tituloDialog = "Nickname ya existente";
      _contenidoDialog = "Escriba otro nickname";
    }
    if (error.details.contains("User does not exist")) {
      _tituloDialog = "Nickname incorrecto";
      _contenidoDialog = "Escriba un nickname existente.";
    }
    if (error.details.contains("Incorrect username or password")) {
      _tituloDialog = "Datos incorrectos";
      _contenidoDialog = "Vuelva a el nickname y la contraseña.";
    }
    if (error.details.contains("Failed to authenticate user")) {
      _tituloDialog = "Contraseña incorrecta";
      _contenidoDialog = "Vuelva a escribir la contraseña.";
    }
  }
}
