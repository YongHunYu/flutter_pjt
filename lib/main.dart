import 'package:flutter/material.dart';
import 'package:untitled/Ui/UI_CellInfo.dart';
import 'package:untitled/Ui/UI_Login.dart';
import 'package:untitled/Ui/UI_Menu.dart';
import 'package:untitled/Ui/UI_StockMove.dart';
import 'package:untitled/Ui/UI_StockTaking.dart';
import 'package:untitled/Ui/Splash.dart';
import 'package:untitled/Ui/UI_SUB_Setting.dart';
import 'package:untitled/Ui/UI_SUB_SignUp.dart';
import 'package:untitled/Ui/UI_PaInfo.dart';

void main() => runApp(TestRoute());

class TestRoute extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      title: 'TestRouteApp',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: SplashPage.routeName,// initialRoute 설정. home이 아닌 초기 라우트로 설정
      routes: {
        SplashPage.routeName: ((context) => SplashPage()),
        LoginPage.routeName: ((context) => LoginPage()),
        SettingPage.routeName: ((context) => SettingPage()),
        SignUpPage.routeName: ((context) => SignUpPage()),
        MenuPage.routeName: ((context) => MenuPage()),
        StockTakingPage.routeName: ((context) => StockTakingPage()),
        CellInfoPage.routeName: ((context) => CellInfoPage()),
        StockMovePage.routeName: ((context) => StockMovePage()),
        PaInfoPage.routeName: ((context) => PaInfoPage()),
      },
      // onGenerateRoute: (settings) { // Navigator.pushNamed() 가 호출된 때 실행됨
      //   switch(settings.name){
      //     case MenuPage.routeName: {
      //       return MaterialPageRoute(
      //           builder: (context) => MenuPage()
      //       );
      //     }break;
      //     case SettingPage.routeName: {
      //       return MaterialPageRoute(
      //           builder: (context) => SettingPage()
      //       );
      //     }break;
      //     case SignUpPage.routeName: {
      //       return MaterialPageRoute(
      //           builder: (context) => SignUpPage()
      //       );
      //     }break;
      //     case Sub_MenuPage.routeName: {
      //       return MaterialPageRoute(
      //           builder: (context) => Sub_MenuPage()
      //       );
      //     }break;
      //     case CellInfoPage.routeName: {
      //       return MaterialPageRoute(
      //           builder: (context) => CellInfoPage()
      //       );
      //     }break;
      //     case StockMovePage.routeName: {
      //       return MaterialPageRoute(
      //           builder: (context) => StockMovePage()
      //       );
      //     }break;
      //     case StockTakingPage.routeName: {
      //       return MaterialPageRoute(
      //           builder: (context) => StockTakingPage()
      //       );
      //     }break;
      //     case PaInfoPage.routeName: {
      //       return MaterialPageRoute(
      //           builder: (context) => PaInfoPage()
      //       );
      //     }break;
      //
      //     default: {
      //       return MaterialPageRoute(
      //           builder: (context) => SplashPage()
      //       );
      //     } break;
      //   }
      // },
    );
  }
}
