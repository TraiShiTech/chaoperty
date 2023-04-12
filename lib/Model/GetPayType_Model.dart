class PayTypeModel {
  String? ser;
  String? ptname;
  String? co;
  String? st;
  String? data_update;

  PayTypeModel({this.ser, this.ptname, this.co, this.st, this.data_update});

  PayTypeModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    ptname = json['ptname'];
    co = json['co'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['ptname'] = this.ptname;
    data['co'] = this.co;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
