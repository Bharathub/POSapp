import 'package:intl/intl.dart';

class UnApprovedInvoice {
  String invoiceNo;
  DateTime invoiceDate;
  String customerCode;
  double invoiceAmount;
  double pendingAmount;
  DateTime dueDate;
  String customerName;
  String invoiceType;
  String approvalStatus;
  bool isChecked;

  UnApprovedInvoice({
    this.invoiceNo,
    this.invoiceDate,
    this.customerCode,
    this.invoiceAmount,
    this.pendingAmount,
    this.dueDate,
    this.customerName,
    this.invoiceType,
    this.approvalStatus,
    this.isChecked,
  });

  factory UnApprovedInvoice.fromJson(Map<String, dynamic> json) =>
      new UnApprovedInvoice(
        invoiceNo: json["InvoiceNo"],
        invoiceDate: DateTime.parse(json["InvoiceDate"].toString()),
        customerCode: json["CustomerCode"],
        invoiceAmount: double.parse(json["InvoiceAmount"].toString()),
        pendingAmount: double.parse(json["PendingAmount"].toString()),
        dueDate: DateTime.parse(json["DueDate"]),
        customerName: json["CustomerName"],
        invoiceType: json["InvoiceType"],
        approvalStatus: json["ApprovalStatus"],
        isChecked: false,
      );

  Map<String, dynamic> toJson() => {
        "InvoiceNo": invoiceNo,
        "InvoiceDate": invoiceDate.toIso8601String(),
        "CustomerCode": customerCode,
        "InvoiceAmount": invoiceAmount,
        "PendingAmount": pendingAmount,
        "DueDate": dueDate.toIso8601String(),
        "CustomerName": customerName,
        "InvoiceType": invoiceType,
        "ApprovalStatus": approvalStatus,
      };
}

class SrchUnApprdInvoice
{
  int branchId;
  String customerCode;
  DateTime dateFrom;
  DateTime dateTo;
  String invoiceType;

  SrchUnApprdInvoice({
    this.branchId,
    this.customerCode,
    this.dateFrom,
    this.dateTo,
    this.invoiceType,
  });

  Map<String, dynamic> toJson() => {
        "BranchID": branchId,
        "CustomerCode": customerCode,
        // "DateFrom": dateFrom,
        "DateFrom": DateFormat('dd-MMM-yyyy').format(dateFrom),
        // "DateTo": dateTo,
        "DateTo": DateFormat('dd-MMM-yyyy').format(dateTo),
        "InvoiceType": invoiceType,
      };
}

class SelectedInvoices {
  int branchID;
  String invoiceNo;
  String userID;

  SelectedInvoices({
    this.branchID,
    this.invoiceNo,
    this.userID,
  });

  Map<String, dynamic> toJson() => {
        "BranchId": branchID,
        "InvoiceNo": invoiceNo,
        "UserId": userID,
      };
}

class InvoiceHeader {
    String invoiceNo;
    DateTime invoiceDate;
    String customerCode;
    String customerName;
    String invoiceType;
    double invoiceAmount;
    double taxAmount;
    double totalAmount;
    bool pendingPayment;
    DateTime paymentDate;
    DateTime dueDate;
    bool status;
    bool isApproved;
    String approvedBy;
    DateTime approvedOn;
    int branchId;
    double vatAmount;
    double whTaxPercent;
    double withHoldingAmount;
    double discountAmount;
    double paidAmount;
    double balanceAmount;
    bool isVat;
    bool isWhTax;
    DateTime balancePaidOn;
    String orderNo;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    bool isRequireDelivery;
    List<InvoiceDetail> invoiceDetails;
    // dynamic invoiceTypeList;
    // dynamic customersList;

