class Libro {
  int codLibro;
  String codUsuario;
  String nombre;
  String autor;
  int paginasLeidas;
  int paginasTotales;

  Libro.fromJson(Map<String, dynamic> json) {
    codLibro = json['codLibro'];
    codUsuario = json['codUsuario'];
    nombre = json['nombre'];
    autor = json['autor'];
    paginasLeidas = json['paginasLeidas'];
    paginasTotales = json['paginasTotales'];
  }

  Map<String, dynamic> toJson() {
    // Data a Json
    final data = Map<String, dynamic>();
    data['codLibro'] = this.codLibro;
    data['codUsuario'] = this.codUsuario;
    data['nombre'] = this.nombre;
    data['autor'] = this.autor;
    data['paginasLeidas'] = this.paginasLeidas;
    data['paginasTotales'] = this.paginasTotales;
    return data;
  }
}

class ListaLibros {
  List<Libro> lista;

  ListaLibros({this.lista});

  ListaLibros.fromJson(List<dynamic> json) {
    if (json != null) {
      lista = List<Libro>();
      json.forEach((v) {
        lista.add(Libro.fromJson(v));
      });
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = List<dynamic>();
    if (this.lista != null) {
      data = this.lista.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
