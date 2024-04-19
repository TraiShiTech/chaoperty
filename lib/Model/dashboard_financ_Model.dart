class DashboardfinancModel {
  String? rser;
  String? dtype;
  String? payBy;
  String? type;
  String? bank;
  String? bno;
  String? total;
  String? ptname;
  String? bills;

  DashboardfinancModel(
      {this.rser,
      this.dtype,
      this.payBy,
      this.type,
      this.bank,
      this.bno,
      this.total,
      this.ptname,
      this.bills});

  DashboardfinancModel.fromJson(Map<String, dynamic> json) {
    rser = json['rser'];
    dtype = json['dtype'];
    payBy = json['pay_by'];
    type = json['type'];
    bank = json['bank'];
    bno = json['bno'];
    total = json['total'];
     ptname = json['ptname'];
    bills = json['bills'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rser'] = this.rser;
    data['dtype'] = this.dtype;
    data['pay_by'] = this.payBy;
    data['type'] = this.type;
    data['bank'] = this.bank;
    data['bno'] = this.bno;
    data['total'] = this.total;
      data['ptname'] = this.ptname;
    data['bills'] = this.bills;
    return data;
  }
}
