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
  String? title_web;
  String? pn_TH;
  String? range_lowpri;
  String? range_heipri;
  String? dialog;
  String? dialog_tex;
  String? rt_view;
  String? r_tel;
  String? par_king;
  String? a_aboutAll;

  RenTaldataModel({
    this.ser,
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
    this.status_Web,
    this.title_web,
    this.pn_TH,
    this.range_lowpri,
    this.range_heipri,
    this.dialog,
    this.dialog_tex,
    this.rt_view,
    this.r_tel,
    this.par_king,
    this.a_aboutAll,
  });

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
    title_web = json['title_web'];
    pn_TH = json['pn_TH'];
    range_lowpri = json['range_lowpri'];
    range_heipri = json['range_heipri'];
    dialog = json['dialog'];
    dialog_tex = json['dialog_tex'];
    rt_view = json['rt_view'];
    r_tel = json['r_tel'];
    par_king = json['par_king'];
    a_aboutAll = json['a_aboutAll'];
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
    data['title_web'] = this.title_web;
    data['pn_TH'] = this.pn_TH;
    data['range_lowpri'] = this.range_lowpri;
    data['range_heipri'] = this.range_heipri;
    data['dialog'] = this.dialog;
    data['dialog_tex'] = this.dialog_tex;
    data['rt_view'] = this.rt_view;
    data['r_tel'] = this.r_tel;
    data['par_king'] = this.par_king;
    data['a_aboutAll'] = this.a_aboutAll;
    return data;
  }
}