    InvoiceHeader({
        this.invoiceNo,
        this.invoiceDate,
        this.customerCode,
        this.customerName,
        this.invoiceType,
        this.invoiceAmount,
        this.taxAmount,
        this.totalAmount,
        this.pendingPayment,
        this.paymentDate,
        this.dueDate,
        this.status,
        this.isApproved,
        this.approvedBy,
        this.approvedOn,
        this.branchId,
        this.vatAmount,
        this.whTaxPercent,
        this.withHoldingAmount,
        this.discountAmount,
        this.paidAmount,
        this.balanceAmount,
        this.isVat,
        this.isWhTax,
        this.balancePaidOn,
        this.orderNo,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.isRequireDelivery,
        this.invoiceDetails,
        // this.invoiceTypeList,
        // this.customersList,
    });

    factory InvoiceHeader.fromJson(Map<String, dynamic> json) => new InvoiceHeader(
        invoiceNo: json["InvoiceNo"],
        invoiceDate: DateTime.parse(json["InvoiceDate"]),
        customerCode: json["CustomerCode"].trim(),
        customerName: json["CustomerName"],
        invoiceType: json["InvoiceType"],
        invoiceAmount: double.parse(json["InvoiceAmount"].toString()),
        taxAmount: double.parse(json["TaxAmount"].toString()),
        totalAmount:double.parse(json["TotalAmount"].toString()),
        pendingPayment: json["PendingPayment"],
        paymentDate: DateTime.parse(json["PaymentDate"]),
        dueDate: DateTime.parse(json["DueDate"]),
        status: json["Status"],
        isApproved: json["IsApproved"],
        approvedBy: json["ApprovedBy"],
        approvedOn: DateTime.parse(json["ApprovedOn"]),
        branchId: int.parse(json["BranchID"].toString()),
        vatAmount: double.parse(json["VatAmount"].toString()),
        whTaxPercent: double.parse(json["WHTaxPercent"].toString()),
        withHoldingAmount:double.parse(json["WithHoldingAmount"].toString()),
        discountAmount: double.parse(json["DiscountAmount"].toString()),
        paidAmount:double.parse(json["PaidAmount"].toString()),
        balanceAmount: double.parse(json["BalanceAmount"].toString()),
        isVat: json["IsVat"],
        isWhTax: json["IsWHTax"],
        balancePaidOn: DateTime.parse(json["BalancePaidOn"]),
        orderNo: json["OrderNo"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"]),
        isRequireDelivery: json["IsRequireDelivery"],
        invoiceDetails: json["InvoiceDetails"]==null ? json["InvoiceDetails"] : InvoiceDetail.fromJson(json["InvoiceDetails"]),
        // invoiceTypeList: json["InvoiceTypeList"],
        // customersList: json["CustomersList"],
    );

    // Map<String, dynamic> toJson() => {
    //     "InvoiceNo": invoiceNo,
    //     "InvoiceDate": invoiceDate.toIso8601String(),
    //     "CustomerCode": customerCode,
    //     "CustomerName": customerName,
    //     "InvoiceType": invoiceType,
    //     "InvoiceAmount": invoiceAmount,
    //     "TaxAmount": taxAmount,
    //     "TotalAmount": totalAmount,
    //     "PendingPayment": pendingPayment,
    //     "PaymentDate": paymentDate.toIso8601String(),
    //     "DueDate": dueDate.toIso8601String(),
    //     "Status": status,
    //     "IsApproved": isApproved,
    //     "ApprovedBy": approvedBy,
    //     "ApprovedOn": approvedOn.toIso8601String(),
    //     "BranchID": branchId,
    //     "VatAmount": vatAmount,
    //     "WHTaxPercent": whTaxPercent,
    //     "WithHoldingAmount": withHoldingAmount,
    //     "DiscountAmount": discountAmount,
    //     "PaidAmount": paidAmount,
    //     "BalanceAmount": balanceAmount,
    //     "IsVat": isVat,
    //     "IsWHTax": isWhTax,
    //     "BalancePaidOn": balancePaidOn.toIso8601String(),
    //     "OrderNo": orderNo,
    //     "CreatedBy": createdBy,
    //     "CreatedOn": createdOn.toIso8601String(),
    //     "ModifiedBy": modifiedBy,
    //     "ModifiedOn": modifiedOn.toIso8601String(),
    //     "IsRequireDelivery": isRequireDelivery,
    //     "InvoiceDetails": invoiceDetails,
    //     "InvoiceTypeList": invoiceTypeList,
    //     "CustomersList": customersList,
    // };
}


class InvoiceDetail {
  String invoiceNo;
  String invoiceType;
  String invoiceTypeList;
  String isApproved;
  String isRequireDelivery;
  String isVat;
  String isWHTax;
  String modifiedBy;
  String modifiedOn;
  String orderNo;
  String paidAmount;
  String paymentDate;
  String pendingPayment;
  String status;
  String taxAmount;
  String totalAmount;
  String vatAmount;
  String wHTaxPercent;
  String withHoldingAmount;

