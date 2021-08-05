import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http; //http 통신을 위한 패키지 추가.
import 'package:untitled/Global/G_Variable.dart';
import 'package:untitled/Model/StockMove/MD_MoveFrom.dart';
import 'package:untitled/Model/StockMove/MD_MoveSave.dart';
import 'package:untitled/Model/StockMove/MD_MoveTo.dart';

class Prvd_StockMove extends ChangeNotifier
{

  StockMoveFrom_Data fromDataInfo;
  StockMoveTo_Data toDataInfo;
  StockMoveSave_Data saveDataInfo;

  Future<int> getFromData(context, String P_STR_CellNo, String parOption) async {
    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort +'/mbo/stk_move_from_info.jsp';
    // var endpointUrl = 'http://' + gIp + ':' + gPort +'/mbo/cell_info.jsp';

    Map<String, String> queryParams = {
      'parValue' : P_STR_CellNo,
      'parOpt': parOption
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.fromDataInfo = StockMoveFrom_Data.fromJson(jsonBody);
      this.notifyListeners();

      return this.fromDataInfo.LS_fromData.length;

    }
    return 0;
  }

  Future<int> getToData(context, String P_STR_CellNo, String parOption) async {
    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort +'/mbo/stk_move_to_info.jsp';
    // var endpointUrl = 'http://' + gIp + ':' + gPort +'/mbo/cell_info.jsp';

    Map<String, String> queryParams = {
      'parValue' : P_STR_CellNo,
      'parOpt': parOption
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.toDataInfo = StockMoveTo_Data.fromJson(jsonBody);
      this.notifyListeners();

      return this.toDataInfo.LS_toData.length;

    }
    return 0;
  }

  Future<int> sendMoveData(context, String P_STR_FrCell, String P_STR_ToCell) async {
    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort +'/mbo/stk_move_save.jsp';

    Map<String, String> queryParams = {
      'parValueFrCell' : P_STR_FrCell,
      'parValueToCell': P_STR_ToCell
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.saveDataInfo = StockMoveSave_Data.fromJson(jsonBody);
      this.notifyListeners();

      return this.saveDataInfo.LS_saveData.length;

    }
    return 0;
  }
}