import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http; //http 통신을 위한 패키지 추가.
import 'package:untitled/Model/MD_Login.dart';
import 'package:untitled/Global/G_Variable.dart';

class Prvd_Login extends ChangeNotifier
{
  Login_Data loginInfo;

  Future<int> getLoginData(context, String P_STR_UserId, String P_STR_UserPw) async {

    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort + '/mbo/login.jsp';

    Map<String, String> queryParams = {
      'id': P_STR_UserId,
      'pw': P_STR_UserPw,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.loginInfo = Login_Data.fromJson(jsonBody);
      this.notifyListeners();

      return this.loginInfo.LS_info.length;
    }
    return 0;
  }
}