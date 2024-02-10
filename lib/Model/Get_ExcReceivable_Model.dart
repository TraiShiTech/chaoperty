class BankExcBilling_Model {
  String? record_type;
  String? sequence_no;
  String? bank_code;

  String? company_account;
  String? payment_date;
  String? payment_time;
  String? customer_name;
  String? ref1;
  String? ref2;
  String? ref3;
  String? branch_no;
  String? teller_no;
  String? kind_Of_transaction;
  String? transaction_code;
  String? cheque_no;
  String? amount;
  String? cheque_bank_code;

  BankExcBilling_Model(
      {this.record_type,
      this.sequence_no,
      this.bank_code,
      this.company_account,
      this.payment_date,
      this.payment_time,
      this.customer_name,
      this.ref1,
      this.ref2,
      this.ref3,
      this.branch_no,
      this.teller_no,
      this.kind_Of_transaction,
      this.transaction_code,
      this.cheque_no,
      this.amount,
      this.cheque_bank_code});

  BankExcBilling_Model.fromJson(Map<String, dynamic> json) {
    record_type = json['record_type'];
    sequence_no = json['sequence_no'];
    bank_code = json['bank_code'];

    company_account = json['company_account'];
    payment_date = json['payment_date'];
    sequence_no = json['sequence_no'];
    payment_time = json['payment_time'];
    customer_name = json['customer_name'];
    ref1 = json['ref1'];
    ref2 = json['ref2'];
    ref3 = json['ref3'];
    branch_no = json['branch_no'];
    teller_no = json['teller_no'];
    kind_Of_transaction = json['kind_Of_transaction'];
    transaction_code = json['transaction_code'];
    cheque_no = json['cheque_no'];
    amount = json['amount'];
    cheque_bank_code = json['cheque_bank_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['record_type'] = this.record_type;
    data['sequence_no'] = this.sequence_no;
    data['bank_code'] = this.bank_code;

    data['company_account'] = this.company_account;
    data['sequence_no'] = this.sequence_no;
    data['payment_date'] = this.payment_date;
    data['payment_time'] = this.payment_time;
    data['customer_name'] = this.customer_name;
    data['ref1'] = this.ref1;
    data['ref2'] = this.ref2;
    data['ref3'] = this.ref3;
    data['branch_no'] = this.branch_no;
    data['teller_no'] = this.teller_no;
    data['kind_Of_transaction'] = this.kind_Of_transaction;
    data['transaction_code'] = this.transaction_code;
    data['cheque_no'] = this.cheque_no;
    data['amount'] = this.amount;
    data['cheque_bank_code'] = this.cheque_bank_code;
    return data;
  }
}
