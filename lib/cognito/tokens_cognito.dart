import 'package:flutter_aws_amplify_cognito/flutter_aws_amplify_cognito.dart';

class TokensCognito {
  getTokens() {
    FlutterAwsAmplifyCognito.getTokens().then((Tokens tokens) {
      print('Access Token: ${tokens.accessToken}');
      print('ID Token: ${tokens.idToken}');
      print('Refresh Token: ${tokens.refreshToken}');
    }).catchError((error) {
      print(error);
    });
  }

  getIdToken() {
    FlutterAwsAmplifyCognito.getIdToken().then((idToken) {
      print('ID Token: $idToken}');
    }).catchError((error) {
      print(error);
    });
  }

  getAccessToken() {
    FlutterAwsAmplifyCognito.getAccessToken().then((accessToken) {
      print('Access Token: $accessToken');
    }).catchError((error) {
      print(error);
    });
  }

  getRefreshToken() {
    FlutterAwsAmplifyCognito.getRefreshToken().then((refreshToken) {
      print('Refresh Token: $refreshToken');
    }).catchError((error) {
      print(error);
    });
  }
}