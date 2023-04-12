class TeNantContractModel {
  String? ser;
  String? user;
  String? datex;
  String? timex;
  String? tno;
  String? taxno;
  String? sname;
  String? stype;
  String? tser;
  String? ttype;
  String? tname;
  String? attn;
  String? addr1;
  String? addr2;
  String? zip;
  String? tel;
  String? tax;
  String? email;
  String? st;
  String? data_update;

  TeNantContractModel(
      {this.ser,
      this.user,
      this.datex,
      this.timex,
      this.tno,
      this.taxno,
      this.sname,
      this.stype,
      this.tser,
      this.ttype,
      this.tname,
      this.attn,
      this.addr1,
      this.addr2,
      this.zip,
      this.tel,
      this.tax,
      this.email,
      this.st,
      this.data_update});

  TeNantContractModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    user = json['user'];
    datex = json['datex'];
    timex = json['timex'];
    tno = json['tno'];
    taxno = json['taxno'];
    sname = json['sname'];
    stype = json['stype'];
    tser = json['tser'];
    ttype = json['ttype'];
    tname = json['tname'];
    attn = json['attn'];
    addr1 = json['addr_1'];
    addr2 = json['addr_2'];
    zip = json['zip'];
    tel = json['tel'];
    tax = json['tax'];
    email = json['email'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['user'] = this.user;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['tno'] = this.tno;
    data['taxno'] = this.taxno;
    data['sname'] = this.sname;
    data['stype'] = this.stype;
    data['tser'] = this.tser;
    data['ttype'] = this.ttype;
    data['tname'] = this.tname;
    data['attn'] = this.attn;
    data['addr_1'] = this.addr1;
    data['addr_2'] = this.addr2;
    data['zip'] = this.zip;
    data['tel'] = this.tel;
    data['tax'] = this.tax;
    data['email'] = this.email;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
