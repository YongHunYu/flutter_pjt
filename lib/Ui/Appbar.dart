import 'package:flutter/material.dart';

/// AppBar
class appBar extends StatelessWidget implements PreferredSizeWidget {
  String STR_appTitle;
  final List<Widget> LS_widgets;
  appBar({Key key, this.STR_appTitle, this.LS_widgets}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              STR_appTitle,
              style: new TextStyle(fontSize: 16.0),
            )
          ],
        ),
        backgroundColor: Colors.blue,
        centerTitle: true
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}
