class StockMoveTo_Data {
  List<ToData> LS_toData;
  List<Info> LS_info;

  StockMoveTo_Data({this.LS_toData, this.LS_info});

  StockMoveTo_Data.fromJson(Map<String, dynamic> json) {
    if (json['cell_info'] != null) {
      LS_toData = new List<ToData>();
      json['cell_info'].forEach((v) {
        LS_toData.add(new ToData.fromJson(v));
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
    if (this.LS_toData != null) {
      data['cell_info'] = this.LS_toData.map((v) => v.toJson()).toList();
    }
    if (this.LS_info != null) {
      data['info'] = this.LS_info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ToData {
  String pCELL_NO;
  String pCELL_SEQ;
  String pCELL_LMT_CD;

  ToData({this.pCELL_NO, this.pCELL_SEQ, this.pCELL_LMT_CD});

  ToData.fromJson(Map<String, dynamic> json) {
    pCELL_NO = json['CELL_NO'];
    pCELL_SEQ = json['CELL_SEQ'];
    pCELL_LMT_CD = json['CELL_LMT_CD'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CELL_NO'] = this.pCELL_NO;
    data['CELL_SEQ'] = this.pCELL_SEQ;
    data['CELL_LMT_CD'] = this.pCELL_LMT_CD;
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