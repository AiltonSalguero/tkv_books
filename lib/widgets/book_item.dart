import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tkv_books/dao/sesion.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/utilFunctions.dart';

class BookItem extends StatelessWidget {
  Libro libro;
  double boxHeight;
  Widget title;
  Widget leftButton;
  Widget rightButton;
  BookItem(
      {Key key,
      this.libro,
      this.boxHeight,
      this.title,
      this.leftButton,
      this.rightButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String porcentajeTexto =
        porcentajeString(libro.paginasLeidas, libro.paginasTotales);
    double porcentaje =
        porcentajeDouble(libro.paginasLeidas, libro.paginasTotales);
    String paginas = "${libro.paginasLeidas} / ${libro.paginasTotales}";

    Color colorBarra = colorProgressBar(porcentaje);

    bool leyendo =
        libro.codLibro == Sesion.usuarioLogeado.codLibroLeyendo ? true : false;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 4.0,
      ),
      child: Container(
        height: boxHeight,
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
                  width: Screen.width * 0.86,
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
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                child: title,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: leftButton,
            ),
            Align(
              alignment: Alignment(
                0.6,
                -1,
              ),
              child: rightButton,
            ),
          ],
        ),
      ),
    );
  }
}
