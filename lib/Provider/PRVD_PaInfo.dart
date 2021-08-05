import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Global/G_Variable.dart';
import 'package:untitled/Model/MD_PaInfo.dart';
import 'package:untitled/Model/MD_UiInfo.dart'; //http 통신을 위한 패키지 추가.

class Prvd_PaInfo extends ChangeNotifier
{

  PaInfo_Data paInfo;
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

  Future<int> getPaData(context, String parValues) async{
    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort +'/mbo/stk_move_from_info.jsp';

    Map<String, String> queryParams = {
      'parValue' : parValues
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.paInfo = PaInfo_Data.fromJson(jsonBody);
      this.notifyListeners();

      return this.paInfo.LS_paInfo.length;

    }
    return 0;
  }
}