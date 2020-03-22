import 'package:flutter/widgets.dart';

class Router{
  void irHome(BuildContext context){
    Navigator.of(context).pushNamed('/');
  }

  void irLogin(BuildContext context){
    Navigator.of(context).pushNamed('/login');
  }
  
  void irRegistro(BuildContext context){
    Navigator.of(context).pushNamed('/registro');
  }

  void irPerfil(BuildContext context){
    Navigator.of(context).pushNamed('/perfil');
  }
  void irListaTotal(BuildContext context){
    Navigator.of(context).pushNamed('/lista_total');
  }
  void irAgregarLibro(BuildContext context){
    Navigator.of(context).pushNamed('/agregar_libro');
  }

}