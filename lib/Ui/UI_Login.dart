import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Provider/PRVD_Login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/Global/G_Variable.dart';
import 'package:untitled/Global/G_Control.dart';

/*

작성자 : 김주성
작성일자 : 2021-03-04
수정자 : 유용훈
수정일자 : 2021-08-05
화면설명 : Login화면

수정이력 : 2021-08-05 / 유용훈 / 소스정리 및 화면 이동방식 변경

 */

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  static const routeName = '/login';

  @override
  _LoginPageState createState() => _LoginPageState();

}

class _LoginPageState extends State<LoginPage>{

  SharedPreferences _prefs;

  FocusNode FocusID = new FocusNode(); //포커스 노드 선언
  FocusNode FocusPW = new FocusNode(); //포커스 노드 선언

  TextEditingController TEC_name = TextEditingController();     //ID컨트롤러 선언
  TextEditingController TEC_password = TextEditingController(); //PW컨트롤러 선언

  @override
  void initState() {
    super.initState();

    // myFocusNode에 포커스 인스턴스 저장.
    FocusID = FocusNode();
    FocusPW = FocusNode();

    //설정 정보를 가져온다.
    _getSetInfo();
  }

  @override
  void dispose() {
    // 폼이 삭제되면 myFocusNode 삭제됨
    FocusID.dispose();
    FocusPW.dispose();

    TEC_name.dispose();
    TEC_password.dispose();
    super.dispose();
  }

  //초기 설정 값을 가져오는 함수.
  _getSetInfo() async {
    _prefs = await SharedPreferences.getInstance();

    setState(() {
      // SharedPreferences에 저장된 값을 불러와 변수에 대입한다. 저장된 값이 없을 경우 기본 값 설정.
      G_SRT_realIp = (_prefs.getString('realIp') ?? '127.0.0.1');
      G_SRT_realPort = (_prefs.getString('realPort') ?? '9999');
      G_SRT_devIp = (_prefs.getString('devIp') ?? '127.0.0.1');
      G_SRT_devPort = (_prefs.getString('devPort') ?? '9999');
      G_I_ConOpt = (_prefs.getInt('ConOpt') ?? '0');

      if (G_I_ConOpt == 0) {
        //0은 운영서버이다.
        G_SRT_gIp = G_SRT_realIp;
        G_SRT_gPort = G_SRT_realPort;
      } else {
        //1은 개발서버이다.
        G_SRT_gIp = G_SRT_devIp;
        G_SRT_gPort = G_SRT_devPort;
      }
    });
  }

  _sendLoginData(BuildContext context, Prvd_Login provider) async {

    int I_result;
    G_STR_userId = TEC_name.text;

    //ID 검증.
    if (TEC_name.text == null || TEC_name.text == '') {
      showDialogOk(context, '사용자 ID를 입력 하십시오.', "알림");
      FocusScope.of(context).requestFocus(FocusID);
      return;
    }

    //패스워드 검증
    if (TEC_password.text == null || TEC_password.text == '') {
      showDialogOk(context, '사용자 비밀번호를 입력 하십시오.', "알림");
      FocusScope.of(context).requestFocus(FocusPW);
      return;
    }

    I_result = await provider.getLoginData(context, TEC_name.text, TEC_password.text);

    if(I_result == 0) {
      showDialogOk(context, provider.loginInfo.LS_info[0].vPdaMsg.toString(), "알림");
    }

    G_SRT_userNm = provider.loginInfo.LS_info[1].userNm.toString();
    // 라우트의 이름으로 새로운 라우트 적재
    Navigator.pushReplacementNamed(context, '/menu');

    setState(() { });
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "두산로지스틱스솔루션",
            style: new TextStyle(fontSize: 20.0),
          )
        ],
      ),
      centerTitle: true,
      //leading: new Icon(Icons.zoom_out_sharp),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.settings),
          tooltip: '설정',
          onPressed: () {
            Navigator.pushNamed(context, '/setting');
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return WillPopScope(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ChangeNotifierProvider<Prvd_Login>(
            create: (context) => Prvd_Login(),
            child: Consumer<Prvd_Login>(
              builder: (context, provider, child) {
                // if(provider.data == null) {
                //   provider.getData(context, nameController.text.toString(), passwordController.text.toString());
                // }
                return Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        Container(
                            child: Image.asset('images/doosan.jpg', width: 70, height: 70) //로컬 이미지 로딩
                        ),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'DLS MOBILE',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            )),
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              '로그인',
                              style: TextStyle(fontSize: 20),
                            )),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            autofocus: true,
                            focusNode: FocusID,
                            controller: TEC_name,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'ID 입력',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            obscureText: true,
                            focusNode: FocusPW,
                            controller: TEC_password,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: '비밀번호 입력',
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            //forgot password screen
                          },
                          textColor: Colors.blue,
                          child: Text('Forgot Password'),
                        ),
                        Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              child: Text('로그인'),
                              onPressed: () {
                                //입력한 아이디 및 암호 자릿수 검증로직 필요.
                                //톰캣 서버로부터 로그인 정보가 유효한지 확인한 후,
                                //메뉴 리스트를 불러온다.

                                _sendLoginData(context, provider);
                              },
                            )
                        ),
                        Container(
                            child: Row(
                              children: <Widget>[
                                Text('Does not have account?'),
                                FlatButton(
                                  textColor: Colors.blue,
                                  child: Text(
                                    'Sign in',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/signup');
                                  },
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ))
                      ],
                    )
                );
              },
            ),
          ),
        ),
        onWillPop: () {

        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }
}