import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Global/G_Control.dart';
import 'package:untitled/Provider/PRVD_SignUp.dart';

/// 사용자추가 화면
class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);
  static const routeName = '/signup';

  @override
  _SignUpPageState createState() => _SignUpPageState();

}

var _selValue;

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController TEC_id = TextEditingController();
  TextEditingController TEC_password = TextEditingController();
  TextEditingController TEC_confirmPw = TextEditingController();
  TextEditingController TEC_name = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    TEC_id.dispose();
    TEC_password.dispose();
    TEC_confirmPw.dispose();
    TEC_name.dispose();
    super.dispose();
  }

  String passwordValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return null;
    }
  }

  // 사용자 추가 함수
  _SignUpData(Prvd_SignUp provider) async{

    // // 입력값 1차 확인
    if(TEC_id.text == null || TEC_id.text ==''){
      showDialogOk(context, '사용자 ID를 입력 하십시오.', "알림");
      return;
    }
    if(TEC_password.text == null || TEC_password.text ==''){
      showDialogOk(context, '사용자 PassWord를 입력 하십시오.', "알림");
      return;
    }
    if(TEC_confirmPw.text == null || TEC_confirmPw.text ==''){
      showDialogOk(context, '사용자 Check PassWord를 입력 하십시오.', "알림");
      return;
    }
    if(TEC_name.text == null || TEC_name.text ==''){
      showDialogOk(context, '사용자 Name를 입력 하십시오.', "알림");
      return;
    }
    if(TEC_password.text != TEC_confirmPw.text){
      showDialogOk(context, 'Check PassWord와 PassWord를 확인해 주시기 바랍니다.', "알림");
      return;
    }

    // 데이터 전송
    provider.sendUserData(
        context,
        TEC_id.text,         // ID
        TEC_password.text,         // PASSWORD
        TEC_name.text,         // NAME
        _selValue.toString()  // USER_GRP
    );

    // 사용자 추가 성공시
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Success'),
            content: SingleChildScrollView(
              child: Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 좌측정렬
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Text(
                      'User Add Success',
                    ),
                    new SizedBox(height: 20,),
                    new Text(
                      'USER ID : ' + TEC_id.text,
                    ),
                    new SizedBox(height: 10,),
                    new Text(
                      'USER GROUP : ' + _selValue.toString(),
                    ),
                    new SizedBox(height: 10,),
                    new Text(
                      'USER NAME : ' + TEC_name.text,
                    ),
                    new SizedBox(height: 30,),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text('OK'),
                  onPressed: (){
                    // 로그인 화면으로 이동
                    Navigator.pushReplacementNamed(context, '/login');
                  } // onPressed
              )
            ],
          );
        } // builder
    ); // showDialogs

    setState(() { });
  } // _SignUpData

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
              '사용자 추가',
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
          onTap: (){
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ChangeNotifierProvider<Prvd_SignUp>(
            create: (context) => Prvd_SignUp(),
            child: Consumer<Prvd_SignUp>(
              builder: (context, provider, child) {
                if (provider.uiInfo == null) {
                  provider.getUiData(context, 'SIGN_UP_INFO');
                  return Center(child: CircularProgressIndicator());
                }
                return  ListView(
                  children: <Widget>[
                    Container(
                      margin: new EdgeInsets.all(10),
                      padding: new EdgeInsets.all(5),
                      child: new Column(
                        children: <Widget>[
                          new Row(
                              children: <Widget>[
                                new Text(
                                  'ID : ',
                                  style: new TextStyle(fontSize: 15),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    child: new TextField(
                                      autofocus: true,
                                      controller: TEC_id,
                                      decoration: InputDecoration(
                                        labelText: 'ID',
                                        hintText: 'ex) DLS',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          ),
                          new Row(
                              children: <Widget>[
                                new Text(
                                  'PW : ',
                                  style: new TextStyle(fontSize: 15),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    child: new TextField(
                                      obscureText: true,
                                      controller: TEC_password,
                                      decoration: InputDecoration(
                                        labelText: 'PASSWORD',
                                        hintText: '비밀번호 입력하세요.',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          ),
                          new Row(
                              children: <Widget>[
                                new Text(
                                  'CHECK PW : ',
                                  style: new TextStyle(fontSize: 15),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    child: new TextField(
                                      obscureText: true,
                                      controller: TEC_confirmPw,
                                      decoration: InputDecoration(
                                        labelText: 'CHECK PASSWORD',
                                        hintText: 'PW 확인을 위해 한번 더 입력하세요.',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          ),
                          new Row(
                              children: <Widget>[
                                new Text(
                                  'USER GROUP : ',
                                  style: new TextStyle(fontSize: 15),
                                ),
                                Container(
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    child: new DropdownButton<String>(
                                        value: _selValue,
                                        items: provider.uiInfo.LS_uiInfo.map<DropdownMenuItem<String>>((data) =>
                                            DropdownMenuItem<String>(
                                              value: data.pCCD_NM,
                                              child: Text(data.pCCD_NM),
                                            )
                                        ).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            _selValue = value;
                                          });
                                        }
                                    )
                                ),
                              ]
                          ),
                          new Row(
                              children: <Widget>[
                                new Text(
                                  'NAME : ',
                                  style: new TextStyle(fontSize: 15),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 50,
                                    padding: EdgeInsets.all(5),
                                    child: new TextField(
                                      controller: TEC_name,
                                      decoration: InputDecoration(
                                        labelText: 'USER NAME',
                                        hintText: 'ex) DLS',
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                )
                              ]
                          ),
                          new SizedBox(height: 30,),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 50,
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: new RaisedButton(
                                    color: Colors.blue,
                                    textColor: Colors.white,
                                    child: Text('사용자 추가'),
                                    onPressed: (){

                                      _SignUpData(provider);
                                    }
                                ),
                              )
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                );

              },
            ),
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