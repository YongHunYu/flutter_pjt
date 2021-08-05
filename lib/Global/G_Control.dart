library dialog;

import 'package:flutter/material.dart';

///이곳에는 화면상 표시되는 알람 위젯등을 정의한다.
showDialogOk(BuildContext context, String Messages, String Title) {
  // set up the AlertDialog
  AlertDialog alert = new AlertDialog(
    title: Text(Title),
    content: Text(Messages),
    actions: <Widget>[
      new FlatButton(
        child: new Text("확인"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<bool> asyncConfirmDialog(BuildContext context, String Messages, String Title) async {
  return await showDialog(
    context: context,
    barrierDismissible: false, // user must tap button for close dialog!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(Title),
        content:  Text(Messages),
        actions: [
          FlatButton(
            child: const Text('아니요'),
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.pop(context, false);
              return false;
            },
          ),
          FlatButton(
            child: const Text('예'),
            onPressed: () {
              // Navigator.of(context).pop();
              Navigator.pop(context, true);
              return true;
            },
          )
        ],
      );
    },
  );
}