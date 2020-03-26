import 'package:flutter/material.dart';

enum ConfirmAction { CANCEL, ACCEPT }

Future<ConfirmAction> EliminarLibroDialog(BuildContext context) {
  // Opcion con varios idiomas
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Eliminar libro?"),
        content:
            const Text("Se eliminara el libro de su perfil permanentemente"),
        actions: <Widget>[
          FlatButton(
            child: const Text("Cancel"),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text("Aceptar"),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
