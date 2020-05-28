import 'package:flutter/material.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';

class ErrorDialog {
  var error;
  BuildContext context;
  ErrorDialog({@required this.error, @required this.context});
  build() {
    String tituloDialog = "Error";
    String contenidoDialog = "Error desconocido";
    print(error.message);
    print(error.details);
    if (error.details.contains("User already exists")) {
      tituloDialog = "Nickname ya existente";
      contenidoDialog = "Escriba otro nickname";
    }

    return SimpleDialogTkv(
      title: tituloDialog,
      content: contenidoDialog,
      rightText: "Ok",
    ).build(context);
  }
}
