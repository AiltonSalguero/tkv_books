/*


  Por limpiar dar mejores nombres a las vairable
*/

import 'package:flutter/material.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/temaPersonlizado.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/book_circular_progress.dart';
import 'package:tkv_books/widgets/book_item.dart';
import 'package:tkv_books/widgets/experience_bar.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';
import 'package:tkv_books/widgets/page_background.dart';
import 'package:tkv_books/widgets/top_button.dart';

class ListaTotalPage extends StatefulWidget {
  @override
  _ListaTotalPageState createState() => _ListaTotalPageState();
}

class _ListaTotalPageState extends State<ListaTotalPage> {
  bool hayLibrosLeyendose = false;

  bool hayLibroLeyendosePorUsuario;
  @override
  void initState() {
    hayLibroLeyendosePorUsuario =
        Sesion.usuarioLogeado.codLibroLeyendo == 0 ? false : true;
    _actualizarListaLibros();
  }

  _actualizarListaLibros() {
    print("actualizando...");

    LibroDao.getLibrosTotales().then((libros) {
      if (libros.lista.isNotEmpty) {
        hayLibrosLeyendose = true;
        Sesion.librosLeyendoseTotales = libros;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print("lista_libros");
    return PageBackground(
      topButton: TopButton(
        nombre: "Mi perfil",
        navegarA: _irAmiPerfil,
      ),
      header: Stack(
        children: <Widget>[
          Image.asset(
            "images/banner_nubes.jpg",
            fit: BoxFit.cover,
            height: Screen.height * 0.35, // Responsive
            width: double.infinity,
          ),
          Align(
            alignment: Alignment(0, -0.9),
            child: titulo1Label(Sesion.usuarioLogeado.nickname),
          ),
          _buildLevel(Sesion.usuarioLogeado.level),
          Align(
            alignment: Alignment(-0.5, -0.72),
            child: ExperienceBar(
              puntaje: Sesion.usuarioLogeado.puntaje,
              level: Sesion.usuarioLogeado.level,
            ),
          ),
          hayLibroLeyendosePorUsuario
              ? Align(
                  alignment: Alignment(0, -0.62),
                  child: Container(
                    width: Screen.width * 0.98,
                    child: BookItem(
                      libro: Sesion.libroLeyendoPorUsuario,
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 20,
                            width: Screen.width * 0.6,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: titulo3Label(
                                  Sesion.libroLeyendoPorUsuario.nombre),
                            ),
                          ),
                        ],
                      ),
                      boxHeight: Screen.height * 0.12,
                      leftButton: FlatButton(
                        child: Icon(
                          Icons.keyboard_arrow_up,
                        ),
                        onPressed: () => _aumentarPaginas(),
                      ),
                      rightButton: FlatButton(
                        child: Icon(Icons.keyboard_arrow_down),
                        onPressed: () => _disminuirPaginas(),
                      ),
                    ),
                  ),
                )
              : Text(""),
        ],
      ),
      content: Column(
        children: <Widget>[
          titulo1Label("Biblioteca global"),
          hayLibrosLeyendose ? _buildGridLibros() : Text("No hay libros")
        ],
      ),
      floatingButton: FloatingActionButton(
        shape: CircleBorder(
          side: BorderSide(
            color: Colors.black,
          ),
        ),
        backgroundColor: ColoresTkv.cyan,
        child: Icon(
          Icons.refresh,
        ),
        onPressed: () => _actualizarListaLibros(),
      ),
    );
  }

  Widget _buildLevel(int level) {
    return Align(
      alignment: Alignment(0, -0.79),
      child: Text(
        "Lv. " + level.toString(),
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildGridLibros() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Container(
        height: Screen.height * 0.55,
        // responsive
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: GridView.count(
          childAspectRatio: 24 / 29,
          crossAxisSpacing: 4.0,
          crossAxisCount: 2,
          children: Sesion.librosLeyendoseTotales.lista
              .map(
                (libro) => BookCircularProgress(
                  libro: libro,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  _aumentarPaginas() {
    int paginaActual = Sesion.libroLeyendoPorUsuario.paginasLeidas + 1;
    if (paginaActual > Sesion.libroLeyendoPorUsuario.paginasTotales)
      return null;

    Sesion.libroLeyendoPorUsuario.paginasLeidas++;
    int levelAntiguo = Sesion.usuarioLogeado.level;
    Sesion.usuarioLogeado.puntaje++;
    Sesion.usuarioLogeado.level =
        calcularLevelUsuario(Sesion.usuarioLogeado.puntaje);
    LibroDao.putLibroSetPaginasLeidas(Sesion.libroLeyendoPorUsuario);

    _actualizarPuntajeUsuario(levelAntiguo);
  }

  _disminuirPaginas() {
    int paginaActual = Sesion.libroLeyendoPorUsuario.paginasLeidas - 1;
    if (paginaActual == -1) return null;

    Sesion.libroLeyendoPorUsuario.paginasLeidas--;
    Sesion.usuarioLogeado.puntaje--;
    int levelAntiguo = Sesion.usuarioLogeado.level;
    Sesion.usuarioLogeado.level =
        calcularLevelUsuario(Sesion.usuarioLogeado.puntaje);
    LibroDao.putLibroSetPaginasLeidas(Sesion.libroLeyendoPorUsuario);

    _actualizarPuntajeUsuario(levelAntiguo);
  }

  _actualizarPuntajeUsuario(int levelAntiguo) {
    if (levelAntiguo < calcularLevelUsuario(Sesion.usuarioLogeado.puntaje)) {
      // Mostrar mensaje de subida de leve
    //  errorLoginDialog(context, "Subiste de nivel!",
      //    "Ahora eres Lv. ${Sesion.usuarioLogeado.level}");
    }
  }

  _irAmiPerfil() {
    Navigator.of(context).pushReplacementNamed('/perfil');
  }
}
