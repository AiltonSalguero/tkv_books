import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/error_dialog.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/widgets/botonPersonalizado.dart';
import 'package:tkv_books/widgets/inputPersonalizado.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  Usuario usuarioNuevo;
  final nombres = TextEditingController();
  final apellidos = TextEditingController();
  final nickname = TextEditingController();
  final contrasenia = TextEditingController();

  @override
  void dispose() {
    // Limpia los controlodadores
    nombres.dispose();
    apellidos.dispose();
    nickname.dispose();
    contrasenia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topLeft,
        children: <Widget>[
          Image.asset(
            "images/logo.jpg",
            fit: BoxFit.cover,
            height: Screen.height * 0.35, // Responsive
            width: double.infinity,
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.0),
                topLeft: Radius.circular(32.0),
              ),
              border: Border.all(
                color: Colors.black,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 32.0,
                ),
              ],
              color: Color(0xfffafafa),
            ),
            margin: EdgeInsets.only(
              top: Screen.height * 0.3, // Responsive 266
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    titulo1Label("Registro"),
                    inputPrincipal("Nombre", nombres),
                    inputPrincipal("Apellido", apellidos),
                    inputPrincipal("Nickname", nickname),
                    inputSecundario("Contraseña", contrasenia),
                    _registrarButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registrarButton() {
    return botonPrincipal(_validarRegistro, "Crear cuenta");
  }

  _validarRegistro() {
    if (nombres.text == "")
      return errorLoginDialog(context, "Campo incompleto", "Escriba un nombre");
    if (nombres.text.length > 10)
      return errorLoginDialog(context, "Nombre muy largo",
          "Escriba un nombre con menos de 10 caracteres");
    if (apellidos.text == "")
      return errorLoginDialog(
          context, "Campo incompleto", "Escriba un apellido");
    if (apellidos.text.length > 10)
      return errorLoginDialog(context, "Apellido muy largo",
          "Escriba un apellido con menos de 10 caracteres");
    if (nickname.text == "")
      return errorLoginDialog(
          context, "Campo incompleto", "Escriba un nickname");
    if (nickname.text.length > 12)
      return errorLoginDialog(context, "Nickname muy largo",
          "Escriba un nickname con menos de 12 caracteres");
    if (nickname.text.length < 4)
      return errorLoginDialog(context, "Nickname muy corto",
          "Escriba un nickname con más de 3 caracteres");
    if (contrasenia.text == "") {
      return errorLoginDialog(
          context, "Campo incompleto", "Escriba una contraseña");
    } else {
      if (contrasenia.text.length < 6)
        return errorLoginDialog(context, "Contrasenia debil",
            "Escriba una contraseña con más de 6 caracteres");
    }

    UsuarioDao.existeUsuarioByNickname(nickname.text).then((yaExiste) {
      if (yaExiste) {
        return errorLoginDialog(
            context, "Nickname ya existe", "Escriba un nuevo nickname");
      } else {
        usuarioNuevo = Usuario(
            nombres.text, apellidos.text, nickname.text, contrasenia.text);
        // validar datos
        // validad nickname no repetido ni con espacions
        // validar contrasenia mayor a 6 caracteres
        // validar que todos los campos esten llenos

        print(usuarioNuevo.toJson());
        UsuarioDao.postUsuario(usuarioNuevo).then((value) {
          Sesion.usuarioLogeado = usuarioNuevo;
          Sesion.vieneDeRegistro = true;
          Navigator.of(context).pushNamed('/perfil');
        });
      }
    });
  }
}
