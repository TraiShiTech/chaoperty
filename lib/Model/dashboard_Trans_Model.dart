class DashboardTransModel {
  String? rser;
  String? dtype;
  String? expname;
  String? pvat;
  String? vat;
  String? wht;
  String? total;

  DashboardTransModel(
      {this.rser,
      this.dtype,
      this.expname,
      this.pvat,
      this.vat,
      this.wht,
      this.total});

  DashboardTransModel.fromJson(Map<String, dynamic> json) {
    rser = json['rser'];
    dtype = json['dtype'];
    expname = json['expname'];
    pvat = json['pvat'];
    vat = json['vat'];
    wht = json['wht'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rser'] = this.rser;
    data['dtype'] = this.dtype;
    data['expname'] = this.expname;
    data['pvat'] = this.pvat;
    data['vat'] = this.vat;
    data['wht'] = this.wht;
    data['total'] = this.total;
    return data;
  }
}
