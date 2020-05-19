import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
  Clase que maneja las peticiones generales
*/
class Dao {
  static String apiUrl = DotEnv().env['AWS_API_URL'];
  static String apiKey = "a";
  static String cognitoToken;

  static jsonDecodedHttpGet(String url) async {
    var response = await http.get(
      url,
      headers: {
        'Authorization': cognitoToken
      },
    );
    return json.decode(response.body);
  }

  static httpPost(String url, var objeto) {
    http.post(
      url,
      body: jsonEncode(objeto.toJson()),
      headers: {
        'Authorization': cognitoToken
      },
    );
  }

  static httpPut(String url) {
    http.put(
      url,
      headers: {
        'Authorization': cognitoToken
      },
    );
  }

  static httpDelete(String url) {
    http.delete(
      url,
      headers: {
        'Authorization': cognitoToken
      },
    );
  }
}
