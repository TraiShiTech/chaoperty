class RentalTypeModel {
  String? ser;
  String? rtname;
  String? st;
  String? data_update;

  RentalTypeModel({this.ser, this.rtname, this.st, this.data_update});

  RentalTypeModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    rtname = json['rtname'];
    st = json['st'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['rtname'] = this.rtname;
    data['st'] = this.st;
    data['data_update'] = this.data_update;
    return data;
  }
}
