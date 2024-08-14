class TeNantChoiceModel {
  String? ser;
  String? user;
  String? name_user;
  String? datex;
  String? daterec;
  String? pdate;
  String? st;
  String? cid;
  String? fid;
  String? zser;
  String? zser1;
  String? zn;
  String? znn;
  String? zn1;
  String? ln;
  String? cname;
  String? tax;
  String? sdate;
  String? ldate;
  String? period;
  String? nday;
  String? stype;
  String? cc_date;
  String? cc_remark;
  String? docno;
  String? doctax;
  String? water_electri;
  String? count_pakan;
  String? amt_pakan;
  String? pvat_pakan;

  String? pakan_vat;
  String? total_pakan;
  String? pakan_doc;
  String? pakan_daterec;

  String? date;
  String? rent_amt;
  String? rent_pvat;
  String? rent_vat;
  String? rent_total;

  String? service_amt;
  String? service_pvat;
  String? service_vat;
  String? service_total;

  String? equip_amt;
  String? equip_pvat;
  String? equip_vat;
  String? equip_total;

  String? water;
  String? electricity;
  String? remark;

  String? service_total_future;
  String? rent_total_future;
  String? total_bill;
  String? renew_cid;

  TeNantChoiceModel(
      {this.ser,
      this.user,
      this.name_user,
      this.datex,
      this.daterec,
      this.pdate,
      this.st,
      this.cid,
      this.fid,
      this.zser,
      this.zser1,
      this.zn,
      this.znn,
      this.zn1,
      this.ln,
      this.cname,
      this.tax,
      this.sdate,
      this.ldate,
      this.period,
      this.nday,
      this.stype,
      this.cc_date,
      this.cc_remark,
      this.docno,
      this.doctax,
      this.water_electri,
      this.count_pakan,
      this.amt_pakan,
      this.pvat_pakan,
      this.pakan_vat,
      this.total_pakan,
      this.pakan_doc,
      this.pakan_daterec,
      this.date,
      this.rent_amt,
      this.rent_pvat,
      this.rent_vat,
      this.rent_total,
      this.service_amt,
      this.service_pvat,
      this.service_vat,
      this.service_total,
      this.equip_amt,
      this.equip_pvat,
      this.equip_vat,
      this.equip_total,
      this.water,
      this.electricity,
      this.remark,
      this.service_total_future,
      this.rent_total_future,
      this.total_bill,
      this.renew_cid});

  TeNantChoiceModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    user = json['user'];
    name_user = json['name_user'];
    datex = json['datex'];
    daterec = json['daterec'];
    pdate = json['pdate'];
    st = json['st'];
    cid = json['cid'];
    fid = json['fid'];
    zser = json['zser'];
    zser1 = json['zser1'];
    zn = json['zn'];
    znn = json['znn'];
    zn1 = json['zn1'];
    ln = json['ln'];
    cname = json['cname'];
    tax = json['tax'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    period = json['period'];
    nday = json['nday'];
    stype = json['stype'];
    cc_date = json['cc_date'];
    cc_remark = json['cc_remark'];
    docno = json['docno'];
    doctax = json['doctax'];
    water_electri = json['water_electri'];
    count_pakan = json['count_pakan'];
    amt_pakan = json['amt_pakan'];
    pvat_pakan = json['pvat_pakan'];
    pakan_vat = json['pakan_vat'];
    total_pakan = json['total_pakan'];
    pakan_doc = json['pakan_doc'];
    pakan_daterec = json['pakan_daterec'];

    date = json['date'];
    rent_amt = json['rent_amt'];
    rent_pvat = json['rent_pvat'];
    rent_vat = json['rent_vat'];
    rent_total = json['rent_total'];
    service_amt = json['service_amt'];
    service_pvat = json['service_pvat'];
    service_vat = json['service_vat'];
    service_total = json['service_total'];

    equip_amt = json['equip_amt'];
    equip_pvat = json['equip_pvat'];
    equip_vat = json['equip_vat'];
    equip_total = json['equip_total'];

    water = json['water'];
    electricity = json['electricity'];
    remark = json['remark'];
    service_total_future = json['service_total_future'];
    rent_total_future = json['rent_total_future'];
    total_bill = json['total_bill'];
    renew_cid = json['renew_cid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['user'] = this.user;
    data['name_user'] = this.name_user;
    data['datex'] = this.datex;
    data['daterec'] = this.daterec;
    data['pdate'] = this.pdate;
    data['st'] = this.st;
    data['cid'] = this.cid;
    data['fid'] = this.fid;
    data['zser'] = this.zser;
    data['zser1'] = this.zser1;
    data['zn'] = this.zn;
    data['znn'] = this.znn;
    data['zn1'] = this.zn1;
    data['ln'] = this.ln;
    data['cname'] = this.cname;
    data['tax'] = this.tax;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['period'] = this.period;
    data['nday'] = this.nday;
    data['stype'] = this.stype;
    data['cc_date'] = this.cc_date;
    data['cc_remark'] = this.cc_remark;
    data['docno'] = this.docno;
    data['doctax'] = this.doctax;
    data['water_electri'] = this.water_electri;
    data['count_pakan'] = this.count_pakan;
    data['amt_pakan'] = this.amt_pakan;
    data['pvat_pakan'] = this.pvat_pakan;
    data['pakan_vat'] = this.pakan_vat;
    data['total_pakan'] = this.total_pakan;
    data['pakan_doc'] = this.pakan_doc;
    data['pakan_daterec'] = this.pakan_daterec;

    data['date'] = this.date;
    data['rent_amt'] = this.rent_amt;
    data['rent_pvat'] = this.rent_pvat;
    data['rent_vat'] = this.rent_vat;
    data['rent_total'] = this.rent_total;
    data['service_amt'] = this.service_amt;
    data['service_pvat'] = this.service_pvat;
    data['service_vat'] = this.service_vat;
    data['service_total'] = this.service_total;

    data['equip_amt'] = this.equip_amt;
    data['equip_pvat'] = this.equip_pvat;
    data['equip_vat'] = this.equip_vat;
    data['equip_total'] = this.equip_total;

    data['water'] = this.water;
    data['electricity'] = this.electricity;
    data['remark'] = this.remark;
    data['service_total_future'] = this.service_total_future;
    data['rent_total_future'] = this.rent_total_future;
    data['total_bill'] = this.total_bill;
    data['renew_cid'] = this.renew_cid;
    return data;
  }
}
