class AreaIMGModel {
  String? ser;
  String? rser;
  String? zser;
  String? lncode;
  String? ln;
  String? area;
  String? rent;
  String? st;
  String? img;
  String? data_update;
  String? ldate;
  String? quantity;

  AreaIMGModel(
      {this.ser,
      this.rser,
      this.zser,
      this.lncode,
      this.ln,
      this.area,
      this.rent,
      this.st,
      this.img,
      this.data_update,
      this.ldate,
      this.quantity});

  AreaIMGModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    rser = json['rser'];
    zser = json['zser'];
    lncode = json['lncode'];
    ln = json['ln'];
    area = json['area'];
    rent = json['rent'];
    st = json['st'];
    img = json['img'];
    data_update = json['data_update'];
    ldate = json['ldate'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['rser'] = this.rser;
    data['zser'] = this.zser;
    data['lncode'] = this.lncode;
    data['ln'] = this.ln;
    data['area'] = this.area;
    data['rent'] = this.rent;
    data['st'] = this.st;
    data['img'] = this.img;
    data['data_update'] = this.data_update;
    data['ldate'] = this.ldate;
    data['quantity'] = this.quantity;
    return data;
  }
}
