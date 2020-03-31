/*
  

  Por limpiar
*/
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tkv_books/model/usuario.dart';

class UsuarioDao {
  static Future<Usuario> getUsuarioByCod(int codUsuario) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    apiUrl += "/usuariosTKV?codUsuario=" + codUsuario.toString();
    var response = await http.get(apiUrl);
    var decodedData = json.decode(response.body);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<ListaUsuarios> getUsuariosRegistrados() async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    var response = await http.get(apiUrl + "/usuariosTKV");
    var decodedData = json.decode(response.body);
    return ListaUsuarios.fromJson(decodedData);
  }

  static Future<Usuario> getUsuarioByNickname(String nickname) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    var response = await http.get(apiUrl + "/usuariosTKV?nickname=" + nickname);
    var decodedData = json.decode(response.body);

    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<bool> existeUsuario(String nickname, String contrasenia) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    var response = await http.get(apiUrl +
        "/usuariosTKV?nickname=" +
        nickname +
        "&contrasenia=" +
        contrasenia);
    var decodedData = json.decode(response.body);
    print(response.body);
    bool existe;
    ListaUsuarios.fromJson(decodedData).lista.length != 0
        ? existe = true
        : existe = false;
    print(existe);
    return existe;
  }

  static Future<bool> existeUsuarioByNickname(String nickname) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    var response = await http.get(apiUrl +
        "/usuariosTKV?nickname=" +
        nickname);
    var decodedData = json.decode(response.body);
    print(response.body);
    bool existe;
    ListaUsuarios.fromJson(decodedData).lista.length != 0
        ? existe = true
        : existe = false;
    print(existe);
    return existe;
  }

  static Future<Null> postUsuario(Usuario usuario) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    http.post(
      apiUrl + "/usuariosTKV",
      body: jsonEncode(usuario.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> putUsuarioSetLibroLeyendo(
      int codUsuario, int codLibro) async {
    String apiUrl =
        "https://io3689ejvd.execute-api.us-east-2.amazonaws.com/test";
    http.put(
      apiUrl + "/usuariosTKV?codUsuario=" + codUsuario.toString(),
      body: jsonEncode({"codLibroLeyendo": codLibro}),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json'
      },
    );
  }
}
