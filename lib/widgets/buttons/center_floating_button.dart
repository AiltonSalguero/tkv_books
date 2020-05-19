import 'package:flutter/material.dart';
import 'package:tkv_books/util/temaPersonlizado.dart';

class CenterFloatingButtonTkv extends StatelessWidget {
  IconData icon;
  Function accion;
  CenterFloatingButtonTkv({this.icon, this.accion});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(
        side: BorderSide(
          color: Colors.black,
        ),
      ),
      backgroundColor: ColoresTkv.cyan,
      child: Icon(
        icon,
      ),
      onPressed: accion,
    );
  }
}
