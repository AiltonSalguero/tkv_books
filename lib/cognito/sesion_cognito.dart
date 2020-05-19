import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';

class SesionCognito {
  logearUsuario(String nickname, String contrasenia) {
    FlutterAwsAmplifyCognito.signIn(nickname, contrasenia)
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

  getNickname() {
    FlutterAwsAmplifyCognito.getUsername().then((username) {
      print('username is $username');
    }).catchError((error) {
      print(error);
    });
  }

  getIdentityId() {
    FlutterAwsAmplifyCognito.getIdentityId().then((identityId) {
      print('Identity ID is $identityId');
    }).catchError((error) {
      print(error);
    });
  }

  getDatosUsuario() {
    FlutterAwsAmplifyCognito.getUserAttributes().then((userDetails) {
      print('$userDetails');
    }).catchError((error) {
      print(error);
    });
  }

  cerrarSesionEnDispositivo() {
    FlutterAwsAmplifyCognito.signOut().then((value) {
      print('Signed Out successfully');
    }).catchError((error) {
      print(error);
    });
  }

  cerrarSesionTodosDispositivos() {
    FlutterAwsAmplifyCognito.signOutGlobally().then((value) {
      print('Signed Out successfully');
    }).catchError((error) {
      print(error);
    });
  }

  estaLogeado() {
    FlutterAwsAmplifyCognito.isSignedIn().then((isSignedIn) {
      print("Is user signed in?: $isSignedIn");
    }).catchError((error) {
      print(error);
    });
  }
}
