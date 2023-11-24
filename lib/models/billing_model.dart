class BillingModel {
  String? total;
  String? totalAmount;
  String? itemcode;
  String? itemName;
  String? margin;
  String? itemdocid;
  String? paymentMode;
  String? hsncode;
  String? boxNo;
  String? customername;
  String? customerphone;
  String? customeraddress;
  String? purchaseno;
  String? purchasedate;
  String? purchasenote;
  int? qty;
  String? tax;
  bool? iMEINO;
  bool? image;
  List<String>? imeiNoList;
  List<String>? serialNoList;
  List<String>? colorList;
  List<String>? imageList;
  bool? serialNO;
  bool? color;
  String? category;
  String? brand;
  String? salesPrice;
  String? discountAmount;
  String? discAmountPercentage;
  String? creditDays;
  String? customerGstNo;
  String? withouttaxprice;
  bool? save;
  bool? return1;
  String? time;
  String? date;
  String? description;
  int? timestamp;

  BillingModel(
      {this.total,
        this.totalAmount,
        this.itemcode,
        this.itemName,
        this.margin,
        this.itemdocid,
        this.paymentMode,
        this.hsncode,
        this.boxNo,
        this.customername,
        this.customerphone,
        this.customeraddress,
        this.purchaseno,
        this.purchasedate,
        this.purchasenote,
        this.qty,
        this.tax,
        this.iMEINO,
        this.image,
        this.imeiNoList,
        this.serialNoList,
        this.colorList,
        this.imageList,
        this.serialNO,
        this.color,
        this.category,
        this.brand,
        this.salesPrice,
        this.discountAmount,
        this.discAmountPercentage,
        this.creditDays,
        this.customerGstNo,
        this.withouttaxprice,
        this.save,
        this.return1,
        this.time,
        this.date,
        this.description,
        this.timestamp});

  BillingModel.fromJson(Map<String, dynamic> json) {
    total = json['Total'];
    totalAmount = json['totalAmount'];
    itemcode = json['itemcode'];
    itemName = json['itemName'];
    margin = json['margin'];
    itemdocid = json['Itemdocid'];
    paymentMode = json['Payment mode'];
    hsncode = json['Hsncode'];
    boxNo = json['BoxNo'];
    customername = json['customername'];
    customerphone = json['customerphone'];
    customeraddress = json['customeraddress'];
    purchaseno = json['purchaseno'];
    purchasedate = json['purchasedate'];
    purchasenote = json['purchasenote'];
    qty = json['qty'];
    tax = json['tax'];
    iMEINO = json['IMEI NO'];
    image = json['image'];
    imeiNoList = json['imeiNoList'].cast<String>();
    serialNoList = json['serialNoList'].cast<String>();
    colorList = json['colorList'].cast<String>();
    imageList = json['imageList'].cast<String>();
    serialNO = json['Serial NO'];
    color = json['Color'];
    category = json['category'];
    brand = json['brand'];
    salesPrice = json['salesPrice'];
    discountAmount = json['discountAmount'];
    discAmountPercentage = json['discAmountPercentage'];
    creditDays = json['credit days'];
    customerGstNo = json['Customer GstNo'];
    withouttaxprice = json['withouttaxprice'];
    save = json['save'];
    return1 = json['return1'];
    time = json['time'];
    date = json['date'];
    description = json['description'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Total'] = this.total;
    data['totalAmount'] = this.totalAmount;
    data['itemcode'] = this.itemcode;
    data['itemName'] = this.itemName;
    data['margin'] = this.margin;
    data['Itemdocid'] = this.itemdocid;
    data['Payment mode'] = this.paymentMode;
    data['Hsncode'] = this.hsncode;
    data['BoxNo'] = this.boxNo;
    data['customername'] = this.customername;
    data['customerphone'] = this.customerphone;
    data['customeraddress'] = this.customeraddress;
    data['purchaseno'] = this.purchaseno;
    data['purchasedate'] = this.purchasedate;
    data['purchasenote'] = this.purchasenote;
    data['qty'] = this.qty;
    data['tax'] = this.tax;
    data['IMEI NO'] = this.iMEINO;
    data['image'] = this.image;
    data['imeiNoList'] = this.imeiNoList;
    data['serialNoList'] = this.serialNoList;
    data['colorList'] = this.colorList;
    data['imageList'] = this.imageList;
    data['Serial NO'] = this.serialNO;
    data['Color'] = this.color;
    data['category'] = this.category;
    data['brand'] = this.brand;
    data['salesPrice'] = this.salesPrice;
    data['discountAmount'] = this.discountAmount;
    data['discAmountPercentage'] = this.discAmountPercentage;
    data['credit days'] = this.creditDays;
    data['Customer GstNo'] = this.customerGstNo;
    data['withouttaxprice'] = this.withouttaxprice;
    data['save'] = this.save;
    data['return1'] = this.return1;
    data['time'] = this.time;
    data['date'] = this.date;
    data['description'] = this.description;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
