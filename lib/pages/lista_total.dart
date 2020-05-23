/*


  Por limpiar dar mejores nombres a las vairable
*/

import 'package:flutter/material.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/simple_dialog.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/temaPersonlizado.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/buttons/top_button.dart';

import 'package:tkv_books/widgets/labels/labelPerzonalizado.dart';

import 'package:tkv_books/widgets/page_background.dart';
import 'package:tkv_books/widgets/progress/book_linear_progress.dart';
import 'package:tkv_books/widgets/progress/experience_bar.dart';
import 'package:tkv_books/widgets/progress/library_circular_progress.dart';

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
        Sesion.librosRegistrados = libros;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    print("lista_libros");
    return PageBackground(
      backgroundImagePath: "images/banner_nubes.jpg",
      topButton: TopButtonTkv(
        nombre: "Mi perfil",
        navegarA: _irAmiPerfil,
      ),
      header: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(0, -0.9),
            child: titulo1Label(Sesion.usuarioLogeado.nickname),
          ),
          _buildLevel(Sesion.usuarioLogeado.nivel),
          Align(
            alignment: Alignment(-0.5, -0.72),
            child: ExperienceBar(
              puntaje: Sesion.usuarioLogeado.puntaje,
              level: Sesion.usuarioLogeado.nivel,
            ),
          ),
          hayLibroLeyendosePorUsuario
              ? Align(
                  alignment: Alignment(0, -0.62),
                  child: Container(
                    width: Screen.width * 0.98,
                    child: BookLinearProgressTkv(
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
          hayLibrosLeyendose
              ? LibraryCircularProgressTkv(
                  libreria: Sesion.librosRegistrados,
                )
              : Text("No hay libros")
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

  bool _aumentoPaginasValido() {
    int paginaActual = Sesion.libroLeyendoPorUsuario.paginasLeidas + 1;
    return paginaActual > Sesion.libroLeyendoPorUsuario.paginasTotales
        ? false
        : true;
  }

  bool _disminucionPaginasValido() {
    int paginaActual = Sesion.libroLeyendoPorUsuario.paginasLeidas - 1;
    return paginaActual == -1 ? false : true;
  }

  _aumentarPaginas() {
    if (_aumentoPaginasValido()) {
      Sesion.libroLeyendoPorUsuario.paginasLeidas++;
      int levelAntiguo = Sesion.usuarioLogeado.nivel;
      Sesion.usuarioLogeado.puntaje++;
      Sesion.usuarioLogeado.nivel =
          calcularLevelUsuario(Sesion.usuarioLogeado.puntaje);
      LibroDao.putLibroSetPaginasLeidas(Sesion.libroLeyendoPorUsuario);
      if (levelAntiguo < calcularLevelUsuario(Sesion.usuarioLogeado.puntaje)) {
        // Mostrar mensaje de subida de leve
        SimpleDialogTkv(
          title: "Subiste de nivel!",
          content: "Ahora eres Lv. ${Sesion.usuarioLogeado.nivel}",
          rightText: ":D",
        ).build(context);
      }
      setState(() {});
    }
  }

  _disminuirPaginas() {
    if (_disminucionPaginasValido()) {
      Sesion.libroLeyendoPorUsuario.paginasLeidas--;
      Sesion.usuarioLogeado.puntaje--;
      Sesion.usuarioLogeado.nivel =
          calcularLevelUsuario(Sesion.usuarioLogeado.puntaje);
      LibroDao.putLibroSetPaginasLeidas(Sesion.libroLeyendoPorUsuario);
      setState(() {});
    }
  }

  _irAmiPerfil() {
    Navigator.of(context).pushReplacementNamed('/perfil');
  }
}
