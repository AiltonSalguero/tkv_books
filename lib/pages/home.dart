import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/widgets/large_button.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future main() async {
    DotEnv().load('config.env');
    Screen.width = MediaQuery.of(context).size.width;
    Screen.height = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    print("home");

    main();
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
                navegarA: _irALogin,
                primario: true,
              ),
              LargeButton(
                nombre: "Registro",
                navegarA: _irAregistro,
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
