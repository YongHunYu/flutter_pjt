import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Global/G_Variable.dart';
import 'package:untitled/Provider/PRVD_Menu.dart';

/// Sub Menu
class Sub_MenuPage extends StatelessWidget {

  /// code에 따라 icon 변경
  IconData _iconDataChange(String Code){
    IconData icon;

    switch(Code){
    //시스템모니터링
      case "UI_SYS_MNTR":
        {
          icon = Icons.monitor;
        }break;
    //재고조회
      case "UI_CELL":
        {
          icon = Icons.ballot_outlined;
        }break;
    //재고실사
      case "UI_STK_TAKING":
        {
          icon = Icons.insert_chart_outlined;
        }break;
    //재고이동
      case "UI_STK_MOVE":
        {
          icon = Icons.move_to_inbox_outlined;
        }break;
    //입고
      case "UI_PA":
        {
          icon = Icons.inbox_outlined;
        }break;

    //메인메뉴
      case "UI_MAIN_MENU" :
        {
          icon = Icons.article_outlined;
        }break;
    // logout
      case "UI_LOGIN" :
        {
          icon = Icons.logout;
        }break;

      default :
        {
          icon = Icons.adjust_outlined;
        }break;
    }

    return icon;
  }

  Widget _drawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("images/doosan.jpg")
          )
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
                bottom: 12.0,
                left: 16.0,
                child: Text(
                  G_SRT_userNm,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500
                  ),
                )
            )
          ],
        )
    );
  }

  Widget _drawerItem({BuildContext context, String text, String code}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(_iconDataChange(code)),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
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
    );
  }

  Widget _buildDrawer(BuildContext context) {
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
                padding: EdgeInsets.zero,
                children: <Widget>[
                  _drawerHeader(),
                  _drawerItem(context: context, text: 'MainMenu', code: 'UI_MAIN_MENU'),
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(), // 스크롤 추가
                    itemCount: provider.menuInfo.LS_info.length - 1,
                    itemBuilder: (context, index) {
                      final itemNM = provider.menuInfo.LS_info[index + 1].pMENU_NM;
                      final itemID = provider.menuInfo.LS_info[index + 1].pMENU_ID;
                      return _drawerItem(context: context, text: itemNM, code: itemID);
                      }, // itemBuilder: (context, index)
                  ),
                  Divider(),
                  _drawerItem(context: context, text: 'LogOut', code: 'UI_LOGIN'),
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
      child: _buildDrawer(context)
    );
  }

}