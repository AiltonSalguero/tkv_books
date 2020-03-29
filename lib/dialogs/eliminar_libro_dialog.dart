import 'package:flutter/material.dart';
import 'package:tkv_books/util/confirmAction.dart';



Future<ConfirmAction> eliminarLibroDialog(BuildContext context) {
  // Opcion con varios idiomas
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Eliminar libro?"),
        content:
            const Text("Quieres eliminarlo así como ella te eliminó de su vida?"),
        actions: <Widget>[
          FlatButton(
            child: const Text("No, bro"),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: const Text("Si :,("),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}

