
class SalesEntryHd {
    String orderNo;
    DateTime orderDate;
    int branchId;
    String customerCode;
    String customerName;
    String regNo;
    String customerAddress;
    String saleType;
    bool status;
    bool isApproved;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    bool isPayLater;
    int paymentDays;
    double totalAmount;
    bool isVat;
    bool isWhTax;
    double vatAmount;
    double whTaxPercent;
    double withHoldingAmount;
    double netAmount;
    double paidAmount;
    double balanceAmount;
    double discountAmount;
    String paymentType;
    bool isRequireDelivery;
    DateTime deliveryDate;
    String remarks;
    dynamic uom;
    List<SalesEntryDetails> orderDetails;
    dynamic orderTypeList;
    dynamic customersList;
    dynamic paymentTypeList;
    dynamic discountTypeList;
    dynamic uomList;
    String paymentTypeDescription;

    SalesEntryHd({
        this.orderNo,
        this.orderDate,
        this.branchId,
        this.customerCode,
        this.customerName,
        this.regNo,
        this.customerAddress,
        this.saleType,
        this.status,
        this.isApproved,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.isPayLater,
        this.paymentDays,
        this.totalAmount,
        this.isVat,
        this.isWhTax,
        this.vatAmount,
        this.whTaxPercent,
        this.withHoldingAmount,
        this.netAmount,
        this.paidAmount,
        this.balanceAmount,
        this.discountAmount,
        this.paymentType,
        this.isRequireDelivery,
        this.deliveryDate,
        this.remarks,
        this.uom,
        this.orderDetails,
        this.orderTypeList,
        this.customersList,
        this.paymentTypeList,
        this.discountTypeList,
        this.uomList,
        this.paymentTypeDescription,
    });

    factory SalesEntryHd.fromJson(Map<String, dynamic> json) {
       return SalesEntryHd(
        orderNo: json["OrderNo"],
        orderDate: DateTime.parse(json["OrderDate"]),
        branchId: int.parse(json["BranchID"].toString()),
        customerCode: json["CustomerCode"],
        customerName: json["CustomerName"],
        regNo: json["RegNo"],
        customerAddress: json["CustomerAddress"],
        saleType: json["SaleType"],
        status: json["Status"],
        isApproved: json["IsApproved"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"]),
        isPayLater: json["IsPayLater"],
        paymentDays: json["PaymentDays"],
        totalAmount: json["TotalAmount"],
        isVat: json["IsVAT"],
        isWhTax: json["IsWHTax"],
        vatAmount: json["VATAmount"],
        whTaxPercent: json["WHTaxPercent"],
        withHoldingAmount: json["WithHoldingAmount"],
        netAmount: json["NetAmount"],
        paidAmount: json["PaidAmount"],
        balanceAmount: json["BalanceAmount"],
        discountAmount: json["DiscountAmount"],
        paymentType: json["PaymentType"],
        isRequireDelivery: json["IsRequireDelivery"],
        deliveryDate: DateTime.parse(json["DeliveryDate"]),
        remarks: json["Remarks"],
        uom: json["UOM"],
        orderDetails: json["OrderDetails"] != null ? 
                        List<SalesEntryDetails>.from(json["OrderDetails"].map((seItem) => new SalesEntryDetails.fromJson(seItem))).toList()
                        : null,
        // orderTypeList: json["OrderTypeList"],
        // customersList: json["CustomersList"],
        // paymentTypeList: json["PaymentTypeList"],
        // discountTypeList: json["DiscountTypeList"],
        // uomList: json["UOMList"],
        // paymentTypeDescription: json["PaymentTypeDescription"],
   
    );
   }  

    Map<String, dynamic> toJson() => {
        "OrderNo": orderNo,
        "OrderDate": orderDate.toIso8601String(),
        "BranchID": branchId,
        "CustomerCode": customerCode,
        "CustomerName": customerName,
        "RegNo": regNo,
        "CustomerAddress": customerAddress,
        "SaleType": saleType,
        "Status": status,
        "IsApproved": isApproved,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toIso8601String(),
        "IsPayLater": isPayLater,
        "PaymentDays": paymentDays,
        "TotalAmount": totalAmount,
        "IsVAT": isVat,
        "IsWHTax": isWhTax,
        "VATAmount": vatAmount,
        "WHTaxPercent": whTaxPercent,
        "WithHoldingAmount": withHoldingAmount,
        "NetAmount": netAmount,
        "PaidAmount": paidAmount,
        "BalanceAmount": balanceAmount,
        "DiscountAmount": discountAmount,
        "PaymentType": paymentType,
        "IsRequireDelivery": isRequireDelivery,
        "DeliveryDate": deliveryDate.toIso8601String(),
        "Remarks": remarks,
        "UOM": uom,
        "OrderDetails": orderDetails.map((seDtl) => seDtl.toJson()).toList(),
        // "OrderTypeList": orderTypeList,
        // "CustomersList": customersList,
        // "PaymentTypeList": paymentTypeList,
        // "DiscountTypeList": discountTypeList,
        // "UOMList": uomList,
        // "PaymentTypeDescription": paymentTypeDescription,
    };
}


class SalesEntryDetails {
    String uom;
    String orderNo;
    int itemNo;
    String parentProductCode;
    String productCode;
    String productDescription;
    String barCode;
    double quantity;
    double cost;
    double sellRate;
    double sellPrice;
    String matchQuotation;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    String discountType;
    double discountAmount;
    double adjustAmount;
    double partialPayment;
    double totAmount;
    dynamic photo;
    String location;
    String locationDescription;
    int recordStatus;
    bool status;
    // dynamic productImageString;
    // dynamic productsList;
    // dynamic discountTypeList;

