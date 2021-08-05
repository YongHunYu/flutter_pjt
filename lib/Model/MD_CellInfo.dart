class CellInfo_Data {
  List<CellInfo> LS_cellInfo;
  List<Info> LS_info;

  CellInfo_Data({this.LS_cellInfo, this.LS_info});

  CellInfo_Data.fromJson(Map<String, dynamic> json) {
    if (json['cell_info'] != null) {
      LS_cellInfo = new List<CellInfo>();
      json['cell_info'].forEach((v) {
        LS_cellInfo.add(new CellInfo.fromJson(v));
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
    if (this.LS_cellInfo != null) {
      data['cell_info'] = this.LS_cellInfo.map((v) => v.toJson()).toList();
    }
    if (this.LS_info != null) {
      data['info'] = this.LS_info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CellInfo {
  String pPLT_QTY;
  String pAREA;
  String pPA_TIME;
  String pISSUCASE_ID;

  CellInfo({this.pPLT_QTY, this.pAREA, this.pPA_TIME, this.pISSUCASE_ID});

  CellInfo.fromJson(Map<String, dynamic> json) {
    pPLT_QTY = json['PLT_QTY'];
    pAREA = json['AREA'];
    pPA_TIME = json['PA_TIME'];
    pISSUCASE_ID = json['ISSUCASE_ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PLT_QTY'] = this.pPLT_QTY;
    data['AREA'] = this.pAREA;
    data['PA_TIME'] = this.pPA_TIME;
    data['ISSUCASE_ID'] = this.pISSUCASE_ID;
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