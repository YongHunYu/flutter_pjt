import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http; //http 통신을 위한 패키지 추가.
import 'package:untitled/Global/G_Variable.dart';
import 'package:untitled/Model/MD_UiInfo.dart';
import 'package:untitled/Model/StockTaking/MD_Taking.dart';
import 'package:untitled/Model/StockTaking/MD_TakingSave.dart';

class Prvd_StockTaking extends ChangeNotifier
{
  StockTakingSave_Data saveDataInfo;
  StockTaking_Data takingDataInfo;
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

  Future<int> sendTakingData(context
      ,String P_STR_CellNo
      ,String P_STR_SkuQty
      ,String P_STR_CellLoc
      ,String P_STR_Remark
      ,String P_STR_InvCntType) async {

    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort +'/mbo/inv_count_save.jsp';

    Map<String, String> queryParams = {
      'parCellNo' : P_STR_CellNo,
      'parSkuQty' : P_STR_SkuQty,
      'parCellLoc' : P_STR_CellLoc,
      'parInvRemark' : P_STR_Remark,
      'parInvCntType' : P_STR_InvCntType
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.saveDataInfo = StockTakingSave_Data.fromJson(jsonBody);
      this.notifyListeners();

      return this.saveDataInfo.LS_info.length;

    }
    return 0;
  }

  Future<int> getTakingData(context, String P_STR_CellNo) async {
    var client = new http.Client();
    var endpointUrl = 'http://' + G_SRT_gIp + ':' + G_SRT_gPort +'/mbo/inv_count_info.jsp';

    Map<String, String> queryParams = {
      'parValue': P_STR_CellNo
    };

    String queryString = Uri(queryParameters: queryParams).query;

    var requestUrl = endpointUrl + '?' + queryString;
    var response = await http.get(requestUrl);

    if (response.statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes);
      var jsonBody = json.decode(responseBody);

      this.takingDataInfo = StockTaking_Data.fromJson(jsonBody);
      this.notifyListeners();

      return this.takingDataInfo.LS_takingData.length;

    }
    return 0;
  }

}