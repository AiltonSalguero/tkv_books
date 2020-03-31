import 'package:flutter/material.dart';
import 'package:tkv_books/util/confirmAction.dart';

Future<ConfirmAction> alertaDialog(BuildContext context, String titulo,
    String contenido, String cancel, String aceptar) {
  // Opcion con varios idiomas
  return showDialog<ConfirmAction>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titulo),
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
        content: Text(contenido),
        actions: <Widget>[
          FlatButton(
            child: Text(cancel),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.CANCEL);
            },
          ),
          FlatButton(
            child: Text(aceptar),
            onPressed: () {
              Navigator.of(context).pop(ConfirmAction.ACCEPT);
            },
          )
        ],
      );
    },
  );
}
