import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/model/usuario.dart';

class RegistroCognito {
  iniciar() {
    FlutterAwsAmplifyCognito.initialize().then((UserStatus status) {
      switch (status) {
        case UserStatus.GUEST:
          print(status);
          break;
        case UserStatus.SIGNED_IN:
          print(status);
          break;
        case UserStatus.SIGNED_OUT:
          print(status);
          break;
        case UserStatus.SIGNED_OUT_FEDERATED_TOKENS_INVALID:
          print(status);
          break;
        case UserStatus.SIGNED_OUT_USER_POOLS_TOKENS_INVALID:
          print(status);
          break;
        case UserStatus.UNKNOWN:
          print(status);
          break;
        case UserStatus.ERROR:
          print(status);
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  registrarUsuario(Usuario usuario) {
    Map<String, dynamic> userAttributes = Map<String, dynamic>();
    userAttributes['email'] = usuario.email;
    FlutterAwsAmplifyCognito.signUp(
            usuario.nickname, Sesion.contraseniaRegistro, userAttributes)
        .then((SignUpResult result) {
      if (!result.confirmationState) {
        final UserCodeDeliveryDetails details = result.userCodeDeliveryDetails;
        print(details.destination);
      } else {
        print('Sign Up Done!');
      }
    }).catchError((error) {
      print(error);
    });
  }

  confirmarCodigo(String nickname, String codigo) {
    FlutterAwsAmplifyCognito.confirmSignUp(nickname, codigo)
        .then((SignUpResult result) {
      if (!result.confirmationState) {
        final UserCodeDeliveryDetails details = result.userCodeDeliveryDetails;
        print(details.destination);
      } else {
        print('Sign Up Done!');
      }
    }).catchError((error) {
      print(error);
    });
  }

  cambiarContrasenia(String nickname) {
    FlutterAwsAmplifyCognito.forgotPassword(nickname)
        .then((ForgotPasswordResult result) {
      switch (result.state) {
        case ForgotPasswordState.CONFIRMATION_CODE:
          print("Confirmation code is sent to reset password");
          break;
        case ForgotPasswordState.DONE:
          // TODO: Handle this case.
          break;
        case ForgotPasswordState.UNKNOWN:
          // TODO: Handle this case.
          break;
        case ForgotPasswordState.ERROR:
          // TODO: Handle this case.
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }

  confirmarCodigoCambioContrasenia(
      String nickname, String nuevaContrasenia, String codigoConfirmacion) {
    FlutterAwsAmplifyCognito.confirmForgotPassword(
            nickname, nuevaContrasenia, codigoConfirmacion)
        .then((ForgotPasswordResult result) {
      switch (result.state) {
        case ForgotPasswordState.DONE:
          print("Password changed successfully");
          break;
        case ForgotPasswordState.UNKNOWN:
          // TODO: Handle this case.
          break;
        case ForgotPasswordState.ERROR:
          // TODO: Handle this case.
          break;
        case ForgotPasswordState.CONFIRMATION_CODE:
          // TODO: Handle this case.
          break;
      }
    }).catchError((error) {
      print(error);
    });
  }
}
