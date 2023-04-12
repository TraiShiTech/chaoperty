class UnitModel {
  String? ser;
  String? unit;
  String? st;
  String? day;
  String? data_update;

  UnitModel({this.ser, this.unit, this.st, this.day, this.data_update});

  UnitModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    unit = json['unit'];
    st = json['st'];
    day = json['day'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['unit'] = this.unit;
    data['st'] = this.st;
    data['day'] = this.day;
    data['data_update'] = this.data_update;
    return data;
  }
}
