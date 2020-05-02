import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';

class TkvDialogs {
  static noHayNombreDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Campo incompleto",
      content: "Escriba un nombre",
      rightText: "Ok",
    ).build(context);
  }

  static nombreLargoDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Nombre muy largo",
      content: "Escriba un nombre más corto",
      rightText: "Ok",
    ).build(context);
  }

  static noHayApellido(BuildContext context) {
    SimpleDialogTkv(
      title: "Campo incompleto",
      content: "Escriba un apellido",
      rightText: "Ok",
    ).build(context);
  }

  static apellidoLargoDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Apellido muy largo",
      content: "Escriba un apellido mmás corto",
      rightText: "Ok",
    ).build(context);
  }

  static noHayNickname(BuildContext context) {
    SimpleDialogTkv(
      title: "Campo incompleto",
      content: "Escriba un nickname",
      rightText: "Ok",
    ).build(context);
  }

  static nicknameLargoDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Nickname muy largo",
      content: "Escriba un nickname más corto",
      rightText: "Ok",
    ).build(context);
  }

  static nicknameCortoDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Nickname muy corto",
      content: "Escriba un nickname más corto",
      rightText: "Ok",
    ).build(context);
  }

  static noHayContraseniaDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Campo incompleto",
      content: "Escriba una contraseña",
      rightText: "Ok",
    ).build(context);
  }

  static contraseniaCortaDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Contrasenia debil",
      content: "Escriba una contraseña con más de 6 caracteres",
      rightText: "Ok",
    ).build(context);
  }

  static nicknameYaExisteDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Nickname ya existe",
      content: "Escriba un nuevo nickname",
      rightText: "Ok",
    ).build(context);
  }

  static eliminarLibroDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "¿Eliminar libro?",
      content: "Al eliminarlo se disminuirá el puntaje ganado.",
      leftText: "No",
      rightText: "Si",
    ).build(context);
  }

  static limiteSuperadoDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Limite superado",
      content:
          "Adquiera la versión premium por 5 soles para agregar más libros",
      leftText: ":(",
      rightText: "Comprar rai nau",
    ).build(context);
  }

  static levelUpDialog(BuildContext context) {
    SimpleDialogTkv(
      title: "Subiste de nivel!",
      content: "Ahora eres Lv. ${Sesion.usuarioLogeado.level}",
      rightText: ":D",
    ).build(context);
  }
}
