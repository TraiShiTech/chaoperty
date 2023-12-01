class PackageUserModel {
  String? ser;
  String? pk;
  String? qty;
  String? rpri;
  String? spri;
  String? user;
  String? st;
  String? dateUpdate;

  PackageUserModel(
      {this.ser,
      this.pk,
      this.qty,
      this.rpri,
      this.spri,
      this.user,
      this.st,
      this.dateUpdate});

  PackageUserModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    pk = json['pk'];
    qty = json['qty'];
    rpri = json['rpri'];
    spri = json['spri'];
    user = json['user'];
    st = json['st'];
    dateUpdate = json['date_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['pk'] = this.pk;
    data['qty'] = this.qty;
    data['rpri'] = this.rpri;
    data['spri'] = this.spri;
    data['user'] = this.user;
    data['st'] = this.st;
    data['date_update'] = this.dateUpdate;
    return data;
  }
}
