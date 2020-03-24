import 'package:flutter/widgets.dart';

class Router{
  // ver si funciona bien con los botones de retroceso <
  static void irHome(BuildContext context){
    Navigator.of(context).pushNamed('/');
  }

  static void irLogin(BuildContext context){
    Navigator.of(context).pushNamed('/login');
  }
  
  static void irRegistro(BuildContext context){
    Navigator.of(context).pushNamed('/registro');
  }

  static void irPerfil(BuildContext context){
    Navigator.of(context).pushNamed('/perfil');
  }

  static void irListaTotal(BuildContext context){
    Navigator.of(context).pushNamed('/lista_total');
  }

  static void irAgregarLibro(BuildContext context){
    Navigator.of(context).pushNamed('/agregar_libro');
  }

}