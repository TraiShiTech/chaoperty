class TransPlayxModel {
  String? ser_trans;
  String? date_trans;
  String? docno_trans;
  String? refno_trans;
  String? name_trans;
  String? expname_trans;
  String? vat_trans;
  String? pvat_trans;
  String? wht_trans;
  String? nwht_trans;
  String? total_trans;
  String? amt_trans;
  String? expx_row;

  TransPlayxModel({
    this.ser_trans,
    this.date_trans,
    this.docno_trans,
    this.refno_trans,
    this.name_trans,
    this.expname_trans,
    this.vat_trans,
    this.pvat_trans,
    this.wht_trans,
    this.nwht_trans,
    this.total_trans,
    this.amt_trans,
    this.expx_row,
  });

  TransPlayxModel.fromJson(Map<String, dynamic> json) {
    ser_trans = json['ser_trans'];
    date_trans = json['date_trans'];
    docno_trans = json['docno_trans'];
    refno_trans = json['refno_trans'];
    name_trans = json['name_trans'];
    expname_trans = json['expname_trans'];
    vat_trans = json['vat_trans'];
    pvat_trans = json['pvat_trans'];
    wht_trans = json['wht_trans'];
    nwht_trans = json['nwht_trans'];
    total_trans = json['total_trans'];
    amt_trans = json['amt_trans'];
    expx_row = json['expx_row'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser_trans'] = this.ser_trans;
    data['date_trans'] = this.date_trans;
    data['docno_trans'] = this.docno_trans;
    data['refno_trans'] = this.refno_trans;
    data['name_trans'] = this.name_trans;
    data['expname_trans'] = this.expname_trans;
    data['vat_trans'] = this.vat_trans;
    data['pvat_trans'] = this.pvat_trans;
    data['wht_trans'] = this.wht_trans;
    data['nwht_trans:'] = this.nwht_trans;
    data['total_trans'] = this.total_trans;
    data['amt_trans'] = this.amt_trans;
    data['expx_row'] = this.expx_row;
    return data;
  }
}
