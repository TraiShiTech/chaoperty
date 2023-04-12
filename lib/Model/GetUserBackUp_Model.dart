class UserBackUpModel {
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
  String? data_update;

  UserBackUpModel(
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
      this.data_update});

  UserBackUpModel.fromJson(Map<String, dynamic> json) {
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
    data_update = json['data_update'];
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
    data['data_update'] = this.data_update;
    return data;
  }
}
