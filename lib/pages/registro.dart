import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:flutter_aws_amplify_cognito/sign_in/identity_provider.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';
import 'package:tkv_books/dialogs/validar_codigo_dialog.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/widgets/buttons/large_button.dart';
import 'package:tkv_books/widgets/inputs/inputPersonalizado.dart';
import 'package:tkv_books/widgets/labels/labelPerzonalizado.dart';
import 'package:tkv_books/widgets/page_background.dart';

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  Usuario usuarioNuevo;
  final nombreCompleto = TextEditingController();
  final nickname = TextEditingController();
  final email = TextEditingController();
  final contrasenia = TextEditingController();

  @override
  void dispose() {
    // Limpia los controlodadores
    nombreCompleto.dispose();
    email.dispose();
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
          children: <Widget>[
            titulo1Label("Registro"),
            inputPrincipal("Nombre completo", nombreCompleto),
            inputPrincipal("Nickname", nickname),
            InputEmail(
              texto: "Correo electrónico",
              controller: email,
            ),
            inputContrasenia("Contraseña", contrasenia),
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

  _validarCampos() {
    String tituloDialog;
    String contenidoDialog;
    bool errorCampos = false;
    if (nickname.text.isEmpty ||
        email.text.isEmpty ||
        contrasenia.text.isEmpty ||
        nombreCompleto.text.isEmpty) {
      errorCampos = true;
      tituloDialog = "Campo incompleto";
      if (nickname.text.isEmpty) contenidoDialog = "Escriba un nickname";
      if (email.text.isEmpty) contenidoDialog = "Escriba un email";
      if (nombreCompleto.text.isEmpty) contenidoDialog = "Escriba un nombre";
      if (contrasenia.text.isEmpty) contenidoDialog = "Escriba una contrasenia";
    }
    if (nickname.text.length > 12 || nombreCompleto.text.length > 12) {
      errorCampos = true;
      tituloDialog = "Campo muy largo";
      if (nickname.text.length > 12)
        contenidoDialog = "Escriba un nickname más corto";
      if (nombreCompleto.text.length > 12)
        contenidoDialog = "Escriba un nombre más corto";
    }

    if (nickname.text.length < 4 || contrasenia.text.length < 8) {
      errorCampos = true;
      tituloDialog = "Campo muy corto";
      if (nickname.text.length < 4)
        contenidoDialog = "Escriba un nickname más largo";
      if (contrasenia.text.length < 8)
        contenidoDialog = "Escriba una contraseña más larga";
    }

    if (errorCampos) {
      SimpleDialogTkv(
        title: tituloDialog,
        content: contenidoDialog,
        rightText: "Ok",
      ).build(context);
    }
  }

  _validarRegistro() {
    _validarCampos();
    // Cuando no sale el error dialog
    Map<String, dynamic> userAttributes = Map<String, dynamic>();
    userAttributes['email'] = email.text;
    userAttributes['level'] = 1;
    userAttributes['puntaje'] = 0;
    userAttributes['nombreCompleto'] = "Julio Roman";
    Sesion.usuarioLogeado.nickname = nickname.text;
    validarCodigoDialog(context);
    /*
    FlutterAwsAmplifyCognito.signUp(
            nickname.text, contrasenia.text, userAttributes)
        .then((SignUpResult result) {
      if (!result.confirmationState) {
        final UserCodeDeliveryDetails details = result.userCodeDeliveryDetails;
        print(details.destination);
        
        // TODO mostrar dialog para que ingrese codigo
      } else {
        print('Sign Up Done!');
      }
    }).catchError((error) {
      print(error);
    });

    */
    /*
    UsuarioDao.existeUsuarioByNickname(nickname.text).then(
      (yaExiste) {
        if (yaExiste) {
          ErrorDialogs.nicknameYaExisteDialog(context);
        } else {
          _registrarUsuario();
        }
      },
    );
    */
  }

  _registrarUsuario() {
    Sesion.usuarioRegistro = Usuario(
        nombreCompleto.text, nickname.text, email.text, contrasenia.text);
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
