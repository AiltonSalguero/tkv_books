import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/*
  Clase que maneja las peticiones generales
*/
class Dao {
  static String apiKey = DotEnv().env['AWS_API_KEY'];
  static String apiUrl = DotEnv().env['AWS_API_URL'];
  
  static jsonDecodedHttpGet(String apiUrl) async {
    var response = await http.get(
      apiUrl,
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
      },
    );
    return json.decode(response.body);
  }

  static httpPost(String apiUrl, var objeto) {
    http.post(
      apiUrl,
      body: jsonEncode(objeto.toJson()),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static httpPut(String apiUrl) {
    http.put(
      apiUrl,
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static httpDelete(String apiUrl) {
     http.delete(
      apiUrl,
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
      },
    );
  }
}
