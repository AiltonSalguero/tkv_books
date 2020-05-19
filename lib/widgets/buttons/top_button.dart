import 'package:flutter/material.dart';

class TopButtonTkv extends StatelessWidget {
  final String nombre;
  final Function navegarA;
  TopButtonTkv({this.nombre, this.navegarA});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(
        -0.95,
        0.7,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ), // responsive
          GestureDetector(
            onTap: navegarA,
            child: Container(
              height: 36,
              width: 90,
              decoration: BoxDecoration(
                color: Color(0xFF35A8A1),
                borderRadius: BorderRadius.circular(
                  20.0,
                ),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: Center(
                child: Text(
                  nombre,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontFamily: "Product_Sans_Bold",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
