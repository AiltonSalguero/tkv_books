import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tkv_books/util/screen.dart';
import 'package:tkv_books/util/temaPersonlizado.dart';
import 'package:tkv_books/util/utilFunctions.dart';

class ExperienceBar extends StatelessWidget {
  final int puntaje;
  final int level;
  ExperienceBar({Key key, this.puntaje, this.level}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    int puntajeDelNivel = puntaje - calcularExperienciaRequeridaTotal(level);
    double porcentajeExperiencia = porcentajeDouble(
        puntajeDelNivel, calcularExperienciaRequerida(level + 1));
    String expRequerida = calcularExperienciaRequerida(level + 1).toString();
    String progresoLevel = "${puntajeDelNivel.toString()} / $expRequerida";
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Screen.width * 0.15,
      ),
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
    );
  }
}
