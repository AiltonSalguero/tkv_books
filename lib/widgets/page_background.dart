import 'package:flutter/material.dart';
import 'package:tkv_books/util/screen.dart';

class PageBackground extends StatelessWidget {
  final String backgroundImagePath;
  final Widget header;
  final Widget content;
  final Widget floatingButton;
  final Widget topButton;

  PageBackground(
      {Key key,
      this.backgroundImagePath,
      this.header,
      this.content,
      this.floatingButton,
      this.topButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.asset(
            backgroundImagePath,
            fit: BoxFit.cover,
            height: Screen.height * 0.35, // Responsive
            width: double.infinity,
          ),
          header == null ? Text("") : header,
          topButton == null ? Text("") : topButton,
          Container(
            height: double.infinity,
            width: double.infinity,
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
            child: Padding(
              padding: EdgeInsets.only(
                top: 16.0,
              ),
              child: content,
            ),
          ),
        ],
      ),
      floatingActionButton: floatingButton,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
