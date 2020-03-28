import 'package:flutter/material.dart';
import 'package:tkv_books/util/router.dart';
import 'package:tkv_books/widgets/botonPersonalizado.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5CC5E5),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/logo.jpg"),
            _loginButton(),
            _registroButton(),
            Text(
              "#SimiosJuntosFuertes",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ],
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
