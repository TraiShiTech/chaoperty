class TransBillPayChoiceModel {
  String? ser;
  String? datex;
  String? rser;
  String? daterec;
  String? date;
  String? duedate;
  String? dateacc;
  String? shopno;
  String? pos;
  String? st;
  String? docno;
  String? doctax;
  String? cid;
  String? fid;
  String? inv;
  String? refno;
  String? room_number;
  String? remark;
  String? zn;
  String? znn;
  String? zser;
  String? ln;
  String? tax;
  String? cname;
  String? sdate;
  String? ldate;
  String? pdate;
  String? user;
  String? count_pakan;
  String? pakan_amt;
  String? pakan_pvat;
  String? pakan_vat;
  String? pakan_total;
  String? service_amt;
  String? service_pvat;
  String? service_vat;
  String? service_wht;
  String? service_total;
  String? service_total_future;
  String? equip_amt;
  String? equip_pvat;
  String? equip_vat;
  String? equip_wht;
  String? equip_total;
  String? equip_total_future;
  String? total_bill;
  String? total_dis;
  String? total_bill_amt;
  String? total_bill_pvat;
  String? total_bill_vat;
  String? total_bill_wht;

  String? water_electri;
  String? rent_name;
  String? rent_amt;
  String? rent_pvat;
  String? rent_vat;
  String? rent_total;

  String? water;
  String? electricity;
  String? fine;
  String? stype;

  TransBillPayChoiceModel(
      {this.ser,
      this.datex,
      this.rser,
      this.daterec,
      this.date,
      this.duedate,
      this.dateacc,
      this.shopno,
      this.pos,
      this.st,
      this.docno,
      this.doctax,
      this.cid,
      this.fid,
      this.inv,
      this.refno,
      this.room_number,
      this.remark,
      this.zn,
      this.znn,
      this.zser,
      this.ln,
      this.tax,
      this.cname,
      this.sdate,
      this.ldate,
      this.pdate,
      this.user,
      this.count_pakan,
      this.pakan_amt,
      this.pakan_pvat,
      this.pakan_vat,
      this.pakan_total,
      this.service_amt,
      this.service_pvat,
      this.service_vat,
      this.service_wht,
      this.service_total,
      this.service_total_future,
      this.equip_amt,
      this.equip_pvat,
      this.equip_vat,
      this.equip_wht,
      this.equip_total,
      this.equip_total_future,
      this.total_bill,
      this.total_dis,
      this.total_bill_amt,
      this.total_bill_pvat,
      this.total_bill_vat,
      this.total_bill_wht,
      this.water_electri,
      this.rent_name,
      this.rent_amt,
      this.rent_pvat,
      this.rent_vat,
      this.rent_total,
      this.water,
      this.electricity,
      this.fine,
      this.stype});

  TransBillPayChoiceModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    rser = json['rser'];
    daterec = json['daterec'];
    date = json['date'];
    duedate = json['duedate'];
    dateacc = json['dateacc'];
    shopno = json['shopno'];
    pos = json['pos'];
    st = json['st'];
    docno = json['docno'];
    doctax = json['doctax'];
    cid = json['cid'];
    fid = json['fid'];
    inv = json['inv'];
    refno = json['refno'];
    room_number = json['room_number'];
    remark = json['remark'];
    zn = json['zn'];
    znn = json['znn'];
    zser = json['zser'];
    ln = json['ln'];
    tax = json['tax'];
    cname = json['cname'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    pdate = json['pdate'];
    user = json['user'];
    count_pakan = json['count_pakan'];
    pakan_amt = json['pakan_amt'];
    pakan_pvat = json['pakan_pvat'];
    pakan_vat = json['pakan_vat'];
    pakan_total = json['pakan_total'];
    service_amt = json['service_amt'];
    service_pvat = json['service_pvat'];
    service_vat = json['service_vat'];
    service_wht = json['service_wht'];
    service_total = json['service_total'];
    service_total_future = json['service_total_future'];
    equip_amt = json['equip_amt'];
    equip_pvat = json['equip_pvat'];
    equip_vat = json['equip_vat'];
    equip_wht = json['equip_wht'];
    equip_total = json['equip_total'];
    equip_total_future = json['equip_total_future'];
    total_bill = json['total_bill'];
    total_dis = json['total_dis'];

    total_bill_amt = json['total_bill_amt'];
    total_bill_vat = json['total_bill_vat'];
    total_bill_pvat = json['total_bill_pvat'];
    total_bill_wht = json['total_bill_wht'];

    water_electri = json['water_electri'];
    rent_name = json['rent_name'];
    rent_amt = json['rent_amt'];
    rent_pvat = json['rent_pvat'];
    rent_vat = json['rent_vat'];
    rent_total = json['rent_total'];

    water = json['water'];
    electricity = json['electricity'];
    fine = json['fine'];
    stype = json['stype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['datex'] = this.datex;
    data['rser'] = this.rser;
    data['daterec'] = this.daterec;
    data['date'] = this.date;
    data['duedate'] = this.duedate;
    data['dateacc'] = this.dateacc;
    data['shopno'] = this.shopno;
    data['pos'] = this.pos;
    data['st'] = this.st;
    data['docno'] = this.docno;
    data['doctax'] = this.doctax;
    data['cid'] = this.cid;
    data['fid'] = this.fid;
    data['inv'] = this.inv;
    data['refno'] = this.refno;
    data['room_number'] = this.room_number;
    data['remark'] = this.remark;
    data['zn'] = this.zn;
    data['znn'] = this.znn;
    data['zser'] = this.zser;
    data['ln'] = this.ln;
    data['tax'] = this.tax;
    data['cname'] = this.cname;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['pdate'] = this.pdate;
    data['user'] = this.user;
    data['count_pakan'] = this.count_pakan;
    data['pakan_amt'] = this.pakan_amt;
    data['pakan_pvat'] = this.pakan_pvat;
    data['pakan_vat'] = this.pakan_vat;
    data['pakan_total'] = this.pakan_total;
    data['service_amt'] = this.service_amt;
    data['service_pvat'] = this.service_pvat;
    data['service_vat'] = this.service_vat;
    data['service_wht'] = this.service_wht;
    data['service_total'] = this.service_total;
    data['service_total_future'] = this.service_total_future;
    data['equip_amt'] = this.equip_amt;
    data['equip_pvat'] = this.equip_pvat;
    data['equip_vat'] = this.equip_vat;
    data['equip_wht'] = this.equip_wht;
    data['equip_total'] = this.equip_total;
    data['equip_total_future'] = this.equip_total_future;
    data['total_bill'] = this.total_bill;
    data['total_dis'] = this.total_dis;
    data['total_bill_amt'] = this.total_bill_amt;
    data['total_bill_pvat'] = this.total_bill_pvat;
    data['total_bill_vat'] = this.total_bill_vat;
    data['total_bill_wht'] = this.total_bill_wht;

    data['water_electri'] = this.water_electri;
    data['rent_name'] = this.rent_name;
    data['rent_amt'] = this.rent_amt;
    data['rent_pvat'] = this.rent_pvat;
    data['rent_vat'] = this.rent_vat;
    data['rent_total'] = this.rent_total;
    data['water'] = this.water;
    data['electricity'] = this.electricity;
    data['fine'] = this.fine;
    data['stype'] = this.stype;

    return data;
  }
}
