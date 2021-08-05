import 'package:flutter/material.dart';
import 'dart:async';

/// 처음 어플 실행하면 띄워지는 화면
/// loading화면
class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);
  static const routeName = '/';

  @override
  _SplashPageState createState() => _SplashPageState();

}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    _loginPage();
  }

  /// 3초 후에 login화면으로 이동
  _loginPage() async {
    await Future.delayed(Duration(seconds: 3));
    return Navigator.pushReplacementNamed(context, '/login');
  }

  Widget _buildBody() {
    return Container(
      // color: Theme.of(context).primaryColor,
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Image.asset('images/Doosan_Logo_3C_RGB.jpg', width: 200, height: 200),
            Text('loading...', style: Theme.of(context).textTheme.body1.copyWith(color: Colors.black),),
            Text('Copyright © hunyong.', style: Theme.of(context).textTheme.caption.copyWith(color: Colors.black),)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }
}
