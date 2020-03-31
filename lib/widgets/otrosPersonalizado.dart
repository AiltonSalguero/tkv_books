import 'package:flutter/material.dart';

Widget bookMark() {
  return Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.only(
        top: 150, // Responsive 262
        right: 32,
      ),
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(24.0),
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
            color: Colors.white),
        child: IconButton(
          icon: Icon(
            Icons.bookmark_border,
            color: Colors.black,
            size: 24.0,
          ),
          onPressed: () {},
        ),
      ),
    ),
  );
}

