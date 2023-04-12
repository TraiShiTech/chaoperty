class SubUserModel {
  String? ser;
  String? user;
  String? fname;
  String? lname;
  String? tel;
  String? email;
  String? passwd;
  String? position;
  String? permission;
  String? st;
  String? rser;
  String? subuserId;
  String? data_update;

  SubUserModel(
      {this.ser,
      this.user,
      this.fname,
      this.lname,
      this.tel,
      this.email,
      this.passwd,
      this.position,
      this.permission,
      this.st,
      this.rser,
      this.subuserId,
      this.data_update});

  SubUserModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    user = json['user'];
    fname = json['fname'];
    lname = json['lname'];
    tel = json['tel'];
    email = json['email'];
    passwd = json['passwd'];
    position = json['position'];
    permission = json['permission'];
    st = json['st'];
    rser = json['rser'];
    subuserId = json['subuser_id'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['user'] = this.user;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['tel'] = this.tel;
    data['email'] = this.email;
    data['passwd'] = this.passwd;
    data['position'] = this.position;
    data['permission'] = this.permission;
    data['st'] = this.st;
    data['rser'] = this.rser;
    data['subuser_id'] = this.subuserId;
    data['data_update'] = this.data_update;
    return data;
  }
}
