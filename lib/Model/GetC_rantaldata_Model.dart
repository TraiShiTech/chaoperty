class RenTaldataModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? tser;
  String? rtser;
  String? pn;
  String? dbn;
  String? dataUpdate;
  String? province;
  String? lat;
  String? longi;
  String? customerID;
  String? purchaseDate;
  String? url_You;
  String? url_Map;
  String? r_Line;
  String? r_Facebook;
  String? stime;
  String? ltime;
  String? n_Places;
  String? f_Lities;
  String? a_About;
  String? man_Image;
  String? qr_Image;
  String? status_Web;

  RenTaldataModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.tser,
      this.rtser,
      this.pn,
      this.dbn,
      this.dataUpdate,
      this.province,
      this.lat,
      this.longi,
      this.customerID,
      this.purchaseDate,
      this.url_You,
      this.url_Map,
      this.r_Line,
      this.r_Facebook,
      this.stime,
      this.ltime,
      this.n_Places,
      this.f_Lities,
      this.a_About,
      this.man_Image,
      this.qr_Image,
      this.status_Web});

  RenTaldataModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    tser = json['tser'];
    rtser = json['rtser'];
    pn = json['pn'];
    dbn = json['dbn'];
    dataUpdate = json['data_update'];
    province = json['province'];
    lat = json['lat'];
    longi = json['longi'];
    customerID = json['Customer_ID'];
    purchaseDate = json['Purchase_date'];
    url_You = json['url_you'];
    url_Map = json['url_map'];
    r_Line = json['r_line'];
    r_Facebook = json['r_facebook'];
    stime = json['stime'];
    ltime = json['ltime'];
    n_Places = json['n_places'];
    f_Lities = json['f_lities'];
    a_About = json['a_about'];
    man_Image = json['man_image'];
    qr_Image = json['qr_image'];
    status_Web = json['status_web'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['tser'] = this.tser;
    data['rtser'] = this.rtser;
    data['pn'] = this.pn;
    data['dbn'] = this.dbn;
    data['data_update'] = this.dataUpdate;
    data['province'] = this.province;
    data['lat'] = this.lat;
    data['longi'] = this.longi;
    data['Customer_ID'] = this.customerID;
    data['Purchase_date'] = this.purchaseDate;
    data['url_you'] = this.url_You;
    data['url_map'] = this.url_Map;
    data['r_line'] = this.r_Line;
    data['r_facebook'] = this.r_Facebook;
    data['stime'] = this.stime;
    data['ltime'] = this.ltime;
    data['n_places'] = this.n_Places;
    data['f_lities'] = this.f_Lities;
    data['a_about'] = this.a_About;
    data['man_image'] = this.man_Image;
    data['qr_image'] = this.qr_Image;
    data['status_web'] = this.status_Web;
    return data;
  }
}
