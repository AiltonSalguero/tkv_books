import 'package:flutter/material.dart';

Widget botonRetrocederPagina(Function retrocederPage) {
  return Padding(
    padding: EdgeInsets.only(
      top: 32.0,
      left: 8.0,
    ),
    child: InkWell(
      onTap: retrocederPage,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              24.0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 20.0, // has the effect of softening the shadow
              spreadRadius: 2.0,
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.black45,
        ),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.0,
          ),
          onPressed: retrocederPage,
        ),
      ),
    ),
  );
}
