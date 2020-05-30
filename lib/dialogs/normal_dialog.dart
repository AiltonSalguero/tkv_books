import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';

class NormalDialog {
  final BuildContext context;
  final String title;
  final String content;
  final String leftText;
  final String rightText;

  const NormalDialog(
      {@required this.context,
      @required this.title,
      @required this.content,
      this.leftText,
      @required this.rightText});

  build() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
          content: Text(content),
          actions: <Widget>[
            leftText != null
                ? FlatButton(
                    child: Text(leftText),
                    onPressed: _cerrarDialog,
                  )
                : null,
            FlatButton(child: Text(rightText), onPressed: _aceptarDialog),
          ],
        );
      },
    );
  }

  _aceptarDialog() {
    Navigator.of(context).pop(ConfirmAction.ACCEPT);
  }

  _cerrarDialog() {
    Navigator.of(context).pop(ConfirmAction.CANCEL);
  }
}
