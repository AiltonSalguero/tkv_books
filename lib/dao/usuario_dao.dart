/*
  

  Por limpiar
*/
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tkv_books/model/usuario.dart';

class UsuarioDao {
  static Future<Usuario> getUsuarioByCod(int codUsuario) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    apiUrl += "/usuariosTKV?codUsuario=" + codUsuario.toString();
    var response = await http.get(
      apiUrl,
      headers: {
        'x-api-key': apiKey,
      },
    );
    var decodedData = json.decode(response.body);
    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<ListaUsuarios> getUsuariosRegistrados() async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    var response = await http.get(
      apiUrl + "/usuariosTKV",
      headers: {
        'x-api-key': apiKey,
      },
    );
    var decodedData = json.decode(
      response.body,
    );
    return ListaUsuarios.fromJson(decodedData);
  }

  static Future<Usuario> getUsuarioByNickname(String nickname) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    var response = await http.get(
      apiUrl + "/usuariosTKV?nickname=" + nickname,
      headers: {
        'x-api-key': apiKey,
      },
    );
    var decodedData = json.decode(response.body);

    return ListaUsuarios.fromJson(decodedData).lista[0];
  }

  static Future<bool> existeUsuario(String nickname, String contrasenia) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    var response = await http.get(
      apiUrl +
          "/usuariosTKV?nickname=" +
          nickname +
          "&contrasenia=" +
          contrasenia,
      headers: {
        'x-api-key': apiKey,
      },
    );

    var decodedData = json.decode(response.body);
    bool existe;
    print(decodedData);
    ListaUsuarios.fromJson(decodedData).lista.length != 0
        ? existe = true
        : existe = false;
    return existe;
  }

  static Future<bool> existeUsuarioByNickname(String nickname) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    print(DotEnv().env['AWS_API_KEY']);
    var response = await http.get(
      apiUrl + "/usuariosTKV?nickname=" + nickname,
      headers: {
        'x-api-key': apiKey,
      },
    );
    var decodedData = json.decode(response.body);
    print(decodedData);
    bool existe;
    ListaUsuarios.fromJson(decodedData).lista.length != 0
        ? existe = true
        : existe = false;
    return existe;
  }

  static Future<Null> postUsuario(Usuario usuario) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    http.post(
      apiUrl + "/usuariosTKV",
      body: jsonEncode(usuario.toJson()),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> putUsuarioSetLibroLeyendo(
      int codUsuario, int codLibro) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    http.put(
      apiUrl + "/usuariosTKV?codUsuario=" + codUsuario.toString(),
      body: jsonEncode({"codLibroLeyendo": codLibro}),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> putUsuarioSetPuntaje(int codUsuario, int puntaje) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    http.put(
      apiUrl + "/usuariosTKV?codUsuario=" + codUsuario.toString(),
      body: jsonEncode({"puntaje": puntaje}),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }

  static Future<Null> putUsuarioSetLevel(int codUsuario, int level) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    http.put(
      apiUrl + "/usuariosTKV?codUsuario=" + codUsuario.toString(),
      body: jsonEncode({"level": level}),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }
}
