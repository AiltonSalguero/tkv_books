import 'package:flutter/material.dart';

enum ConfirmAction { ACCEPT }

Future<ConfirmAction> ErrorLoginDialog(BuildContext context) {
  // Opcion con varios idiomas
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Usuario incorrecto"),
        content: Text("Escribe bien los datos gaa"),
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
