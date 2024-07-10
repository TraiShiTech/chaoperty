class TeNantCanCellChoiceModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? daterec;
  String? timerec;
  String? date;
  String? dateacc;
  String? duedate;
  String? cid;

  String? st;
  String? cc_remark;
  String? cc_date;
  String? cname;
  String? sname;
  String? stype;
  String? addr;
  String? tax;
  String? zn;
  String? zn1;
  String? zser;
  String? zser1;
  String? ln;
  String? sdate;
  String? ldate;
  String? docno;
  String? doctax;
  String? pdate;
  String? remark;
  String? total_bill;
  String? total_pay;
  String? pakan;
  String? pakan_vat;
  String? water_electri;
  String? rent_name;
  String? rent_amt;
  String? rent_vat;
  String? rent_total;
  String? service_name;
  String? service_amt;
  String? service_vat;
  String? service_total;
  String? water;
  String? electricity;
  String? fine;

  TeNantCanCellChoiceModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.daterec,
      this.timerec,
      this.date,
      this.dateacc,
      this.duedate,
      this.cid,
      this.st,
      this.cc_remark,
      this.cc_date,
      this.cname,
      this.sname,
      this.stype,
      this.addr,
      this.tax,
      this.zn,
      this.zn1,
      this.zser,
      this.zser1,
      this.ln,
      this.sdate,
      this.ldate,
      this.docno,
      this.doctax,
      this.pdate,
      this.remark,
      this.total_bill,
      this.total_pay,
      this.pakan,
      this.pakan_vat,
      this.water_electri,
      this.rent_name,
      this.rent_amt,
      this.rent_vat,
      this.rent_total,
      this.service_name,
      this.service_amt,
      this.service_vat,
      this.service_total,
      this.water,
      this.electricity,
      this.fine});

  TeNantCanCellChoiceModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    daterec = json['daterec'];
    timerec = json['timerec'];
    date = json['date'];
    dateacc = json['dateacc'];
    duedate = json['duedate'];
    cid = json['cid'];

    st = json['st'];
    cc_remark = json['cc_remark'];
    cc_date = json['cc_date'];
    cname = json['cname'];
    sname = json['sname'];
    stype = json['stype'];
    addr = json['addr'];
    tax = json['tax'];
    zn = json['zn'];
    zn1 = json['zn1'];
    zser = json['zser'];
    zser1 = json['zser1'];
    ln = json['ln'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    docno = json['docno'];
    doctax = json['doctax'];
    pdate = json['pdate'];
    remark = json['remark'];
    total_bill = json['total_bill'];
    total_pay = json['total_pay'];
    pakan = json['pakan'];
    pakan_vat = json['pakan_vat'];
    water_electri = json['water_electri'];
    rent_name = json['rent_name'];
    rent_amt = json['rent_amt'];
    rent_vat = json['rent_vat'];
    rent_total = json['rent_total'];
    service_name = json['service_name'];
    service_amt = json['service_amt'];
    service_vat = json['service_vat'];
    service_total = json['service_total'];
    water = json['water'];
    electricity = json['electricity'];
    fine = json['fine'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['timex'] = this.timex;
    data['user'] = this.user;
    data['rser'] = this.rser;
    data['daterec'] = this.daterec;
    data['timerec'] = this.timerec;
    data['date'] = this.date;
    data['dateacc'] = this.dateacc;
    data['duedate'] = this.duedate;
    data['cid'] = this.cid;

    data['st'] = this.st;
    data['cc_remark'] = this.cc_remark;
    data['cc_date'] = this.cc_date;
    data['cname'] = this.cname;
    data['sname'] = this.sname;
    data['stype'] = this.stype;
    data['addr'] = this.addr;
    data['tax'] = this.tax;
    data['zn'] = this.zn;
    data['zn1'] = this.zn1;
    data['zser'] = this.zser;
    data['zser1'] = this.zser1;
    data['ln'] = this.ln;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['docno'] = this.docno;
    data['doctax'] = this.doctax;
    data['pdate'] = this.pdate;
    data['remark'] = this.remark;
    data['total_bill'] = this.total_bill;
    data['total_pay'] = this.total_pay;
    data['pakan'] = this.pakan;
    data['pakan_vat'] = this.pakan_vat;
    data['water_electri'] = this.water_electri;
    data['rent_name'] = this.rent_name;
    data['rent_amt'] = this.rent_amt;
    data['rent_vat'] = this.rent_vat;
    data['rent_total'] = this.rent_total;
    data['service_name'] = this.service_name;
    data['service_amt'] = this.service_amt;
    data['service_vat'] = this.service_vat;
    data['service_total'] = this.service_total;
    data['water'] = this.water;
    data['electricity'] = this.electricity;
    data['fine'] = this.fine;
    return data;
  }
}
