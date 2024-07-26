class PakanDocnoModel {
  String? st;
  String? cid;
  String? fid;
  String? unitser;
  String? ln;
  String? sname;
  String? cname;
  String? stype;
  String? sdate;
  String? ldate;
  String? pakan_docAll;
  String? amt_pakan;
  String? pvat_pakan;
  String? vat_pakan;
  String? total_pakan;
  String? min_docno;
  String? max_docno;
  String? min_doctax;
  String? max_doctax;
  String? min_date;
  String? max_date;

  PakanDocnoModel(
      {this.st,
      this.cid,
      this.fid,
      this.unitser,
      this.ln,
      this.sname,
      this.cname,
      this.stype,
      this.sdate,
      this.ldate,
      this.pakan_docAll,
      this.amt_pakan,
      this.pvat_pakan,
      this.vat_pakan,
      this.total_pakan,
      this.min_docno,
      this.max_docno,
      this.min_doctax,
      this.max_doctax,
      this.min_date,
      this.max_date});

  PakanDocnoModel.fromJson(Map<String, dynamic> json) {
    st = json['st'];
    cid = json['cid'];
    fid = json['fid'];
    unitser = json['unitser'];
    ln = json['ln'];
    sname = json['sname'];
    cname = json['cname'];
    stype = json['stype'];
    sdate = json['sdate'];
    ldate = json['ldate'];
    pakan_docAll = json['pakan_docAll'];
    amt_pakan = json['amt_pakan'];
    pvat_pakan = json['pvat_pakan'];
    vat_pakan = json['vat_pakan'];
    total_pakan = json['total_pakan'];
    min_docno = json['min_docno'];
    max_docno = json['max_docno'];
    min_doctax = json['min_doctax'];
    max_doctax = json['max_doctax'];
    min_date = json['min_date'];
    max_date = json['max_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['st'] = this.st;
    data['cid'] = this.cid;
    data['fid'] = this.fid;
    data['unitser'] = this.unitser;
    data['ln'] = this.ln;
    data['sname'] = this.sname;
    data['cname'] = this.cname;
    data['stype'] = this.stype;
    data['sdate'] = this.sdate;
    data['ldate'] = this.ldate;
    data['pakan_docAll'] = this.pakan_docAll;
    data['amt_pakan'] = this.amt_pakan;
    data['pvat_pakan'] = this.pvat_pakan;
    data['vat_pakan'] = this.vat_pakan;
    data['total_pakan'] = this.total_pakan;
    data['min_docno'] = this.min_docno;
    data['max_docno'] = this.max_docno;
    data['min_doctax'] = this.min_doctax;
    data['max_doctax'] = this.max_doctax;
    data['min_date'] = this.min_date;
    data['max_date'] = this.max_date;
    return data;
  }
}
