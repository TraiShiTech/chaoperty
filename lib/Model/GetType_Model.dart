class TypeModel {
  String? ser;
  String? type;
  String? st;
  String? data_update;

  TypeModel({this.ser, this.type, this.st, this.data_update});

  TypeModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    type = json['type'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['type'] = this.type;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
