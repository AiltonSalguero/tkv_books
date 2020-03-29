import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tkv_books/dao/libro_dao.dart';
import 'package:tkv_books/dao/usuario_dao.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/util/utilFunctions.dart';
import 'package:tkv_books/widgets/labelPerzonalizado.dart';
import 'package:tkv_books/widgets/otrosPersonalizado.dart';

class ListaTotalPage extends StatefulWidget {
  @override
  _ListaTotalPageState createState() => _ListaTotalPageState();
}

class _ListaTotalPageState extends State<ListaTotalPage> {
  bool tieneLibros = false;
  double screenWidth;
  double screenHeight;

  ListaLibros librosTotales;
  @override
  void initState() {
    // traer datos
    _actualizarListaLibros();
  }

  void _actualizarListaLibros() {
    print("actualizando...");

    LibroDao.getLibrosTotales().then((libros) {
      if (libros.lista.isNotEmpty) {
        tieneLibros = true;
        librosTotales = libros;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
          botonPerfil(),
          Container(
            height: double.infinity,
            width: double.infinity,
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
              child: Column(
                children: <Widget>[
                  tituloLabel("Biblioteca"),
                  Column(
                    //mainAxisSize: MainAxisSize.min,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      subTituloLabel("Esta leyendo:"),
                      subTituloLabel("Biblioteca"),
                      tieneLibros
                          ? _buildGridLibros()
                          : Text("Este men no tiene libros")
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridLibros() {
    return Container(
      height: screenHeight * 0.45,
      child: GridView.count(
        crossAxisCount: 2, //numero de columnas

        //LISTA DE TODOS LOS ELEMENTOS DEL JSON
        children: librosTotales.lista
            .map(
              (libro) => _buildLibroListItem(libro),
            )
            .toList(),
      ),
    );
  }

  Widget _buildLibroListItem(Libro libro) {
    String nombreUsuario = "";
    UsuarioDao.getUsuarioByCod(libro.codUsuario).then((usuario) {
      nombreUsuario = usuario.nombres;
    });
    String porcentajeTexto =
        porcentajeString(libro.paginasLeidas, libro.paginasTotales);
    double porcentaje =
        porcentajeDouble(libro.paginasLeidas, libro.paginasTotales);
    String paginas = "${libro.paginasLeidas} / ${libro.paginasTotales}";

    Color colorBarra;
    if (porcentaje == 1.00) colorBarra = Color(0xFFFFD938); // Amarillo
    if (porcentaje < 0.75) colorBarra = Color(0xFF35A8A1); // Turquesa
    if (porcentaje < 0.25) colorBarra = Color(0xFFF37D93); // Naranja
    if (porcentaje < 0.15) colorBarra = Color(0xFFEE5F35); // Rosa
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: CircularPercentIndicator(
            backgroundColor: Color(0xFFB7B7B7),
            radius: 80.0,
            animation: true,
            animationDuration: 2000,
            percent: porcentaje,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(porcentajeTexto),
                Text(paginas),
              ],
            ),
            progressColor: colorBarra,
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
          nombreUsuario,
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  _irAhome() {
    // Deslogear al usuario
    // mostrar ventana que se esta cerrando la sesion
    Navigator.of(context).pushNamed("/");
  }
}
