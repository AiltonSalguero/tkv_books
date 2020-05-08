import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tkv_books/model/libro.dart';
import 'package:tkv_books/util/utilFunctions.dart';

class BookCircularProgressTkv extends StatelessWidget {
  final Libro libro;
  BookCircularProgressTkv({this.libro});
  @override
  Widget build(BuildContext context) {
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
}
