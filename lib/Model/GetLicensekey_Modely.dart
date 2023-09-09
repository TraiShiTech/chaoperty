class LicensekeyModel {
  String? ser;
  String? datex;
  String? timex;
  String? key;
  String? spack;
  String? use;
  String? pk;
  String? qty;
  String? rpri;
  String? spri;
  String? user;

  LicensekeyModel(
      {this.ser,
      this.datex,
      this.timex,
      this.key,
      this.spack,
      this.use,
      this.pk,
      this.qty,
      this.rpri,
      this.spri,
      this.user});

  LicensekeyModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    key = json['key'];
    spack = json['spack'];
    use = json['use'];
    pk = json['pk'];
    qty = json['qty'];
    rpri = json['rpri'];
    spri = json['spri'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['key'] = this.key;
    data['spack'] = this.spack;
    data['use'] = this.use;
    data['pk'] = this.pk;
    data['qty'] = this.qty;
    data['rpri'] = this.rpri;
    data['spri'] = this.spri;
    data['user'] = this.user;
    return data;
  }
}
