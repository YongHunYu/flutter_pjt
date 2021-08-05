import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Global/G_Variable.dart';
import 'package:untitled/Model/MD_SignUp.dart';
import 'package:untitled/Model/MD_UiInfo.dart'; //http 통신을 위한 패키지 추가.

class Prvd_SignUp extends ChangeNotifier
{
  SignUp_Data signUpInfo;
  UiInfo_Data uiInfo;

  Future getUiData(context, String P_STR_UiInfo) async {
    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort + '/mbo/ui_info.jsp';

    Map<String, String> queryParams = {
      'parValue': P_STR_UiInfo
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.uiInfo = UiInfo_Data.fromJson(jsonBody);
      this.notifyListeners();
    }
  }

  Future sendUserData(context, String P_STR_UserID, String P_STR_UserPW,String P_STR_UserName, String P_STR_UserGRP) async {

    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort + '/mbo/sign_up.jsp';

    Map<String, String> queryParams = {
      'parValueID': P_STR_UserID,
      'parValuePW': P_STR_UserPW,
      'parValueNAME': P_STR_UserName,
      'parValueGRP': P_STR_UserGRP,
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.signUpInfo = SignUp_Data.fromJson(jsonBody);
      this.notifyListeners();
    }
  }
}