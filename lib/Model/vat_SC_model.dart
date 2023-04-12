class VatSeModel {
  String? ser;
  String? vat;
  String? pct;
  String? st;
  String? vtypex;
  String? data_update;

  VatSeModel(
      {this.ser, this.vat, this.pct, this.st, this.vtypex, this.data_update});

  VatSeModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    vat = json['vat'];
    pct = json['pct'];
    st = json['st'];
    vtypex = json['vtypex'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['vat'] = this.vat;
    data['pct'] = this.pct;
    data['st'] = this.st;
    data['vtypex'] = this.vtypex;
    data['data_update'] = this.data_update;
    return data;
  }
}
