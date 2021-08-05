import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/UI/Appbar.dart';
import 'package:untitled/Global/G_Variable.dart';
import 'package:untitled/Global/G_Control.dart';

/// ip및 port 변경 화면
class SettingPage extends StatefulWidget {
  static const routeName = '/setting';

  @override
  SettingPage_State createState() => SettingPage_State();
}

class SettingPage_State extends State<SettingPage> {
  SharedPreferences _prefs;

  //컨트롤러 선언
  final TEC_realIp = TextEditingController();
  final TEC_realPort = TextEditingController();
  final TEC_devIp = TextEditingController();
  final TEC_devPort = TextEditingController();

  @override
  void initState() {
    _loadGetInfo(); //저장된 값을 가져온다.
    super.initState();
  }

  @override
  void dispose(){
    TEC_realIp.dispose();
    TEC_realPort.dispose();
    TEC_devIp.dispose();
    TEC_devPort.dispose();
    super.dispose();
  }

  //저장된 값을 불러와 변수에 저장한다.
  _loadGetInfo() async {
    // SharedPreferences의 인스턴스를 필드에 저장
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      // SharedPreferences에 저장된 값을 불러와 변수에 대입한다. 저장된 값이 없을 경우 기본 값 설정.
      G_SRT_realIp = (_prefs.getString('realIp') ?? '127.0.0.1');
      G_SRT_realPort = (_prefs.getString('realPort') ?? '9999');
      G_SRT_devIp = (_prefs.getString('devIp') ?? '127.0.0.1');
      G_SRT_devPort = (_prefs.getString('devPort') ?? '9999');

      TEC_realIp.text = G_SRT_realIp;
      TEC_realPort.text = G_SRT_realPort;
      TEC_devIp.text = G_SRT_devIp;
      TEC_devPort.text = G_SRT_devPort;

      _handleRadioValueChange1(G_I_ConOpt);
    });
  }

  //화면의 설정 값을 저장한다.
  _saveInfo() async {
    setState(() {
      _prefs.setString('realIp', TEC_realIp.text);
      _prefs.setString('realPort', TEC_realPort.text);
      _prefs.setString('devIp', TEC_devIp.text);
      _prefs.setString('devPort', TEC_devPort.text);
      _prefs.setInt('ConOpt', G_I_ConOpt);

      if (G_I_ConOpt == 0) {
        //0은 운영서버이다.
        G_SRT_gIp = G_SRT_realIp;
        G_SRT_gPort = G_SRT_realPort;
      } else {
        //1은 개발서버이다.
        G_SRT_gIp = G_SRT_devIp;
        G_SRT_gPort = G_SRT_devPort;
      }

      //저장완료 메시지 출력.
      showDialogOk(context,"저장이 완료 되었습니다.","저장완료");
    });
  }

  //라디오 버튼 핸들러 추가.
  _handleRadioValueChange1(int value) {
    setState(() {
      G_I_ConOpt = value;
    });
  }

  //대화상자 결과 값을 가지고 저장한다.
  _ChkResult(BuildContext context) async {
    bool B_result = await asyncConfirmDialog(context, "입력한 사항을 저장합니다.", "저장하시겠습니까?");
    if (B_result == true) {
      _saveInfo();
    }
  }

  Widget _buildAppBar() {
    return AppBar(
        leading: new IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () {
              // 키보드 내리기
              FocusScopeNode currentFocus = FocusScope.of(context);
              currentFocus.unfocus();

              Navigator.pop(context);
            }
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              'Ip Setting',
              style: new TextStyle(fontSize: 16.0),
            )
          ],
        ),
        backgroundColor: Colors.blue,
        centerTitle: true
    );
  }

  Widget _buildBody() {
    return WillPopScope(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Center(
            child: ListView(children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '환경설정',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  autofocus: true,
                  //focusNode: FocusID,
                  controller: TEC_realIp,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '운영서버 IP',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  autofocus: true,
                  //focusNode: FocusID,
                  controller: TEC_realPort,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '운영서버 PORT',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  autofocus: true,
                  //focusNode: FocusID,
                  controller: TEC_devIp,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '개발서버 IP',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: TextField(
                  autofocus: true,
                  //focusNode: FocusID,
                  controller: TEC_devPort,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '개발서버 PORT',
                  ),
                ),
              ),
              Container(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: 0,
                        groupValue: G_I_ConOpt,
                        activeColor: Colors.green,
                        onChanged: _handleRadioValueChange1,
                      ),
                      new Text(
                        '운영서버',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                      new Radio(
                        value: 1,
                        groupValue: G_I_ConOpt,
                        activeColor: Colors.green,
                        onChanged: _handleRadioValueChange1,
                      ),
                      new Text(
                        '개발서버',
                        style: new TextStyle(fontSize: 16.0),
                      ),
                    ],
                  )),
              Container(
                  height: 50,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    child: Text('저 장', style: TextStyle(fontSize: 24)),
                    onPressed: () {
                      _ChkResult(context);
                    },
                  )),
            ]),
          ),
        ),
        onWillPop: () {
          // Navigator.pop(context);
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