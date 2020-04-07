/*


  Por limpiar dar mejores nombres a las vairable
*/

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/dialogs/error_dialog.dart';
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
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.asset(
            "images/banner_nubes.jpg",
            fit: BoxFit.cover,
            height: Screen.height * 0.35, // Responsive
            width: double.infinity,
          ),
          Align(
            alignment: Alignment(0, -0.9),
            //alignment: AlignmentDirectional.topCenter,
            child: titulo1Label(Sesion.usuarioLogeado.nickname),
          ),
          _buildLevel(),
          _buildExperiencia(
              Sesion.usuarioLogeado.puntaje, Sesion.usuarioLogeado.level),
          botonTercero("Mi perfil", _irAmiPerfil),
          hayLibroLeyendosePorUsuario
              ? _libroLeyendosePorUsuario(Sesion.libroLeyendoPorUsuario)
              : Text(""),
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
              top: Screen.height * 0.3, // Responsive 266
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 16.0,
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

  Widget _buildLevel() {
    return Align(
      alignment: Alignment(0, -0.79),
      child: Text(
        "Lv. " + Sesion.usuarioLogeado.level.toString(),
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildExperiencia(int puntaje, int level) {
    int puntajeDelNivel = puntaje - calcularExperienciaRequeridaTotal(level);
    double porcentajeExperiencia = porcentajeDouble(
        puntajeDelNivel, calcularExperienciaRequerida(level + 1));
    String expRequerida = calcularExperienciaRequerida(level + 1).toString();
    String progresoLevel = "${puntajeDelNivel.toString()} / $expRequerida";
    return Align(
      alignment: Alignment(-0.5, -0.72),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Screen.width * 0.15),
        child: LinearPercentIndicator(
          width: Screen.width * 0.7,
          lineHeight: 8.0,
          percent: porcentajeExperiencia,
          progressColor: ColoresTkv.amarillo,
          center: Text(
            progresoLevel,
            style: TextStyle(
              fontSize: 8.0,
            ),
          ),
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
        width: Screen.width * 0.90, // responsive
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
            Radius.circular(
              48.0,
            ),
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

  Widget _libroLeyendosePorUsuario(Libro libro) {
    String porcentajeTexto =
        porcentajeString(libro.paginasLeidas, libro.paginasTotales);
    double porcentaje =
        porcentajeDouble(libro.paginasLeidas, libro.paginasTotales);
    String paginas = "${libro.paginasLeidas} / ${libro.paginasTotales}";

    Color colorBarra = colorProgressBar(porcentaje);

    return Align(
      alignment: Alignment(0, -0.62),
      child: Container(
        height: 70,
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
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Screen.width * 0.05,
                  vertical: 8.0,
                ),
                child: LinearPercentIndicator(
                  backgroundColor: Color(0xFFB7B7B7),
                  width: Screen.width * 0.84,
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
            ),
            Align(
              alignment: Alignment(-1, -1),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 8.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 20,
                      width: Screen.width * 0.6,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: titulo3Label(libro.nombre),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(
                0.5,
                -1.5,
              ),
              child: FlatButton(
                child: Icon(
                  Icons.keyboard_arrow_up,
                ),
                onPressed: () => _aumentarPaginas(),
              ),
            ),
            Align(
              alignment: Alignment(
                1,
                -1.5,
              ),
              child: FlatButton(
                child: Icon(Icons.keyboard_arrow_down),
                onPressed: () => _disminuirPaginas(),
              ),
            ),
          ],
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
      errorLoginDialog(context, "Subiste de nivel!",
          "Ahora eres Lv. ${Sesion.usuarioLogeado.level}");
    }
    print(Sesion.usuarioLogeado.level);
    print(Sesion.usuarioLogeado.puntaje);

    UsuarioDao.putUsuarioSetPuntajeLevel(Sesion.usuarioLogeado).then((val) {
      setState(() {});
    });
  }

  _irAmiPerfil() {
    Navigator.of(context).pushReplacementNamed('/perfil');
  }
}
