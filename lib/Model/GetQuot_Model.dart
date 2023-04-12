class QuotModel {
  String? ser;
  String? daterec;
  String? date;
  String? dateacc;
  String? docno;
  String? due;
  String? duedate;
  String? delivery;
  String? custno;
  String? supno;
  String? refno;
  String? xxxno;
  String? staff;
  String? stcode;
  String? name;
  String? namex;
  String? descr;
  String? unit;
  String? tqty;
  String? qty1;
  String? qty2;
  String? qty3;
  String? qty4;
  String? qty5;
  String? distype;
  String? dis;
  String? discount;
  String? amt;
  String? vtype;
  String? nvat;
  String? tax;
  String? dtype;
  String? pass;
  String? remark;
  String? copy;
  String? ucost;
  String? check;
  String? billno;
  String? pathimg;
  String? img;

  QuotModel({
    this.ser,
    this.daterec,
    this.date,
    this.dateacc,
    this.docno,
    this.due,
    this.duedate,
    this.delivery,
    this.custno,
    this.supno,
    this.refno,
    this.xxxno,
    this.staff,
    this.stcode,
    this.name,
    this.namex,
    this.descr,
    this.unit,
    this.tqty,
    this.qty1,
    this.qty2,
    this.qty3,
    this.qty4,
    this.qty5,
    this.distype,
    this.dis,
    this.discount,
    this.amt,
    this.vtype,
    this.nvat,
    this.tax,
    this.dtype,
    this.pass,
    this.remark,
    this.copy,
    this.ucost,
    this.check,
    this.billno,
    this.pathimg,
    this.img,
  });

  QuotModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    daterec = json['daterec'];
    date = json['date'];
    dateacc = json['dateacc'];
    docno = json['docno'];
    due = json['due'];
    duedate = json['duedate'];
    delivery = json['delivery'];
    custno = json['custno'];
    supno = json['supno'];
    refno = json['refno'];
    xxxno = json['xxxno'];
    staff = json['staff'];
    stcode = json['stcode'];
    name = json['name'];
    namex = json['namex'];
    descr = json['descr'];
    unit = json['unit'];
    tqty = json['tqty'];
    qty1 = json['qty1'];
    qty2 = json['qty2'];
    qty3 = json['qty3'];
    qty4 = json['qty4'];
    qty5 = json['qty5'];
    distype = json['distype'];
    dis = json['dis'];
    discount = json['discount'];
    amt = json['amt'];
    vtype = json['vtype'];
    nvat = json['nvat'];
    tax = json['tax'];
    dtype = json['dtype'];
    pass = json['pass'];
    remark = json['remark'];
    copy = json['copy'];
    ucost = json['ucost'];
    check = json['check'];
    billno = json['billno'];
    pathimg = json['pathimg'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['daterec'] = this.daterec;
    data['date'] = this.date;
    data['dateacc'] = this.dateacc;
    data['docno'] = this.docno;
    data['due'] = this.due;
    data['duedate'] = this.duedate;
    data['delivery'] = this.delivery;
    data['custno'] = this.custno;
    data['supno'] = this.supno;
    data['refno'] = this.refno;
    data['xxxno'] = this.xxxno;
    data['staff'] = this.staff;
    data['stcode'] = this.stcode;
    data['name'] = this.name;
    data['namex'] = this.namex;
    data['descr'] = this.descr;
    data['unit'] = this.unit;
    data['tqty'] = this.tqty;
    data['qty1'] = this.qty1;
    data['qty2'] = this.qty2;
    data['qty3'] = this.qty3;
    data['qty4'] = this.qty4;
    data['qty5'] = this.qty5;
    data['distype'] = this.distype;
    data['dis'] = this.dis;
    data['discount'] = this.discount;
    data['amt'] = this.amt;
    data['vtype'] = this.vtype;
    data['nvat'] = this.nvat;
    data['tax'] = this.tax;
    data['dtype'] = this.dtype;
    data['pass'] = this.pass;
    data['remark'] = this.remark;
    data['copy'] = this.copy;
    data['ucost'] = this.ucost;
    data['check'] = this.check;
    data['billno'] = this.billno;
    data['pathimg'] = this.pathimg;
    data['img'] = this.img;
    return data;
  }
}
