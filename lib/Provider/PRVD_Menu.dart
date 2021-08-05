import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http; //http 통신을 위한 패키지 추가.
import 'package:untitled/Model/MD_Menu.dart';
import 'package:untitled/Global/G_Variable.dart';

class Prvd_Menu extends ChangeNotifier
{
  Menu_Data menuInfo;

  Future getMenuData(context, String P_STR_UserId) async {

    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort + '/mbo/menu_list.jsp';

    Map<String, String> queryParams = {
      'id': P_STR_UserId
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.menuInfo = Menu_Data.fromJson(jsonBody);
      this.notifyListeners();
    }
  }
}