    SalesEntryDetails({
        this.uom,
        this.orderNo,
        this.itemNo,
        this.parentProductCode,
        this.productCode,
        this.productDescription,
        this.barCode,
        this.quantity,
        this.cost,
        this.sellRate,
        this.sellPrice,
        this.matchQuotation,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.discountType,
        this.discountAmount,
        this.adjustAmount,
        this.partialPayment,
        this.totAmount,
        this.photo,
        this.location,
        this.locationDescription,
        this.recordStatus,
        this.status,
        // this.productImageString,
        // this.productsList,
        // this.discountTypeList,
    });

    factory SalesEntryDetails.fromJson(Map<String, dynamic> json) => new SalesEntryDetails(
        uom: json["UOM"],
        orderNo: json["OrderNo"],
        itemNo: int.parse(json["ItemNo"].toString()),
        parentProductCode: json["ParentProduct"],
        productCode: json["ProductCode"],
        productDescription: json["ProductDescription"],
        barCode: json["BarCode"],
        quantity: double.parse(json["Quantity"].toString()),
        cost: json["Cost"],
        sellRate: double.parse(json["SellRate"].toString()),
        sellPrice: double.parse(json["SellPrice"].toString()),
        matchQuotation: json["MatchQuotation"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"]),
        discountType: json["DiscountType"],
        discountAmount: json["DiscountAmount"],
        adjustAmount: json["AdjustAmount"],
        partialPayment: json["PartialPayment"],
        photo: json["Photo"],
        location: json["Location"],
        locationDescription: json["LocationDescription"],
        recordStatus: json["RecordStatus"],
        status: json["Status"]
        // productImageString: json["ProductImageString"],
        // productsList: json["ProductsList"],
        // discountTypeList: json["DiscountTypeList"],
    );

    Map<String, dynamic> toJson() => {
        "UOM": uom,
        "OrderNo": orderNo,
        "ItemNo": itemNo,
        "parentProductCode": parentProductCode,
        "ProductCode": productCode,
        "ProductDescription": productDescription,
        "BarCode": barCode,
        "Quantity": quantity,
        "Cost": cost,
        "SellRate": sellRate.toString(),
        "SellPrice": sellPrice,
        "MatchQuotation": matchQuotation,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toIso8601String(),
        "DiscountType": discountType,
        "DiscountAmount": discountAmount,
        "AdjustAmount": adjustAmount,
        "PartialPayment": partialPayment,
        "Photo": photo,
        "Location": location,
        "LocationDescription": locationDescription,
        "RecordStatus": recordStatus,
        "Status": status,
        // "ProductImageString": productImageString,
        // "ProductsList": productsList,
        // "DiscountTypeList": discountTypeList,
    };
}
