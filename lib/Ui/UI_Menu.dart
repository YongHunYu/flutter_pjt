import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Provider/PRVD_Menu.dart';
import 'package:untitled/Global/G_Variable.dart';

//메인메뉴
class MenuPage extends StatefulWidget {
  MenuPage({Key key}) : super(key: key);
  static const routeName = '/menu';

  @override
  _MenuPageState createState() => _MenuPageState();

}

class _MenuPageState extends State<MenuPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // id에 따라 페이지 이동 정하는 함수
  _moveToPage(context, String value) {
    switch(value){
    //재고조회
      case "UI_CELL":
        {
          Navigator.pushReplacementNamed(context, '/cellinfo');
        }break;
    //재고실사
      case "UI_STK_TAKING":
        {
          Navigator.pushReplacementNamed(context, '/stktaking');
        }break;
    //재고이동
      case "UI_STK_MOVE":
        {
          Navigator.pushReplacementNamed(context, '/stkmove');
        }break;
    //입고
      case "UI_PA":
        {
          Navigator.pushReplacementNamed(context, '/painfo');
        }break;
    }
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Text(
            'MainMenu : ' + G_SRT_userNm,
            style: new TextStyle(fontSize: 16.0),
          )
        ],
      ),
      backgroundColor: Colors.blue,
      centerTitle: true,
      //leading: new Icon(Icons.zoom_out_sharp),
      actions: <Widget>[
        new IconButton(
          icon: new Icon(Icons.logout),
          tooltip: 'LogOut',
          onPressed: () => {
            Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (Route<dynamic> route) => false
            )
          }, // onPressed
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
          child: ChangeNotifierProvider<Prvd_Menu>(
            create: (context) => Prvd_Menu(),
            child: Consumer<Prvd_Menu> (
              builder: (context, provider, child) {
                if(provider.menuInfo == null) {
                  provider.getMenuData(context, G_STR_userId);
                  return Center(child: CircularProgressIndicator());
                }
                return ListView.separated(
                  itemCount: provider.menuInfo.LS_info.length - 1,
                  itemBuilder: (context, index){
                    final item = provider.menuInfo.LS_info[index + 1].pMENU_NM;
                    return ListTile(
                      tileColor: Colors.white,
                      leading: Icon(Icons.add),
                      title: Text(
                        item,
                        style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                      dense: false,
                      //tileColor: Colors.lightBlueAccent,
                      // selected : true
                      onTap: () {
                        _moveToPage(context, provider.menuInfo.LS_info[index + 1].pMENU_ID);
                      },
                      onLongPress: () {
                        // do something else
                      },
                    );
                  }, // itemBuilder
                  separatorBuilder: (context, index) {
                    return Divider(
                        color: Colors.lightBlueAccent,
                        height: 2,
                        thickness: 2,
                        //구분선의 굵기
                        indent: 1,
                        endIndent: 0
                    );
                  },// separatorBuilder
                );
              }, // builder
            ),
          ),
        ),
        onWillPop: () {}
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      backgroundColor: Colors.lightBlueAccent,
    );
  }
}