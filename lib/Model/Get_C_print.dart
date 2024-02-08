class PrintModel {
  String? ser;
  String? logo;
  String? bill_name;
  String? bill_addr;
  String? text;
  String? timex;
  String? datex;
  String? foot;
  String? foot_text;
  String? invoice;
  String? name;
  String? name_shop;
  String? area;
  String? zone;
  String? head;
  String? texthead;
  String? number;
  String? textfoot;
  String? name_custno;
  String? cash;

  PrintModel({
    this.ser,
    this.logo,
    this.bill_name,
    this.bill_addr,
    this.text,
    this.timex,
    this.datex,
    this.foot,
    this.foot_text,
    this.invoice,
    this.name,
    this.name_shop,
    this.area,
    this.zone,
    this.head,
    this.texthead,
    this.number,
    this.textfoot,
    this.name_custno,
    this.cash,
  });

  PrintModel.fromJson(Map<String, dynamic> json) {
    ser = json['ser'];
    logo = json['logo'];
    bill_name = json['bill_name'];
    bill_addr = json['bill_addr'];
    text = json['text'];
    timex = json['timex'];
    datex = json['datex'];
    foot = json['foot'];
    foot_text = json['foot_text'];
    invoice = json['invoice'];
    name = json['name'];
    name_shop = json['name_shop'];
    area = json['area'];
    zone = json['zone'];
    head = json['head'];
    texthead = json['texthead'];
    number = json['number'];
    textfoot = json['textfoot'];
    name_custno = json['name_custno'];
    cash = json['cash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ser'] = this.ser;
    data['logo'] = this.logo;
    data['bill_name'] = this.bill_name;
    data['bill_addr'] = this.bill_addr;
    data['text'] = this.text;
    data['timex'] = this.timex;
    data['datex'] = this.datex;
    data['foot'] = this.foot;
    data['foot_text'] = this.foot_text;
    data['invoice'] = this.invoice;
    data['name'] = this.name;
    data['name_shop'] = this.name_shop;
    data['area'] = this.area;
    data['zone'] = this.zone;
    data['head'] = this.head;
    data['texthead'] = this.texthead;
    data['number'] = this.number;
    data['textfoot'] = this.textfoot;
    data['name_custno'] = this.name_custno;
    data['cash'] = this.cash;

    return data;
  }
}
