/*
  

  Por limpiar
*/
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:tkv_books/dialogs/eliminar_libro_dialog.dart';
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

  static Future<bool> existeUsuario(String nickname, String contrasenia, BuildContext context) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    String apiKey = DotEnv().env['AWS_API_KEY'];
    try {
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
    } catch (e) {
      alertaDialog(context,"Sin internet","No esta conectado a internet.","","Ok");
    }
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
    jsonEncode(usuario.toJson());
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

  static Future<Null> putUsuarioSetLibroLeyendo(Usuario usuario) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    apiUrl += "/usuariosTKV?codUsuario=" + usuario.codUsuario.toString();
    apiUrl += "&codLibroLeyendo=" + usuario.codLibroLeyendo.toString();
    print(apiUrl);
    String apiKey = DotEnv().env['AWS_API_KEY'];
    http.put(
      apiUrl,
      headers: {
        'x-api-key': apiKey,
      },
    );
  }

  static Future<Null> putUsuarioSetPuntajeLevel(Usuario usuario) async {
    String apiUrl = DotEnv().env['AWS_API_URL'];
    apiUrl += "/usuariosTKV?codUsuario=" + usuario.codUsuario.toString();
    apiUrl += "&puntaje=" + usuario.puntaje.toString();
    apiUrl += "&level=" + usuario.level.toString();
    String apiKey = DotEnv().env['AWS_API_KEY'];
    http.put(
      apiUrl,
      body: jsonEncode(usuario.toJson()),
      headers: {
        'Content-type': 'application/json',
        'x-api-key': apiKey,
        'Accept': 'application/json'
      },
    );
  }
}