  InvoiceDetail({
    this.invoiceNo,
    this.invoiceType,
    this.invoiceTypeList,
    this.isApproved,
    this.isRequireDelivery,
    this.isVat,
    this.isWHTax,
    this.modifiedBy,
    this.modifiedOn,
    this.orderNo,
    this.paidAmount,
    this.paymentDate,
    this.pendingPayment,
    this.status,
    this.taxAmount,
    this.totalAmount,
    this.vatAmount,
    this.wHTaxPercent,
    this.withHoldingAmount,
  });

  factory InvoiceDetail.fromJson(Map<String, dynamic> json) =>
      new InvoiceDetail(
        invoiceNo: json["InvoiceNo"],
        invoiceType: json["InvoiceType"],
        invoiceTypeList: json["InvoiceTypeList"],
        isApproved: json["IsApproved"],
        isRequireDelivery: json["IsRequireDelivery"],
        isVat: json["IsVat"],
        isWHTax: json["IsWHTax"],
        modifiedBy: json["ModifiedBy"],
        modifiedOn: json["ModifiedOn"],
        orderNo: json["OrderNo"],
        paidAmount: json["PaidAmount"],
        paymentDate: json["PaymentDate"],
        pendingPayment: json["PendingPayment"],
        status: json["Status"],
        taxAmount: json["TaxAmount"],
        totalAmount: json["TotalAmount"],
        vatAmount: json["VatAmount"],
        wHTaxPercent: json["WHTaxPercent"],
        withHoldingAmount: json["WithHoldingAmount"],
      );

  // Map<String, dynamic> toJson() => {
  //     "InvoiceNo" :invoiceNo,
  //     "InvoiceType":invoiceType,
  //     "InvoiceTypeList":invoiceTypeList,
  //     "IsApproved":isApproved,
  //     "IsRequireDelivery":isRequireDelivery,
  //     "IsVat":isVat,
  //     "IsWHTax":isWHTax,
  //     "ModifiedBy":modifiedBy,
  //     "ModifiedOn":modifiedOn,
  //     "OrderNo":orderNo,
  //     "PaidAmount":paidAmount,
  //     "PaymentDate":paymentDate,
  //     "PendingPayment":pendingPayment,
  //     "Status":status,
  //     "TaxAmount":taxAmount,
  //     "TotalAmount":totalAmount,
  //     "VatAmount":vatAmount,
  //     "WHTaxPercent":wHTaxPercent,
  //     "WithHoldingAmount":withHoldingAmount,
  //   };
}



class UnBilledInvoice {
    String invoiceNo;
    DateTime invoiceDate;
    String customerCode;
    double invoiceAmount;
    double pendingAmount;
    DateTime dueDate;
    String customerName;
    String invoiceType;
    String approvalStatus;
    bool isChecked;

