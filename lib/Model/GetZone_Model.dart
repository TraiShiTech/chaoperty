class ZoneModel {
  String? ser;
  String? rser;
  String? zn;
  String? qty;
  String? img;
  String? data_update;

  ZoneModel(
      {this.ser, this.rser, this.zn, this.qty, this.img, this.data_update});

  ZoneModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    rser = json['rser'];
    zn = json['zn'];
    qty = json['qty'];
    img = json['img'];
    data_update = json['data_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['rser'] = this.rser;
    data['zn'] = this.zn;
    data['qty'] = this.qty;
    data['img'] = this.img;
    data['data_update'] = this.data_update;
    return data;
  }
}
