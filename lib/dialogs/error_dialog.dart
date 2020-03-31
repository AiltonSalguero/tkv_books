import 'package:flutter/material.dart';
import 'package:tkv_books/util/confirmAction.dart';

Future<ConfirmAction> errorLoginDialog(
    BuildContext context, String titulo, String contenido) {
  // Opcion con varios idiomas
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
        content: Text(contenido),
        actions: <Widget>[
          FlatButton(
            child: Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}