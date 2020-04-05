import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/widgets/botonPersonalizado.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Sesion.librosDelUsuario.lista = List<Libro>();
    Screen.width = MediaQuery.of(context).size.width;
    Screen.height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background_nubes.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: Screen.height * 0.05,
              ),
              Image.asset("images/logo_sin_nubes_v2.jpg"),
              _loginButton(),
              _registroButton(),
              Text(
                "#SimiosJuntosFuertes",
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginButton() {
    return botonPrincipal(_loginButtonAccion, "Login");
  }

  _loginButtonAccion() {
    Navigator.of(context).pushNamed('/login');
  }

  Widget _registroButton() {
    return botonSecundario(_registerButtonAccion, "Registro");
  }

  _registerButtonAccion() {
    Navigator.of(context).pushNamed('/registro');
  }
}
