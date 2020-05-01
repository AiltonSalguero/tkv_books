import 'package:flutter/material.dart';
import 'package:tkv_books/util/screen.dart';

class PageBackground extends StatelessWidget {
  Widget header;
  Widget content;

  PageBackground({Key key, this.header, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topLeft,
        children: <Widget>[
          header,
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32.0),
                topLeft: Radius.circular(32.0),
              ),
              border: Border.all(
                color: Colors.black,
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
              top: Screen.height * 0.3, // Responsive 266
            ),
            child: content,
          ),
        ],
      ),
    );
  }
}