    UnBilledInvoice({
        this.invoiceNo,
        this.invoiceDate,
        this.customerCode,
        this.invoiceAmount,
        this.pendingAmount,
        this.dueDate,
        this.customerName,
        this.invoiceType,
        this.approvalStatus,
        this.isChecked,
    });

    factory UnBilledInvoice.fromJson(Map<String, dynamic> json) => new UnBilledInvoice(
        invoiceNo: json["InvoiceNo"],
        invoiceDate: DateTime.parse(json["InvoiceDate"].toString()),
        customerCode: json["CustomerCode"],
        invoiceAmount:double.parse(json["InvoiceAmount"].toString()),
        pendingAmount: double.parse(json["PendingAmount"].toString()),
        dueDate: DateTime.parse(json["DueDate"].toString()),
        customerName: json["CustomerName"],
        invoiceType: json["InvoiceType"],
        approvalStatus: json["ApprovalStatus"],
        isChecked: false,
    );

    Map<String, dynamic> toJson() => {
        "InvoiceNo": invoiceNo,
        "InvoiceDate": invoiceDate.toIso8601String(),
        "CustomerCode": customerCode,
        "InvoiceAmount": invoiceAmount,
        "PendingAmount": pendingAmount,
        "DueDate": dueDate.toIso8601String(),
        "CustomerName": customerName,
        "InvoiceType": invoiceType,
        "ApprovalStatus": approvalStatus,
    };  
}
// customer invoicelists
class CustomerInvHd {
    String invoiceNo;
    DateTime invoiceDate;
    String customerCode;
    String customerName;
    String invoiceType;
    double invoiceAmount;
    double taxAmount;
    double totalAmount;
    bool pendingPayment;
    DateTime paymentDate;
    DateTime dueDate;
    bool status;
    bool isApproved;
    String approvedBy;
    DateTime approvedOn;
    int branchId;
    double vatAmount;
    double whTaxPercent;
    double withHoldingAmount;
    double discountAmount;
    double paidAmount;
    double balanceAmount;
    bool isVat;
    bool isWhTax;
    DateTime balancePaidOn;
    String orderNo;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    bool isRequireDelivery;
    List<CustomerInvDts> invoiceDetails;

    CustomerInvHd({
        this.invoiceNo,
        this.invoiceDate,
        this.customerCode,
        this.customerName,
        this.invoiceType,
        this.invoiceAmount,
        this.taxAmount,
        this.totalAmount,
        this.pendingPayment,
        this.paymentDate,
        this.dueDate,
        this.status,
        this.isApproved,
        this.approvedBy,
        this.approvedOn,
        this.branchId,
        this.vatAmount,
        this.whTaxPercent,
        this.withHoldingAmount,
        this.discountAmount,
        this.paidAmount,
        this.balanceAmount,
        this.isVat,
        this.isWhTax,
        this.balancePaidOn,
        this.orderNo,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.isRequireDelivery,
        this.invoiceDetails,
    });

