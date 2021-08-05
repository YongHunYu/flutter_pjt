import 'package:untitled/Global/G_Variable.dart';

class Menu_Data {
  List<Info> LS_info;

  Menu_Data({this.LS_info});

  Menu_Data.fromJson(Map<String, dynamic> json) {
    if (json['info'] != null) {
      LS_info = new List<Info>();
      json['info'].forEach((v) {
        LS_info.add(new Info.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.LS_info != null) {
      data['info'] = this.LS_info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  String vSqlMsg;
  String nSqlCd;
  String nPdaCd;
  String vPdaMsg;
  String pMENU_ID;
  String pMENU_NM;

  Info(
      {this.vSqlMsg,
        this.nSqlCd,
        this.nPdaCd,
        this.vPdaMsg,
        this.pMENU_ID,
        this.pMENU_NM});

  Info.fromJson(Map<String, dynamic> json) {
    vSqlMsg = json['vSqlMsg'];
    nSqlCd = json['nSqlCd'];
    nPdaCd = json['nPdaCd'];
    vPdaMsg = json['vPdaMsg'];
    pMENU_ID = json['MENU_ID'];
    pMENU_NM = json['MENU_NM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['vSqlMsg'] = this.vSqlMsg;
    data['nSqlCd'] = this.nSqlCd;
    data['nPdaCd'] = this.nPdaCd;
    data['vPdaMsg'] = this.vPdaMsg;
    data['MENU_ID'] = this.pMENU_ID;
    data['MENU_NM'] = this.pMENU_NM;
    return data;
  }
}