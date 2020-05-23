class Usuario {
  int codUsuario;
  String nickname;
  String nombreCompleto;
  String email;
  int codLibroLeyendo;
  int nivel;
  int puntaje;
  int premium;
  // cod usuario generado
  Usuario(this.nombreCompleto, this.nickname, this.email) {
    this.codUsuario = 0;
    this.codLibroLeyendo = 0;
    this.nivel = 1;
    this.puntaje = 0;
    this.premium = 0;
  }

  Usuario.fromJson(Map<String, dynamic> json) {
    codUsuario = json['codUsuario'];
    nombreCompleto = json['nombreCompleto'];
    nickname = json['nickname'];
    email = json['email'];
    codLibroLeyendo = json['codLibroLeyendo'];
    nivel = json['level'];
    puntaje = json['puntaje'];
    premium = json['premium'];
  }

  Map<String, dynamic> toJson() {
    // Data a Json
    final data = Map<String, dynamic>();
    data['codUsuario'] = this.codUsuario;
    data['nombreCompleto'] = this.nombreCompleto;
    data['email'] = this.email;
    data['nickname'] = this.nickname;
    data['codLibroLeyendo'] = this.codLibroLeyendo;
    data['level'] = this.nivel;
    data['puntaje'] = this.puntaje;
    data['premium'] = this.premium;
    return data;
  }
}

class ListaUsuarios {
  List<Usuario> lista = [];

  ListaUsuarios();

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
