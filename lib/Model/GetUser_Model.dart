class UserModel {
  String? ser;
  String? fname;
  String? lname;
  String? tel;
  String? email;
  String? passwd;
  String? position;
  String? st;
  String? user_id;
  String? permission;
  String? user;
  String? rser;
  String? utype;
  String? verify;
  String? otp;
  String? modeclor;
  String? data_update;
  String? connected;
  String? onoff;
  String? showst_update;
  String? system_datex;

  UserModel(
      {this.ser,
      this.fname,
      this.lname,
      this.tel,
      this.email,
      this.passwd,
      this.position,
      this.st,
      this.user_id,
      this.permission,
      this.user,
      this.rser,
      this.utype,
      this.verify,
      this.otp,
      this.modeclor,
      this.connected,
      this.data_update,
      this.showst_update,
      this.system_datex,
      this.onoff});

  UserModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    fname = json['fname'];
    lname = json['lname'];
    tel = json['tel'];
    email = json['email'];
    passwd = json['passwd'];
    position = json['position'];
    st = json['st'];
    user_id = json['user_id'];
    permission = json['permission'];
    user = json['user'];
    rser = json['rser'];
    utype = json['utype'];
    verify = json['verify'];
    otp = json['otp'];
    modeclor = json['modeclor'];
    connected = json['connected'];
    data_update = json['data_update'];
    onoff = json['onoff'];
    showst_update = json['showst_update'];
    system_datex = json['system_datex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['passwd'] = this.passwd;
    data['position'] = this.position;
    data['st'] = this.st;
    data['user_id'] = this.user_id;
    data['permission'] = this.permission;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['utype'] = this.utype;
    data['verify'] = this.verify;
    data['otp'] = this.otp;
    data['modeclor'] = this.modeclor;
    data['data_update'] = this.data_update;
    data['connected'] = this.connected;
    data['onoff'] = this.onoff;
    data['showst_update'] = this.showst_update;
    data['system_datex'] = this.system_datex;
    return data;
  }
}
