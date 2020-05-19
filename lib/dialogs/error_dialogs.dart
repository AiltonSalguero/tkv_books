import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';

class ErrorDialogs {
  static nicknameYaExisteDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Nickname ya existe",
      content: "Escriba un nuevo nickname",
      rightText: "Ok",
    ).build(context);
  }
}
