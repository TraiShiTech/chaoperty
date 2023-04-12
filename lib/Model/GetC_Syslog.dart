class SyslogModel {
  String? ser;
  String? atype;
  String? datex;
  String? timex;
  String? ip;
  String? uid;
  String? username;
  String? frm;
  String? fdo;

  SyslogModel(
      {this.ser,
      this.atype,
      this.datex,
      this.timex,
      this.ip,
      this.uid,
      this.username,
      this.frm,
      this.fdo});

  SyslogModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    atype = json['atype'];
    datex = json['datex'];
    timex = json['timex'];
    ip = json['ip'];
    uid = json['uid'];
    username = json['username'];
    frm = json['frm'];
    fdo = json['fdo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['atype'] = this.atype;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['ip'] = this.ip;
    data['uid'] = this.uid;
    data['username'] = this.username;
    data['frm'] = this.frm;
    data['fdo'] = this.fdo;
    return data;
  }
}
