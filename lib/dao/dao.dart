import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
  Clase que maneja las peticiones generales
*/
class Dao {
  static String apiUrl = DotEnv().env['AWS_API_URL'];
  static String apiKey = DotEnv().env['AWS_API_KEY'];

  static jsonDecodedHttpGet(String url) async {
    var response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
      },
    );
    return json.decode(response.body);
  }

  static httpPost(String url, var objeto) {
    http.post(
      url,
      body: jsonEncode(objeto.toJson()),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static httpPut(String url) {
    http.put(
      url,
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static httpDelete(String url) {
    http.delete(
      url,
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
      },
    );
  }
}
