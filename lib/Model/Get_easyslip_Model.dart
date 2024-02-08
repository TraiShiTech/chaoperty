class easyslipModel {
  String? ser;
  String? datex;
  String? timex;
  String? user;
  String? rser;
  String? daterec;
  String? timerec;
  String? date;
  String? dateacc;
  String? dtype;
  String? shopno;
  String? pos;
  String? docno;
  String? custno;
  String? supno;
  String? refno;
  String? data_update;
  String? status;
  String? payload;
  String? trans_ref;
  String? slip_date;
  String? country_code;
  String? amount;
  String? currency;
  String? fee;
  String? ref1;
  String? ref2;
  String? ref3;
  String? sender_bankid;
  String? sen_bankname;
  String? sen_bankshort;
  String? sen_accnameTh;
  String? sen_accnameEn;
  String? sen_banktype;
  String? sen_accnumber;
  String? sen_proxy_type;
  String? sen_proxy_accnumber;
  String? recei_bankid;
  String? recei_bankname;
  String? recei_bankshort;
  String? recei_accnameTh;
  String? recei_accnameEn;
  String? recei_banktype;
  String? recei_accnumber;
  String? recei_proxy_type;
  String? recei_proxy_accnumber;
  String? merchant_Id;
  String? slip_img;

  easyslipModel(
      {this.ser,
      this.datex,
      this.timex,
      this.user,
      this.rser,
      this.daterec,
      this.timerec,
      this.date,
      this.dateacc,
      this.dtype,
      this.shopno,
      this.pos,
      this.docno,
      this.custno,
      this.supno,
      this.refno,
      this.data_update,
      this.status,
      this.payload,
      this.trans_ref,
      this.slip_date,
      this.country_code,
      this.amount,
      this.currency,
      this.fee,
      this.ref1,
      this.ref2,
      this.ref3,
      this.sender_bankid,
      this.sen_bankname,
      this.sen_bankshort,
      this.sen_accnameTh,
      this.sen_accnameEn,
      this.sen_banktype,
      this.sen_accnumber,
      this.sen_proxy_type,
      this.sen_proxy_accnumber,
      this.recei_bankid,
      this.recei_bankname,
      this.recei_bankshort,
      this.recei_accnameTh,
      this.recei_accnameEn,
      this.recei_banktype,
      this.recei_accnumber,
      this.recei_proxy_type,
      this.recei_proxy_accnumber,
      this.merchant_Id,
      this.slip_img});

  easyslipModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    datex = json['datex'];
    timex = json['timex'];
    user = json['user'];
    rser = json['rser'];
    daterec = json['daterec'];
    timerec = json['timerec'];
    date = json['date'];
    dateacc = json['dateacc'];
    dtype = json['dtype'];
    shopno = json['shopno'];
    pos = json['pos'];
    docno = json['docno'];
    custno = json['custno'];
    supno = json['supno'];
    refno = json['refno'];
    data_update = json['data_update'];
    status = json['status'];
    payload = json['payload'];
    trans_ref = json['trans_ref'];
    slip_date = json['slip_date'];
    country_code = json['country_code'];
    amount = json['amount'];
    currency = json['currency'];
    fee = json['fee'];
    ref1 = json['ref1'];
    ref2 = json['ref2'];
    ref3 = json['ref3'];
    sender_bankid = json['sender_bankid'];
    sen_bankname = json['sen_bankname'];
    sen_bankshort = json['sen_bankshort'];
    sen_accnameTh = json['sen_accnameTh'];
    sen_accnameEn = json['sen_accnameEn'];
    sen_banktype = json['sen_banktype'];
    sen_accnumber = json['sen_accnumber'];
    sen_proxy_type = json['sen_proxy_type'];
    sen_proxy_accnumber = json['sen_proxy_accnumber'];
    recei_bankid = json['recei_bankid'];
    recei_bankname = json['recei_bankname'];
    recei_bankshort = json['recei_bankshort'];
    recei_accnameTh = json['recei_accnameTh'];
    recei_accnameEn = json['recei_accnameEn'];
    recei_banktype = json['recei_banktype'];
    recei_accnumber = json['recei_accnumber'];
    recei_proxy_type = json['recei_proxy_type'];
    recei_proxy_accnumber = json['recei_proxy_accnumber'];
    merchant_Id = json['merchant_Id'];
    slip_img = json['slip_img'];
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
    data['dtype'] = this.dtype;
    data['shopno'] = this.shopno;
    data['pos'] = this.pos;
    data['docno'] = this.docno;
    data['custno'] = this.custno;
    data['supno'] = this.supno;
    data['refno'] = this.refno;
    data['data_update'] = this.data_update;
    data['status'] = this.status;
    data['payload'] = this.payload;
    data['trans_ref'] = this.trans_ref;
    data['slip_date'] = this.slip_date;
    data['country_code'] = this.country_code;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['fee'] = this.fee;
    data['ref1'] = this.ref1;
    data['ref2'] = this.ref2;
    data['ref3'] = this.ref3;
    data['sender_bankid'] = this.sender_bankid;
    data['sen_bankname'] = this.sen_bankname;
    data['sen_bankshort'] = this.sen_bankshort;
    data['sen_accnameTh'] = this.sen_accnameTh;
    data['sen_accnameEn'] = this.sen_accnameEn;
    data['sen_banktype'] = this.sen_banktype;
    data['sen_accnumber'] = this.sen_accnumber;
    data['sen_proxy_type'] = this.sen_proxy_type;
    data['sen_proxy_accnumber'] = this.sen_proxy_accnumber;
    data['recei_bankid'] = this.recei_bankid;
    data['recei_bankname'] = this.recei_bankname;
    data['recei_bankshort'] = this.recei_bankshort;
    data['recei_accnameTh'] = this.recei_accnameTh;
    data['recei_accnameEn'] = this.recei_accnameEn;
    data['recei_banktype'] = this.recei_banktype;
    data['recei_accnumber'] = this.recei_accnumber;
    data['recei_proxy_type'] = this.recei_proxy_type;
    data['recei_proxy_accnumber'] = this.recei_proxy_accnumber;
    data['merchant_Id'] = this.merchant_Id;
    data['slip_img'] = this.slip_img;
    return data;
  }
}
