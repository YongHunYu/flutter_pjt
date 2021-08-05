import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http; //http 통신을 위한 패키지 추가.
import 'package:untitled/Model/MD_CellInfo.dart';
import 'package:untitled/Global/G_Variable.dart';


class Prvd_CellInfo extends ChangeNotifier
{
  CellInfo_Data cellInfo;

  Future<int> getCellData(context, String P_STR_Values, String P_STR_Option) async {

    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort +'/mbo/cell_info.jsp';

    Map<String, String> queryParams = {
      'parValue': P_STR_Values,
      'parOpt': P_STR_Option
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.cellInfo = CellInfo_Data.fromJson(jsonBody);
      this.notifyListeners();

      return this.cellInfo.LS_cellInfo.length;

    }
    return 0;
  }
}

