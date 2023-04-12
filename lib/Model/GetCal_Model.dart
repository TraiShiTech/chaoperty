class CalModel {
  String? ser;
  String? cal;
  String? st;
  String? data_update;

  CalModel({this.ser, this.cal, this.st, this.data_update});

  CalModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    cal = json['cal'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['cal'] = this.cal;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
