/*
   Un libro solo le pertenece a un usuario
   
   Por limpiar
*/
class Libro {
  int codLibro;
  int codUsuario;
  String nombre;
  String autor;
  int paginasLeidas;
  int paginasTotales;
  String nicknameUsuario;

  Libro(this.nombre, this.autor, this.paginasLeidas, this.paginasTotales) {
    this.codLibro = 0;
    this.codUsuario = 0;
  }

  Libro.fromJson(Map<String, dynamic> json) {
    codLibro = json['codLibro'];
    codUsuario = json['codUsuario'];
    nombre = json['nombre'];
    autor = json['autor'];
    paginasLeidas = json['paginasLeidas'];
    paginasTotales = json['paginasTotales'];
    nicknameUsuario = json['nicknameUsuario'];
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    data['codLibro'] = this.codLibro;
    data['codUsuario'] = this.codUsuario;
    data['nombre'] = this.nombre;
    data['autor'] = this.autor;
    data['paginasLeidas'] = this.paginasLeidas;
    data['paginasTotales'] = this.paginasTotales;
    data['nicknameUsuario'] = this.nicknameUsuario;
    return data;
  }
}

class ListaLibros {
  List<Libro> lista = List<Libro>();

  ListaLibros({this.lista});

  ListaLibros.fromJson(List<dynamic> json) {
    if (json != null) {
      json.forEach((v) {
        lista.add(Libro.fromJson(v));
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
