import 'package:flutter/material.dart';
import 'package:tkv_books/cognito/registro_cognito.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/widgets/buttons/large_button.dart';

/*
  Vista de la pagina principal de la app
*/
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // super.initState();
    Sesion.iniciarDatos();

    // Inicia cognito
    RegistroCognito.iniciar();
  }

  @override
  Widget build(BuildContext context) {
    print("home");
    Sesion.contextActual = context;
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
            children: <Widget>[
              SizedBox(
                height: Screen.height * 0.05,
              ),
              Image.asset("images/logo_sin_nubes_v2.jpg"),
              LargeButton(
                nombre: "Login",
                accion: _irALogin,
                primario: true,
              ),
              LargeButton(
                nombre: "Registro",
                accion: _irAregistro,
                primario: false,
              ),
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

  _irAregistro() {
    Navigator.of(context).pushNamed('/registro');
  }

  _irALogin() {
    Navigator.of(context).pushNamed('/login');
  }
}
