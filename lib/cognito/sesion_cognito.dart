import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/dao/sesion.dart';

class SesionCognito {
  static iniciarSesion() {
    FlutterAwsAmplifyCognito.signIn(
            Sesion.usuarioLogeado.nickname, Sesion.contraseniaUsuario)
        .then((SignInResult result) {
      switch (result.signInState) {
        case SignInState.SMS_MFA:
          // TODO: Handle this case.
          break;
        case SignInState.PASSWORD_VERIFIER:
          // TODO: Handle this case.
          break;
        case SignInState.CUSTOM_CHALLENGE:
          // TODO: Handle this case.
          break;
        case SignInState.DEVICE_SRP_AUTH:
          // TODO: Handle this case.
          break;
        case SignInState.DEVICE_PASSWORD_VERIFIER:
          // TODO: Handle this case.
          break;
        case SignInState.ADMIN_NO_SRP_AUTH:
          // TODO: Handle this case.
          break;
        case SignInState.NEW_PASSWORD_REQUIRED:
          // TODO: Handle this case.
          break;
        case SignInState.DONE:
          // TODO: Handle this case.
          break;
        case SignInState.UNKNOWN:
          // TODO: Handle this case.
          break;
        case SignInState.ERROR:
          // TODO: Handle this case.
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  static getNickname() {
    FlutterAwsAmplifyCognito.getUsername().then((username) {
      print('username is $username');
    }).catchError((error) {
      print(error);
    });
  }

  static getIdentityId() {
    FlutterAwsAmplifyCognito.getIdentityId().then((identityId) {
      print('Identity ID is $identityId');
    }).catchError((error) {
      print(error);
    });
  }

  static getDatosUsuario() {
    FlutterAwsAmplifyCognito.getUserAttributes().then((userDetails) {
      print('$userDetails');
    }).catchError((error) {
      print(error);
    });
  }

  static cerrarSesionEnDispositivo() {
    FlutterAwsAmplifyCognito.signOut().then((value) {
      print('Signed Out successfully');
    }).catchError((error) {
      print(error);
    });
  }

  static cerrarSesionTodosDispositivos() {
    FlutterAwsAmplifyCognito.signOutGlobally().then((value) {
      print('Signed Out successfully');
    }).catchError((error) {
      print(error);
    });
  }

  static estaLogeado() {
    FlutterAwsAmplifyCognito.isSignedIn().then((isSignedIn) {
      print("Is user signed in?: $isSignedIn");
    }).catchError((error) {
      print(error);
    });
  }

  static cerrarSesion() {
    FlutterAwsAmplifyCognito.signOut().then((value) {
      Sesion.reiniciarDatos();
    }).catchError((error) {});
  }
}
