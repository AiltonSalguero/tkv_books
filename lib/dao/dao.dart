import 'dart:convert';
import 'package:http/http.dart' as http;

/*

  Clase que maneja las peticiones generales
*/
class Dao {
  static String apiUrl =
      "https://qm2skcyyr8.execute-api.sa-east-1.amazonaws.com/prueba";
  static String cognitoToken;

  static jsonDecodedHttpGet(String url) async {
    print(url);
    print(Dao.cognitoToken + "TOKEN");
    var response = await http.get(
      url,
      headers: {"Authorization": Dao.cognitoToken},
    );

    print(json.decode(response.body));
    return json.decode(response.body);
  }

  static httpPost(String url, var objeto) {
    http.post(
      url,
      body: jsonEncode(objeto.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': cognitoToken,
      },
    );
  }

  static httpPut(String url) {
    http.put(
      url,
      headers: {
        'Authorization': cognitoToken,
      },
    );
  }

  static httpDelete(String url) {
    http.delete(
      url,
      headers: {
        'Authorization': cognitoToken,
      },
    );
  }
}
