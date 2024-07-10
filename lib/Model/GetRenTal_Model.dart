class RenTalModel {
  String? ser;
  String? user;
  String? txser;
  String? tser;
  String? rtser;
  String? pn;
  String? img;
  String? bill_name;
  String? bill_addr;
  String? bill_tax;
  String? bill_tel;
  String? bill_email;
  String? tother;
  String? period;
  String? dbh;
  String? dbu;
  String? dbp;
  String? dbn;
  String? dbno;
  String? datex;
  String? rtname;
  String? type;
  String? typex;
  String? pk;
  String? pkqty;
  String? pkuser;
  String? bill_default;
  String? data_update;
  String? imglogo;
  String? province;
  String? pksdate;
  String? pkldate;
  String? acc2;
  String? his;
  String? tem_page;
  String? html;
  String? Floor_plans;
  String? printbill_default;
  String? receipt_title;
  String? pn_TH;
  String? open_set;
  String? open_disinv;
  String? open_set_date;
  String? mass_on;
  String? imglineqr;
  String? colors_ren;
  String? colors_subren;
  String? colors_light;
  String? colors_dark;
  String? open_print;
  String? lan_guage;

  RenTalModel({
    this.ser,
    this.user,
    this.txser,
    this.tser,
    this.rtser,
    this.pn,
    this.img,
    this.bill_name,
    this.bill_addr,
    this.bill_tax,
    this.bill_tel,
    this.bill_email,
    this.tother,
    this.period,
    this.dbh,
    this.dbu,
    this.dbp,
    this.dbn,
    this.dbno,
    this.datex,
    this.rtname,
    this.type,
    this.typex,
    this.pk,
    this.pkqty,
    this.pkuser,
    this.bill_default,
    this.data_update,
    this.province,
    this.imglogo,
    this.pksdate,
    this.acc2,
    this.pkldate,
    this.his,
    this.tem_page,
    this.html,
    this.Floor_plans,
    this.printbill_default,
    this.receipt_title,
    this.pn_TH,
    this.open_set,
    this.open_disinv,
    this.open_set_date,
    this.mass_on,
    this.imglineqr,
    this.colors_ren,
    this.colors_subren,
    this.colors_light,
    this.colors_dark,
    this.open_print,
    this.lan_guage,
  });

  RenTalModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    user = json['user'];
    txser = json['txser'];
    tser = json['tser'];
    rtser = json['rtser'];
    pn = json['pn'];
    img = json['img'];
    bill_name = json['bill_name'];
    bill_addr = json['bill_addr'];
    bill_tax = json['bill_tax'];
    bill_tel = json['bill_tel'];
    bill_email = json['bill_email'];
    tother = json['tother'];
    period = json['period'];
    dbh = json['dbh'];
    dbu = json['dbu'];
    dbp = json['dbp'];
    dbn = json['dbn'];
    dbno = json['dbno'];
    datex = json['datex'];
    rtname = json['rtname'];
    type = json['type'];
    typex = json['typex'];
    pk = json['pk'];
    pkqty = json['pkqty'];
    pkuser = json['pkuser'];
    bill_default = json['bill_default'];
    data_update = json['data_update'];
    imglogo = json['imglogo'];
    province = json['province'];
    pksdate = json['pksdate'];
    pkldate = json['pkldate'];
    acc2 = json['acc2'];
    his = json['his'];
    tem_page = json['tem_page'];
    html = json['html'];
    Floor_plans = json['Floor_plans'];
    printbill_default = json['printbill_default'];
    receipt_title = json['receipt_title'];
    pn_TH = json['pn_TH'];
    open_set = json['open_set'];
    open_disinv = json['open_disinv'];
    open_set_date = json['open_set_date'];
    mass_on = json['mass_on'];
    imglineqr = json['imglineqr'];
    colors_ren = json['colors_ren'];
    colors_subren = json['colors_subren'];
    colors_light = json['colors_light'];
    colors_dark = json['colors_dark'];
    open_print = json['open_print'];
    lan_guage = json['lan_guage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['user'] = this.user;
    data['txser'] = this.txser;
    data['tser'] = this.tser;
    data['rtser'] = this.rtser;
    data['pn'] = this.pn;
    data['img'] = this.img;
    data['bill_name'] = this.bill_name;
    data['bill_addr'] = this.bill_addr;
    data['bill_tax'] = this.bill_tax;
    data['bill_tel'] = this.bill_tel;
    data['bill_email'] = this.bill_email;
    data['tother'] = this.tother;
    data['period'] = this.period;
    data['dbh'] = this.dbh;
    data['dbu'] = this.dbu;
    data['dbp'] = this.dbp;
    data['dbn'] = this.dbn;
    data['dbno'] = this.dbno;
    data['datex'] = this.datex;
    data['rtname'] = this.rtname;
    data['type'] = this.type;
    data['typex'] = this.typex;
    data['pk'] = this.pk;
    data['pkqty'] = this.pkqty;
    data['pkuser'] = this.pkuser;
    data['bill_default'] = this.bill_default;
    data['data_update'] = this.data_update;
    data['imglogo'] = this.imglogo;
    data['province'] = this.province;
    data['pksdate'] = this.pksdate;
    data['pkldate'] = this.pkldate;
    data['acc2'] = this.acc2;
    data['his'] = this.his;
    data['tem_page'] = this.tem_page;
    data['html'] = this.html;
    data['Floor_plans'] = this.Floor_plans;
    data['printbill_default'] = this.printbill_default;
    data['receipt_title'] = this.receipt_title;
    data['pn_TH'] = this.pn_TH;
    data['open_set'] = this.open_set;
    data['open_disinv'] = this.open_disinv;
    data['open_set_date'] = this.open_set_date;
    data['mass_on'] = this.mass_on;
    data['imglineqr'] = this.imglineqr;
    data['colors_ren'] = this.colors_ren;
    data['colors_subren'] = this.colors_subren;

    data['colors_light'] = this.colors_light;
    data['colors_dark'] = this.colors_dark;
    data['colors_dark'] = this.open_print;
    data['lan_guage'] = this.lan_guage;

    return data;
  }
}
