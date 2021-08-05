class SignUp_Data {
  List<SignUpInfo> LS_signUpInfo;
  List<Info> LS_info;

  SignUp_Data({this.LS_info});

  SignUp_Data.fromJson(Map<String, dynamic> json){
    if (json['user_info'] != null) {
      LS_signUpInfo = new List<SignUpInfo>();
      json['user_info'].forEach((v) {
        LS_signUpInfo.add(new SignUpInfo.fromJson(v));
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
    if (this.LS_signUpInfo != null) {
      data['user_info'] = this.LS_signUpInfo.map((v) => v.toJson()).toList();
    }
    if (this.LS_info != null) {
      data['info'] = this.LS_info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SignUpInfo{
  String pUSER_ID;
  String pUSER_GRP;
  String pUSER_NM;

  SignUpInfo({this.pUSER_ID, this.pUSER_GRP, this.pUSER_NM});

  SignUpInfo.fromJson(Map<String, dynamic> json) {
    pUSER_ID = json['USER_ID'];
    pUSER_GRP = json['USER_GRP'];
    pUSER_NM = json['USER_NM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['USER_ID'] = this.pUSER_ID;
    data['USER_GRP'] = this.pUSER_GRP;
    data['USER_NM'] = this.pUSER_NM;
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