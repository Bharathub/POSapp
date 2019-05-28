class PurchaeOrderHD {
    String poNo;
    DateTime poDate;
    int branchId;
    String supplierCode;
    String supplierName;
    DateTime shipmentDate;
    String receiveDate;
    DateTime estimateDate;
    String referenceNo;
    String buyer;
    String prNo;
    String incoTerms;
    String paymentTerm;
    String paymentTermDescription;
    bool poStatus;
    double totalAmount;
    double otherCharges;
    bool isVat;
    double vatAmount;
    double netAmount;
    bool isCancel;
    String remarks;
    String contactPerson;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    List<PurchaseOrderDetails> purchaseOrderDetails;
    // dynamic supplierList;
    // dynamic branchList;
    // dynamic productsList;
    // dynamic uomList;
    // dynamic incoTermList;
    // dynamic currencyCodeList;
    // dynamic paymentTypeList;

    PurchaeOrderHD({
        this.poNo,
        this.poDate,
        this.branchId,
        this.supplierCode,
        this.supplierName,
        this.shipmentDate,
        this.receiveDate,
        this.estimateDate,
        this.referenceNo,
        this.buyer,
        this.prNo,
        this.incoTerms,
        this.paymentTerm,
        this.paymentTermDescription,
        this.poStatus,
        this.totalAmount,
        this.otherCharges,
        this.isVat,
        this.vatAmount,
        this.netAmount,
        this.isCancel,
        this.remarks,
        this.contactPerson,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.purchaseOrderDetails,
        // this.supplierList,
        // this.branchList,
        // this.productsList,
        // this.uomList,
        // this.incoTermList,
        // this.currencyCodeList,
        // this.paymentTypeList,
    });

    factory PurchaeOrderHD.fromJson(Map<String, dynamic> json) => new PurchaeOrderHD(
        poNo: json["PONo"],
        // poDate: json["PODate"],
        poDate: DateTime.parse(json["PODate"].toString()),        
        // branchId: json["BranchID"],
        branchId: int.parse(json["BranchID"].toString()),
        supplierCode: json["SupplierCode"],
        supplierName: json["SupplierName"],
        //if(json["ShipmentDate"] != null){
        shipmentDate: json["ShipmentDate"] != null ? DateTime.parse(json["ShipmentDate"].toString()) : json["ShipmentDate"],
        receiveDate: json["ReceiveDate"],
        estimateDate:json["EstimateDate"] !=null ? DateTime.parse(json["EstimateDate"].toString()) : json["EstimateDate"],
        referenceNo: json["ReferenceNo"],
        buyer: json["Buyer"],
        prNo: json["PRNo"],
        incoTerms: json["IncoTerms"],
        paymentTerm: json["PaymentTerm"],
        paymentTermDescription: json["PaymentTermDescription"],
        poStatus: json["POStatus"],
        totalAmount: json["TotalAmount"],
        otherCharges: json["OtherCharges"],
        isVat: json["IsVAT"],
        vatAmount: json["VATAmount"],
        netAmount: json["NetAmount"],
        isCancel: json["IsCancel"],
        remarks: json["Remarks"],
        contactPerson: json["ContactPerson"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"]),
        purchaseOrderDetails: json["PurchaseOrderDetails"] != null ?
                               List<PurchaseOrderDetails>.from(json["PurchaseOrderDetails"].map((poItems)=>
                                new PurchaseOrderDetails.fromJson(poItems))).toList()
                                : null,


        // supplierList: json["SupplierList"],
        // branchList: json["BranchList"],
        // productsList: json["ProductsList"],
        // uomList: json["UOMList"],
        // incoTermList: json["IncoTermList"],
        // currencyCodeList: json["CurrencyCodeList"],
        // paymentTypeList: json["PaymentTypeList"],
    );

    Map<String, dynamic> toJson() => {
        "PONo": poNo,
        "PODate": poDate.toString(),
        "BranchID": branchId,
        "SupplierCode": supplierCode,
        "SupplierName": supplierName,
        "ShipmentDate": shipmentDate.toString(),
        "ReceiveDate": receiveDate,
        "EstimateDate": estimateDate.toString(),
        "ReferenceNo": referenceNo,
        "Buyer": buyer,
        "PRNo": prNo,
        "IncoTerms": incoTerms,
        "PaymentTerm": paymentTerm,
        "PaymentTermDescription": paymentTermDescription,
        "POStatus": poStatus,
        "TotalAmount": totalAmount,
        "OtherCharges": otherCharges,
        "IsVAT": isVat,
        "VATAmount": vatAmount,
        "NetAmount": netAmount,
        "IsCancel": isCancel,
        "Remarks": remarks,
        "ContactPerson": contactPerson,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toIso8601String(),
        "PurchaseOrderDetails": purchaseOrderDetails.map((poDtls) => poDtls.toJson()).toList(),
        // "SupplierList": supplierList,
        // "BranchList": branchList,
        // "ProductsList": productsList,
        // "UOMList": uomList,
        // "IncoTermList": incoTermList,
        // "CurrencyCodeList": currencyCodeList,
        // "PaymentTypeList": paymentTypeList,
    };
}



class PurchaseOrderDetails 
{
    String poNo;
    String productCode;
    String productDescription;
    double quantity;
    String uom;
    double unitPrice;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    String currencyCode;
    String currencyDescription;

    PurchaseOrderDetails({
        this.poNo,
        this.productCode,
        this.productDescription,
        this.quantity,
        this.uom,
        this.unitPrice,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.currencyCode,
        this.currencyDescription,
    });

    factory PurchaseOrderDetails.fromJson(Map<String, dynamic> json) { 
      return new PurchaseOrderDetails(
        poNo: json["PONo"],
        productCode: json["ProductCode"],
        productDescription: json["ProductDescription"],
        quantity: json["Quantity"],
        uom: json["UOM"],
        unitPrice: json["UnitPrice"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"]),
        currencyCode: json["CurrencyCode"],
        currencyDescription: json["CurrencyDescription"],
    );
    }

    Map<String, dynamic> toJson() => {
        "PONo": poNo,
        "ProductCode": productCode,
        "ProductDescription": productDescription,
        "Quantity": quantity,
        "UOM": uom,
        "UnitPrice": unitPrice,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toString(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toString(),
        "CurrencyCode": currencyCode,
        "CurrencyDescription": currencyDescription,
    };
}
