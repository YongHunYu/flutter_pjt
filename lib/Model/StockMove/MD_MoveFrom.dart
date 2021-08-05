class StockMoveFrom_Data {
  List<FromData> LS_fromData;
  List<Info> LS_info;

  StockMoveFrom_Data({this.LS_fromData, this.LS_info});

  StockMoveFrom_Data.fromJson(Map<String, dynamic> json) {
    if (json['cell_info'] != null) {
      LS_fromData = new List<FromData>();
      json['cell_info'].forEach((v) {
        LS_fromData.add(new FromData.fromJson(v));
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
    if (this.LS_fromData != null) {
      data['cell_info'] = this.LS_fromData.map((v) => v.toJson()).toList();
    }
    if (this.LS_info != null) {
      data['info'] = this.LS_info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FromData{
  String pCELL_NO;
  String pITEM_CD;
  String pLOT_NO;
  String pCELL_SEQ;
  String pITEM_QTY;

  FromData({this.pCELL_NO, this.pITEM_CD, this.pLOT_NO, this.pCELL_SEQ, this.pITEM_QTY});

  FromData.fromJson(Map<String, dynamic> json) {
    pCELL_NO = json['CELL_NO'];
    pITEM_CD = json['ITEM_CD'];
    pLOT_NO = json['LOT_NO'];
    pCELL_SEQ = json['CELL_SEQ'];
    pITEM_QTY = json['ITEM_QTY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CELL_NO'] = this.pCELL_NO;
    data['ITEM_CD'] = this.pITEM_CD;
    data['LOT_NO'] = this.pLOT_NO;
    data['CELL_SEQ'] = this.pCELL_SEQ;
    data['ITEM_QTY'] = this.pITEM_QTY;
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