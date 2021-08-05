class StockTaking_Data {
  List<TakingData> LS_takingData;
  List<Info> LS_info;

  StockTaking_Data({this.LS_takingData, this.LS_info});

  StockTaking_Data.fromJson(Map<String, dynamic> json) {
    if (json['inv_info'] != null) {
      LS_takingData = new List<TakingData>();
      json['inv_info'].forEach((v) {
        LS_takingData.add(new TakingData.fromJson(v));
      });
    }
    if (json['info'] != null) {
      LS_info = new List<Info>();
      json['info'].forEach((v) {
        LS_info.add(new Info.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.LS_takingData != null) {
      data['inv_info'] = this.LS_takingData.map((v) => v.toJson()).toList();
    }
    if (this.LS_info != null) {
      data['info'] = this.LS_info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TakingData {
  String pITEM_CD;
  String pITEM_NM;
  String pLOT_NO;

  TakingData({this.pITEM_CD, this.pITEM_NM, this.pLOT_NO});

  TakingData.fromJson(Map<String, dynamic> json) {
    pITEM_CD = json['ITEM_CD'];
    pITEM_NM = json['ITEM_NM'];
    pLOT_NO = json['LOT_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ITEM_CD'] = this.pITEM_CD;
    data['ITEM_NM'] = this.pITEM_NM;
    data['LOT_NO'] = this.pLOT_NO;
    return data;
  }
}


class Info {
  String vSqlMsg;
  String nSqlCd;
  String nPdaCd;
  String vPdaMsg;

  Info({this.vSqlMsg, this.nSqlCd, this.nPdaCd, this.vPdaMsg});

  Info.fromJson(Map<String, dynamic> json) {
    vSqlMsg = json['vSqlMsg'];
    nSqlCd = json['nSqlCd'];
    nPdaCd = json['nPdaCd'];
    vPdaMsg = json['vPdaMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vSqlMsg'] = this.vSqlMsg;
    data['nSqlCd'] = this.nSqlCd;
    data['nPdaCd'] = this.nPdaCd;
    data['vPdaMsg'] = this.vPdaMsg;
    return data;
  }
}