import 'package:flutter/material.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/tkv_dialogs.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/widgets/inputPersonalizado.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';
import 'package:tkv_books/widgets/large_button.dart';
import 'package:tkv_books/widgets/page_background.dart';

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
    print("registro");
    return PageBackground(
      backgroundImagePath: "images/logo.jpg",
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            titulo1Label("Registro"),
            inputPrincipal("Nombre", nombres),
            inputPrincipal("Apellido", apellidos),
            inputPrincipal("Nickname", nickname),
            inputSecundario("Contraseña", contrasenia),
            LargeButton(
              nombre: "Crear cuenta",
              accion: _validarRegistro,
              primario: true,
            )
          ],
        ),
      ),
    );
  }

  _validarRegistro() {
    if (nombres.text == "")
      TkvDialogs.noHayNombreDialog(context);
    else if (nombres.text.length > 10)
      TkvDialogs.nombreLargoDialog(context);
    else if (apellidos.text == "")
      TkvDialogs.noHayApellido(context);
    else if (apellidos.text.length > 10)
      TkvDialogs.apellidoLargoDialog(context);
    else if (nickname.text == "")
      TkvDialogs.noHayNickname(context);
    else if (nickname.text.length > 12)
      TkvDialogs.nicknameLargoDialog(context);
    else if (nickname.text.length < 4)
      TkvDialogs.nicknameCortoDialog(context);
    else if (contrasenia.text == "")
      TkvDialogs.noHayContraseniaDialog(context);
    else if (contrasenia.text.length < 6)
      TkvDialogs.contraseniaCortaDialog(context);

    UsuarioDao.existeUsuarioByNickname(nickname.text).then(
      (yaExiste) {
        if (yaExiste) {
          TkvDialogs.nicknameYaExisteDialog(context);
        } else {
          _registrarUsuario();
        }
      },
    );
  }

  _registrarUsuario() {
    usuarioNuevo =
        Usuario(nombres.text, apellidos.text, nickname.text, contrasenia.text);
    // validad nickname no repetido ni con espacions
    UsuarioDao.postUsuario(usuarioNuevo).then(
      (value) {
        Sesion.usuarioLogeado = usuarioNuevo;
        Sesion.vieneDeRegistro = true;
        _irAperfil();
      },
    );
  }

  _irAperfil() {
    Navigator.of(context).pushNamed('/perfil');
  }
}
