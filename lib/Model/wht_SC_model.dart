class WhtSeModel {
  String? ser;
  String? wht;
  String? pct;
  String? st;
  String? data_update;

  WhtSeModel({this.ser, this.wht, this.pct, this.st, this.data_update});

  WhtSeModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    wht = json['wht'];
    pct = json['pct'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['wht'] = this.wht;
    data['pct'] = this.pct;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