    factory CustomerInvHd.fromJson(Map<String,dynamic> json) => new CustomerInvHd(
        invoiceNo: json["InvoiceNo"],
        invoiceDate: DateTime.parse(json["InvoiceDate"].toString()),
        customerCode: json["CustomerCode"],
        customerName: json["CustomerName"],
        invoiceType: json["InvoiceType"],
        invoiceAmount: double.parse(json["InvoiceAmount"].toString()),
        taxAmount: double.parse(json["TaxAmount"].toString()),
        totalAmount:double.parse(json["TotalAmount"].toString()),
        pendingPayment: json["PendingPayment"],
        paymentDate: DateTime.parse(json["PaymentDate"].toString()),
        dueDate: DateTime.parse(json["DueDate"].toString()),
        status: json["Status"],
        isApproved: json["IsApproved"],
        approvedBy: json["ApprovedBy"],
        approvedOn: DateTime.parse(json["ApprovedOn"].toString()),
        branchId:int.parse(json["BranchID"].toString()),
        vatAmount:double.parse(json["VatAmount"].toString()),
        whTaxPercent:double.parse(json["WHTaxPercent"].toString()),
        withHoldingAmount:double.parse(json["WithHoldingAmount"].toString()),
        discountAmount:double.parse(json["DiscountAmount"].toString()),
        paidAmount:double.parse(json["PaidAmount"].toString()),
        balanceAmount:double.parse(json["BalanceAmount"].toString()),
        isVat: json["IsVat"],
        isWhTax: json["IsWHTax"],
        balancePaidOn: DateTime.parse(json["BalancePaidOn"].toString()),
        orderNo: json["OrderNo"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"].toString()),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"].toString()),
        isRequireDelivery: json["IsRequireDelivery"],
        // invoiceDetails: json["InvoiceDetails"]== null ? json["InvoiceDetails"] : CustomerInvDts.fromJson(json["InvoiceDetails"]),
        invoiceDetails: json["InvoiceDetails"] != null ? List<CustomerInvDts>.from(json["InvoiceDetails"].map((invDts)=> new CustomerInvDts.fromJson(invDts))).toList(): null,
    );
    //  json["OrderDetails"] != null ? 
    //                     List<SalesEntryDetails>.from(json["OrderDetails"].map((seItem) => new SalesEntryDetails.fromJson(seItem))).toList()
    //                     : null,
    Map<String, dynamic> toJson() => {
        "InvoiceNo": invoiceNo,
        "InvoiceDate": invoiceDate.toIso8601String(),
        "CustomerCode": customerCode,
        "CustomerName": customerName,
        "InvoiceType": invoiceType,
        "InvoiceAmount": invoiceAmount,
        "TaxAmount": taxAmount,
        "TotalAmount": totalAmount,
        "PendingPayment": pendingPayment,
        "PaymentDate": paymentDate.toIso8601String(),
        "DueDate": dueDate.toIso8601String(),
        "Status": status,
        "IsApproved": isApproved,
        "ApprovedBy": approvedBy,
        "ApprovedOn": approvedOn.toIso8601String(),
        "BranchID": branchId,
        "VatAmount": vatAmount,
        "WHTaxPercent": whTaxPercent,
        "WithHoldingAmount": withHoldingAmount,
        "DiscountAmount": discountAmount,
        "PaidAmount": paidAmount,
        "BalanceAmount": balanceAmount,
        "IsVat": isVat,
        "IsWHTax": isWhTax,
        "BalancePaidOn": balancePaidOn.toIso8601String(),
        "OrderNo": orderNo,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toIso8601String(),
        "IsRequireDelivery": isRequireDelivery,
        "InvoiceDetails": invoiceDetails,
    };
}







class CustomerInvDts {
    String invoiceNo;
    String orderNo;
    double itemNo;
    String productCode;
    String productDescription;
    String barCode;
    double quantity;
    double price;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;

    CustomerInvDts({
        this.invoiceNo,
        this.orderNo,
        this.itemNo,
        this.productCode,
        this.productDescription,
        this.barCode,
        this.quantity,
        this.price,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn, loginInfo,
    });

    factory CustomerInvDts.fromJson(Map<String, dynamic> json) => new CustomerInvDts(
        invoiceNo: json["InvoiceNo"],
        orderNo: json["OrderNo"],
        itemNo: double.parse(json["ItemNo"].toString()),
        productCode: json["ProductCode"],
        productDescription: json["ProductDescription"],
        barCode: json["BarCode"],
        quantity: double.parse(json["Quantity"].toString()),
        price: double.parse(json["Price"].toString()),
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"].toString()),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "InvoiceNo": invoiceNo,
        "OrderNo": orderNo,
        "ItemNo": itemNo,
        "ProductCode": productCode,
        "ProductDescription": productDescription,
        "BarCode": barCode,
        "Quantity": quantity,
        "Price": price,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toIso8601String(),
    };
}
