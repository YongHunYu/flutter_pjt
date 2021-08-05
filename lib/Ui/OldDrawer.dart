import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Global/G_Variable.dart';
import 'package:untitled/Provider/PRVD_Menu.dart';

class Sub_MenuPage extends StatelessWidget {

  Widget _buildDrawer() {
    return ChangeNotifierProvider<Prvd_Menu> (
      create: (context) => Prvd_Menu(),
      child: Consumer<Prvd_Menu> (
          builder: (context, provider, child) {
            if (provider.menuInfo == null) {
              provider.getMenuData(context, G_STR_userId);
              return Center(child: CircularProgressIndicator());
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                children: <Widget>[
                  new DrawerHeader(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: <Color>[Colors.lightBlue, Colors.blue]
                        )
                    ),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Material(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50.0)),
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image.asset("images/doosan.jpg", height: 90, width: 90),
                            ),
                          ),
                          SizedBox(height: 2,),
                          Text(
                            G_SRT_userNm,
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  _customListTile(Icons.article_outlined, 'MainMenu', 'UI_MAIN_MENU'),
                  new ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: provider.menuInfo.LS_info.length - 1,
                    itemBuilder: (context, index) {
                      final itemNM = provider.menuInfo.LS_info[index + 1].pMENU_NM;
                      final itemID = provider.menuInfo.LS_info[index + 1].pMENU_ID;
                      return _customListTile(Icons.adjust, itemNM, itemID);
                    }, // itemBuilder: (context, index)
                  ),
                  _customListTile(Icons.logout, 'LogOut', 'UI_LOGIN'),
                ],
              ),
            );
          }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer (
      child: Container (
        child: _buildDrawer(),
      ),
    );
  }

}

class _customListTile extends StatelessWidget {
  final IconData icon;
  final String name;
  final String code;

  _customListTile(this.icon, this.name, this.code);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        child: InkWell(
            splashColor: Colors.blue,
            onTap: () {
              switch(code){
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

              //메인메뉴
                case "UI_MAIN_MENU" :
                  {
                    Navigator.pushNamedAndRemoveUntil(context, '/menu', (Route<dynamic> route) => false);
                  }break;
              // logout
                case "UI_LOGIN" :
                  {
                    Navigator.pushNamedAndRemoveUntil(context, '/login', (Route<dynamic> route) => false);
                  }break;
              }
            },
            child: Container(
                height: 50, // 버튼높이
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          icon,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(
                          name,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    // Icon(Icons.arrow_right),
                  ],
                )
            )
        ),
      ),
    );
  }
}