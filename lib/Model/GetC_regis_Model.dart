class c_regis_Model {
  String? ser;
  String? rser;
  String? pn;
  String? custno;
  String? cid;
  String? username;
  String? passwd;
  String? accessToken;
  String? idToken;
  String? userid;
  String? displayname;
  String? dataUpdate;

  c_regis_Model(
      {this.ser,
      this.rser,
      this.pn,
      this.custno,
      this.cid,
      this.username,
      this.passwd,
      this.accessToken,
      this.idToken,
      this.userid,
      this.displayname,
      this.dataUpdate});

  c_regis_Model.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    rser = json['rser'];
    pn = json['pn'];
    custno = json['custno'];
    cid = json['cid'];
    username = json['username'];
    passwd = json['passwd'];
    accessToken = json['access_token'];
    idToken = json['id_token'];
    userid = json['userid'];
    displayname = json['displayname'];
    dataUpdate = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['rser'] = this.rser;
    data['pn'] = this.pn;
    data['custno'] = this.custno;
    data['cid'] = this.cid;
    data['username'] = this.username;
    data['passwd'] = this.passwd;
    data['access_token'] = this.accessToken;
    data['id_token'] = this.idToken;
    data['userid'] = this.userid;
    data['displayname'] = this.displayname;
    data['data_update'] = this.dataUpdate;
    return data;
  }
}
