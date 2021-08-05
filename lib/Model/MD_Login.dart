class Login_Data {
  List<Info> LS_info;

  Login_Data({this.LS_info});

  Login_Data.fromJson(Map<String, dynamic> json) {
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
  String userNm;
  String userGrp;

  Info(
      {this.vSqlMsg,
        this.nSqlCd,
        this.nPdaCd,
        this.vPdaMsg,
        this.userNm,
        this.userGrp});

  Info.fromJson(Map<String, dynamic> json) {
    vSqlMsg = json['vSqlMsg'];
    nSqlCd = json['nSqlCd'];
    nPdaCd = json['nPdaCd'];
    vPdaMsg = json['vPdaMsg'];
    userNm = json['USER_NM'];
    userGrp = json['USER_GRP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vSqlMsg'] = this.vSqlMsg;
    data['nSqlCd'] = this.nSqlCd;
    data['nPdaCd'] = this.nPdaCd;
    data['vPdaMsg'] = this.vPdaMsg;
    data['USER_NM'] = this.userNm;
    data['USER_GRP'] = this.userGrp;

    return data;
  }
}