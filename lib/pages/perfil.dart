// si es su perfil le sale el floating button de aniadir curso
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/dialogs/agregar_libro_dialog.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/model/usuario.dart';
import 'package:tkv_books/util/router.dart';
import 'package:tkv_books/widgets/botonPersonalizado.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  Usuario usuarioPerfil;

  bool tieneLibros = false;
  ListaLibros librosAgregados;

  double screenWidth;
  double screenHeight;
  @override
  void initState() {
    // traer datos
    _actualizarListaLibros();
  }

  void _actualizarListaLibros() {
    LibroDao.getLibrosOfUsuario(Sesion.usuarioLogeado.codUsuario)
        .then((libros) {
      print(libros.lista);

      if (libros.lista.isNotEmpty) {
        tieneLibros = true;
        librosAgregados = libros;
        setState(() {
          print(tieneLibros);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topLeft,
        children: <Widget>[
          Image.asset(
            "images/logo.jpg",
            fit: BoxFit.cover,
            height: screenHeight * 0.35, // Responsive
            width: double.infinity,
          ),
          botonRetrocederPagina(() {}),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.0),
                topLeft: Radius.circular(32.0),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    tituloLabel("Biblioteca"),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Esta leyendo:"),
                        libroProgress(),
                        Text("Todos los libros"),
                        tieneLibros
                            ? _buildListaLibros()
                            : Text("Este men no tiene libros")
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton:
          //usuarioPerfil.codUsuario == ApiDao.usuarioLogeado.codUsuario?
          FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        onPressed: () => _abrirAgregarLibroDialog(),
      ),
    );

    //            : null);
  }

  Widget _buildListaLibros() {
    return Transform.translate(
      offset: Offset(0.0, screenHeight * 0.1050),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(0.0),
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: librosAgregados.lista.length,
        itemBuilder: (BuildContext content, int index) {
          return _buildLibroListItem(
            librosAgregados.lista[index],
          );
        },
      ),
    );
  }

  Widget _buildLibroListItem(Libro libro) {
    String porcentaje =
        (libro.paginasLeidas / libro.paginasTotales).toStringAsFixed(4);
    String paginas = "${libro.paginasLeidas} / ${libro.paginasTotales}";
    print(porcentaje);
    double porcentajeDouble = double.parse(porcentaje);
    porcentaje =
        porcentaje.substring(2, 4) + "." + porcentaje.substring(4) + "%";
    Color colorBarra;
    print(porcentajeDouble);
    if (porcentajeDouble == 1.00) colorBarra = Color(0xFFFFD938); // Amarillo
    if (porcentajeDouble < 0.75) colorBarra = Color(0xFF35A8A1); // Turquesa
    if (porcentajeDouble < 0.25) colorBarra = Color(0xFFF37D93); // Naranja
    if (porcentajeDouble < 0.15) colorBarra = Color(0xFFEE5F35); // Rosa
    return Column(
      children: <Widget>[
        Text(
          libro.nombre,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: LinearPercentIndicator(
            backgroundColor: Color(0xFFB7B7B7),
            width: screenWidth * 0.9,
            animation: true,
            lineHeight: 32.0,
            animationDuration: 2000,
            percent: porcentajeDouble < 1.00 ? porcentajeDouble : 0.4,
            center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(porcentaje),
                Text(paginas),
              ],
            ),
            progressColor: colorBarra,
          ),
        ),
      ],
    );
  }

  void _abrirAgregarLibroDialog() {
    agregarLibroDialog(context).then((libro) {
      LibroDao.postLibro(Sesion.libroAgregado);
    });
    _actualizarListaLibros();
  }

  Widget libroProgress() {
    return Container(
      child: Column(
        children: <Widget>[
          Text("Nombre / autor"),
          Text("34 / 100"),
        ],
      ),
    );
  }

  _irAlistaTotal() {
    Router.irListaTotal(context);
  }
}
