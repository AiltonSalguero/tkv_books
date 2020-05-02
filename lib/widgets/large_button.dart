import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final String nombre;
  @required final bool primario;
  final Function accion;
  LargeButton({this.nombre, this.primario, this.accion});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: RaisedButton(
          color: primario ? Color(0xFF35A8A1) : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(28.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              nombre,
              style: TextStyle(
                color: primario ? Colors.white : Colors.black,
                fontSize: 24.0,
                fontFamily: "Product_Sans_Bold",
              ),
            ),
          ),
          onPressed: accion,
        ),
      ),
    );
  }
}
