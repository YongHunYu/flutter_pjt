class UiInfo_Data{
  List<UiInfo> LS_uiInfo;
  List<Info> LS_info;

  UiInfo_Data({this.LS_uiInfo, this.LS_info});

  UiInfo_Data.fromJson(Map<String, dynamic> json){
    if (json['ui_info'] != null) {
      LS_uiInfo = new List<UiInfo>();
      json['ui_info'].forEach((v) {
        LS_uiInfo.add(new UiInfo.fromJson(v));
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
    if (this.LS_uiInfo != null) {
      data['ui_info'] = this.LS_uiInfo.map((v) => v.toJson()).toList();
    }
    if (this.LS_info != null) {
      data['info'] = this.LS_info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UiInfo{
  String pCCD_CD;
  String pCCD_NM;

  UiInfo({this.pCCD_CD, this.pCCD_NM});

  UiInfo.fromJson(Map<String, dynamic> json){
    pCCD_CD = json['CCD_CD'];
    pCCD_NM = json['CCD_NM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CCD_CD'] = this.pCCD_CD;
    data['CCD_NM'] = this.pCCD_NM;
    return data;
  }
}

class Info{
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