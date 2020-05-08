import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
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
     FlutterAwsAmplifyCognito.initialize().then((UserStatus status) {
      switch (status) {
        case UserStatus.GUEST:
          break;
        case UserStatus.SIGNED_IN:
          print("1");
          break;
        case UserStatus.SIGNED_OUT:
          print("2");
          break;
        case UserStatus.SIGNED_OUT_FEDERATED_TOKENS_INVALID:
          print("3");
          break;
        case UserStatus.SIGNED_OUT_USER_POOLS_TOKENS_INVALID:
          print("4");
          break;
        case UserStatus.UNKNOWN:
          print("5");
          break;
        case UserStatus.ERROR:
          print("6");
          break;
      }
    }).catchError((error) {
      print(error);
    });
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
