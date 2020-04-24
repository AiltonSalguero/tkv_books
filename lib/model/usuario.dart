class Usuario {
  int codUsuario;
  String nombres;
  String apellidos;
  String nickname;
  String contrasenia;
  int codLibroLeyendo;
  int level;
  int puntaje;
  int premium;
  // cod usuario generado
  Usuario(this.nombres, this.apellidos, this.nickname, this.contrasenia) {
    this.codUsuario = 0;
    this.codLibroLeyendo = 0;
    this.level = 1;
    this.puntaje = 0;
    this.premium = 0;
  }

  Usuario.fromJson(Map<String, dynamic> json) {
    codUsuario = json['codUsuario'];
    nombres = json['nombres'];
    apellidos = json['apellidos'];
    nickname = json['nickname'];
    contrasenia = json['contrasenia'];
    codLibroLeyendo = json['codLibroLeyendo'];
    level = json['level'];
    puntaje = json['puntaje'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    // Data a Json
    final data = Map<String, dynamic>();
    data['codUsuario'] = this.codUsuario;
    data['nombres'] = this.nombres;
    data['apellidos'] = this.apellidos;
    data['nickname'] = this.nickname;
    data['contrasenia'] = this.contrasenia;
    data['codLibroLeyendo'] = this.codLibroLeyendo;
    data['level'] = this.level;
    data['puntaje'] = this.puntaje;
    data['premium'] = this.premium;
    return data;
  }
}

class ListaUsuarios {
  List<Usuario> lista = List<Usuario>();

  ListaUsuarios({this.lista});

  ListaUsuarios.fromJson(List<dynamic> json) {
    if (json != null) {
      json.forEach((v) {
        lista.add(Usuario.fromJson(v));
      });
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = List<dynamic>();
    if (this.lista.isNotEmpty) {
      data = this.lista.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
