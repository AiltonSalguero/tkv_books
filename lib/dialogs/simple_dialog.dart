import 'package:flutter/material.dart';

enum ConfirmAction { CANCEL, ACCEPT }

class SimpleDialogTkv {
  final String title;
  final String content;
  final String leftText;
  @required
  final String rightText;

  const SimpleDialogTkv(
      {this.title, this.content, this.leftText, this.rightText});

  build(BuildContext context) {
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
                    onPressed: () {
                      Navigator.of(context).pop(ConfirmAction.CANCEL);
                    },
                  )
                : null,
            FlatButton(
              child: Text(rightText),
              onPressed: () {
                Navigator.of(context).pop(ConfirmAction.ACCEPT);
              },
            ),
          ],
        );
      },
    );
  }
}
