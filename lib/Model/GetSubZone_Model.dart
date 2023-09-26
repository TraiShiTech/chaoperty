class SubZoneModel {
  String? ser;
  String? rser;
  String? zn;
  String? qty;
  String? img;
  String? data_update;
  String? img_floorplan;
  String? pri;
  String? jon;
  String? ren_pri;
  String? b_1;
  String? b_2;
  String? b_3;
  String? b_4;
  String? number_zn;
  String? jon_book;
  String? sub_zone;

  SubZoneModel({
    this.ser,
    this.rser,
    this.zn,
    this.qty,
    this.img,
    this.data_update,
    this.img_floorplan,
    this.pri,
    this.jon,
    this.ren_pri,
    this.b_1,
    this.b_2,
    this.b_3,
    this.b_4,
    this.number_zn,
    this.jon_book,
    this.sub_zone,
  });

  SubZoneModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    rser = json['rser'];
    zn = json['zn'];
    qty = json['qty'];
    img = json['img'];
    data_update = json['data_update'];
    img_floorplan = json['img_floorplan'];
    pri = json['pri'];
    jon = json['jon'];
    ren_pri = json['ren_pri'];
    b_1 = json['b_1'];
    b_2 = json['b_2'];
    b_3 = json['b_3'];
    b_4 = json['b_4'];
    number_zn = json['number_zn'];
    jon_book = json['jon_book'];
    sub_zone = json['sub_zone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['rser'] = this.rser;
    data['zn'] = this.zn;
    data['qty'] = this.qty;
    data['img'] = this.img;
    data['data_update'] = this.data_update;
    data['img_floorplan'] = this.img_floorplan;
    data['pri'] = this.pri;
    data['jon'] = this.jon;
    data['ren_pri'] = this.ren_pri;
    data['b_1'] = this.b_1;
    data['b_2'] = this.b_2;
    data['b_3'] = this.b_3;
    data['b_4'] = this.b_4;
    data['number_zn'] = this.number_zn;
    data['jon_book'] = this.jon_book;
    data['sub_zone'] = this.sub_zone;
    return data;
  }
}
