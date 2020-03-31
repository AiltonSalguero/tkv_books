/*


  Por limpiar dar mejores nombres a las vairable
*/

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/temaPersonlizado.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';
import 'package:tkv_books/widgets/botonPersonalizado.dart';

class ListaTotalPage extends StatefulWidget {
  @override
  _ListaTotalPageState createState() => _ListaTotalPageState();
}

class _ListaTotalPageState extends State<ListaTotalPage> {
  double screenWidth;
  double screenHeight;

  bool hayLibrosLeyendose = false;
  ListaLibros librosTotales;

  bool hayLibroLeyendosePorUsuario = false;
  @override
  void initState() {
    // traer datos
    _actualizarListaLibros();
    _obtenerLibroLeyendosePorUsuario();
  }

  _actualizarListaLibros() {
    print("actualizando...");

    LibroDao.getLibrosTotales().then((libros) {
      if (libros.lista.isNotEmpty) {
        hayLibrosLeyendose = true;
        librosTotales = libros;
      }
      setState(() {});
    });
  }

  _obtenerLibroLeyendosePorUsuario() {
    if (Sesion.usuarioLogeado.codLibroLeyendo != null) {
      LibroDao.getLibroByCod(Sesion.usuarioLogeado.codLibroLeyendo)
          .then((libro) {
        if (libro != null) {
          hayLibroLeyendosePorUsuario = true;
          Sesion.libroLeyendoPorUsuario = libro;
        }
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.passthrough,
        //alignment: Alignment.topLeft,
        children: <Widget>[
          Image.asset(
            "images/banner_nubes.jpg",
            fit: BoxFit.cover,
            height: screenHeight * 0.35, // Responsive
            width: double.infinity,
          ),
          Align(
            alignment: Alignment(0, -0.9),
            //alignment: AlignmentDirectional.topCenter,
            child: titulo1Label(Sesion.usuarioLogeado.nickname),
          ),
          Align(
            alignment: Alignment(0, -0.8),
            //alignment: AlignmentDirectional.topCenter,
            child: subTitulo1Label("Leyendo:"),
          ),
          botonTercero("Mi perfil", _irAmiPerfil),
          hayLibroLeyendosePorUsuario
              ? _libroLeyendosePorUsuario(Sesion.libroLeyendoPorUsuario)
              : Text("Agregue un libro"),
          subTitulo1Label("Libros leyéndose actualmente"),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.0),
                topLeft: Radius.circular(32.0),
              ),
              border: Border.all(
                color: Colors.black,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 32.0,
                ),
              ],
              color: Color(0xfffafafa),
            ),
            margin: EdgeInsets.only(
              top: screenHeight * 0.3, // Responsive 266
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 32.0,
              ),
              child: Column(
                children: <Widget>[
                  titulo1Label("Biblioteca global"),
                  hayLibrosLeyendose
                      ? _buildGridLibros()
                      : Text("No hay libros")
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:
          //usuarioPerfil.codUsuario == ApiDao.usuarioLogeado.codUsuario?
          FloatingActionButton(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _irAmiPerfil() {
    Navigator.of(context).pushReplacementNamed('/perfil');
  }

  Widget _buildGridLibros() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Container(
        height: screenHeight * 0.55,
        width: screenHeight * 0.90, // responsive
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: GridView.count(
          childAspectRatio: 24 / 29,
          crossAxisSpacing: 4.0,
          //mainAxisSpacing: 0.2,
          //padding:,
          crossAxisCount: 2,
          children: librosTotales.lista
              .map(
                (libro) => _buildLibroListItem(libro),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildLibroListItem(Libro libro) {
    String porcentajeTexto =
        porcentajeString(libro.paginasLeidas, libro.paginasTotales);
    double porcentaje =
        porcentajeDouble(libro.paginasLeidas, libro.paginasTotales);
    String paginas = "${libro.paginasLeidas} / ${libro.paginasTotales}";

    Color colorBarra = colorProgressBar(porcentaje);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 4.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(48.0),
          ),
          border: Border.all(
            color: Colors.black,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8.0,
            ),
          ],
          color: Color(0xfffafafa),
        ),
        child: Column(
          children: <Widget>[
            CircularPercentIndicator(
              backgroundColor: Color(0xFFB7B7B7),
              radius: 100.0,
              lineWidth: 10.0,
              animation: true,
              animationDuration: 2000,
              percent: porcentaje,
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: colorBarra,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    porcentajeTexto,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    paginas,
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              libro.nombre,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              libro.nicknameUsuario,
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _irAhome() {
    // Deslogear al usuario
    // mostrar ventana que se esta cerrando la sesion
    Navigator.of(context).pushNamed("/");
  }

  Widget _libroLeyendosePorUsuario(Libro libro) {
    String porcentajeTexto =
        porcentajeString(libro.paginasLeidas, libro.paginasTotales);
    double porcentaje =
        porcentajeDouble(libro.paginasLeidas, libro.paginasTotales);
    String paginas = "${libro.paginasLeidas} / ${libro.paginasTotales}";

    Color colorBarra = colorProgressBar(porcentaje);

    return Align(
      alignment: Alignment(0.4, -0.7),
      child: Container(
        height: 90,
        width: Screen.width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(32.0),
          ),
          border: Border.all(
            color: Colors.black,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 16.0,
            ),
          ],
          color: Color(0xfffafafa),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    titulo3Label(libro.nombre),
                    subTitulo3Label(libro.autor),
                  ],
                ),
                Row(
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.keyboard_arrow_up),
                      onPressed: () => _aumentarPaginas(),
                    ),
                    FlatButton(
                      child: Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      onPressed: () => _disminuirPaginas(),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: LinearPercentIndicator(
                backgroundColor: Color(0xFFB7B7B7),
                width: Screen.width * 0.85,
                animation: true,
                lineHeight: 28.0,
                animationDuration: 2000,
                percent: porcentaje,
                center: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(porcentajeTexto),
                    Text(paginas),
                  ],
                ),
                progressColor: colorBarra,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _aumentarPaginas() {
    print(Sesion.libroLeyendoPorUsuario.paginasLeidas);
    int paginaActual = Sesion.libroLeyendoPorUsuario.paginasLeidas + 1;
    if (paginaActual > Sesion.libroLeyendoPorUsuario.paginasTotales)
      return null;
    LibroDao.putLibroSetPaginasLeidas(
            Sesion.usuarioLogeado.codLibroLeyendo, paginaActual)
        .then((val) {
      Sesion.libroLeyendoPorUsuario.paginasLeidas++;
      _actualizarListaLibros();
    });
  }

  _disminuirPaginas() {
    int paginaActual = Sesion.libroLeyendoPorUsuario.paginasLeidas - 1;
    if (paginaActual == -1) return null;
    LibroDao.putLibroSetPaginasLeidas(
            Sesion.usuarioLogeado.codLibroLeyendo, paginaActual)
        .then((val) {
      Sesion.libroLeyendoPorUsuario.paginasLeidas--;
      _actualizarListaLibros();
    });
    ;
  }
}
