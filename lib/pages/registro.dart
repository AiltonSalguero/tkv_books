import 'package:flutter/material.dart';
import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:flutter_aws_amplify_cognito/sign_in/identity_provider.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';
import 'package:tkv_books/dialogs/tkv_dialogs.dart';
import 'package:tkv_books/dialogs/validar_codigo_dialog.dart';
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
    print("SFFRGREG");
   
    print("registro");
    return PageBackground(
      backgroundImagePath: "images/logo.jpg",
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            titulo1Label("Registro"),
            inputPrincipal("Nombre completo", nombreCompleto),
            inputPrincipal("Nickname", nickname),
            InputEmail(
              texto: "Email",
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

  _validarRegistro() {
    if (nombreCompleto.text == "")
      TkvDialogs.noHayNombreDialog(context);
    else if (nombreCompleto.text.length > 10)
      TkvDialogs.nombreLargoDialog(context);
    else if (nombreCompleto.text == "")

      // TODO elimar apellido y agregar email
      TkvDialogs.noHayApellido(context);
    else if (nombreCompleto.text.length > 10)
      TkvDialogs.apellidoLargoDialog(context);
    else if (nickname.text == "")
      TkvDialogs.noHayNickname(context);
    else if (nickname.text.length > 12)
      TkvDialogs.nicknameLargoDialog(context);
    else if (nickname.text.length < 4)
      TkvDialogs.nicknameCortoDialog(context);
    else if (contrasenia.text == "")
      TkvDialogs.noHayContraseniaDialog(context);
    else if (contrasenia.text.length < 8)
      TkvDialogs.contraseniaCortaDialog(context);

    Map<String, String> userAttributes = Map<String, String>();
    userAttributes['email'] = email.text;
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
          TkvDialogs.nicknameYaExisteDialog(context);
        } else {
          _registrarUsuario();
        }
      },
    );
    */
  }

  _registrarUsuario() {
    usuarioNuevo = Usuario(
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
