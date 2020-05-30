import 'package:flutter/material.dart';
import 'package:tkv_books/util/temaPersonlizado.dart';

class CenterFloatingButtonTkv extends StatelessWidget {
  final IconData icon;
  final Function accion;
  CenterFloatingButtonTkv({@required this.icon, @required this.accion});
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
