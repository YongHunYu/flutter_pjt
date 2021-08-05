class StockMoveSave_Data {
  List<SaveData> LS_saveData;
  List<Info> LS_info;

  StockMoveSave_Data({this.LS_saveData, this.LS_info});

  StockMoveSave_Data.fromJson(Map<String, dynamic> json) {
    if (json['cell_info'] != null) {
      LS_saveData = new List<SaveData>();
      json['cell_info'].forEach((v) {
        LS_saveData.add(new SaveData.fromJson(v));
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
    if (this.LS_saveData != null) {
      data['cell_info'] = this.LS_saveData.map((v) => v.toJson()).toList();
    }
    if (this.LS_info != null) {
      data['info'] = this.LS_info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SaveData {
  String pFR_CELL_NO;
  String pTO_CELL_NO;

  SaveData({this.pFR_CELL_NO, this.pTO_CELL_NO});

  SaveData.fromJson(Map<String, dynamic> json) {
    pFR_CELL_NO = json['FR_CELL_NO'];
    pTO_CELL_NO = json['TO_CELL_NO'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FR_CELL_NO'] = this.pFR_CELL_NO;
    data['TO_CELL_NO'] = this.pTO_CELL_NO;
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
