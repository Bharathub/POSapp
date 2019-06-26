
class GoodsReceiverHD {
    String documentNo;
    DateTime documentDate;
    int branchId;
    String documentType;
    String supplierCode;
    String supplierName;
    String poNo;
    bool status;
    bool isApproved;
    String approvedBy;
    DateTime approvedOn;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    List<GoodsReceiveItems> goodsReceivePoDetailList;
    // dynamic goodsReceiveDetails;
    // dynamic inspectionDomesticList;
    // dynamic goodsReceiveDetailsOverseasList;
    // dynamic inspectionOverSeasList;
    // dynamic branchList;
    // dynamic suppliersList;
    // dynamic productsList;

    GoodsReceiverHD({
        this.documentNo,
        this.documentDate,
        this.branchId,
        this.documentType,
        this.supplierCode,
        this.supplierName,
        this.poNo,
        this.status,
        this.isApproved,
        this.approvedBy,
        this.approvedOn,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.goodsReceivePoDetailList,
        // this.goodsReceiveDetails,
        // this.inspectionDomesticList,
        // this.goodsReceiveDetailsOverseasList,
        // this.inspectionOverSeasList,
        // this.branchList,
        // this.suppliersList,
        // this.productsList,
    });

    factory GoodsReceiverHD.fromJson(Map<String, dynamic> json) {
       return GoodsReceiverHD(
        documentNo: json["DocumentNo"],
        documentDate: DateTime.parse(json["DocumentDate"].toString()),
        branchId: json["BranchID"],
        documentType: json["DocumentType"],
        supplierCode: json["SupplierCode"],
        supplierName: json["SupplierName"],
        poNo: json["PONo"],
        status: json["Status"] == 1 ? true : false,
        isApproved: json["IsApproved"],
        approvedBy: json["ApprovedBy"],
        approvedOn: DateTime.parse(json["ApprovedOn"]),
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"]),
        goodsReceivePoDetailList: (json["GoodsReceivePODetailList"] == null) ? null : List<GoodsReceiveItems>.from(json["GoodsReceivePODetailList"].map((qItems) => new GoodsReceiveItems.fromJson(qItems))).toList(),        
        //  goodsReceiveDetails: json["GoodsReceiveDetails"],
        // inspectionDomesticList: json["InspectionDomesticList"],
        // goodsReceiveDetailsOverseasList: json["GoodsReceiveDetailsOverseasList"],
        // inspectionOverSeasList: json["InspectionOverSeasList"],
        // branchList: json["BranchList"],
        // suppliersList: json["SuppliersList"],
        // productsList: json["ProductsList"],
      );
    }

    Map<String, dynamic> toJson() => {
        "DocumentNo": documentNo,
        "DocumentDate": documentDate.toIso8601String(),
        "BranchID": branchId,
        "DocumentType": documentType,
        "SupplierCode": supplierCode,
        "SupplierName": supplierName,
        "PONo": poNo,
        "Status": status,
        "IsApproved": isApproved,
        "ApprovedBy": approvedBy,
        "ApprovedOn": approvedOn.toIso8601String(),
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toIso8601String(),
        "GoodsReceivePODetailList": goodsReceivePoDetailList,
        // "GoodsReceiveDetails": goodsReceiveDetails,
        // "InspectionDomesticList": inspectionDomesticList,
        // "GoodsReceiveDetailsOverseasList": goodsReceiveDetailsOverseasList,
        // "InspectionOverSeasList": inspectionOverSeasList,
        // "BranchList": branchList,
        // "SuppliersList": suppliersList,
        // "ProductsList": productsList,
    };
}


class GoodsReceiveItems {
    String documentNo;
    String poNo;
    String productCode;
    String productDescription;
    double quantity;
    double receiveQuantity;
    double pendingQuantity;
    String uom;
    double unitPrice;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    bool status;
    String currencyCode;
    String currencyDescription;
    dynamic currencyCodeList;

    GoodsReceiveItems({
        this.documentNo,
        this.poNo,
        this.productCode,
        this.productDescription,
        this.quantity,
        this.receiveQuantity,
        this.pendingQuantity,
        this.uom,
        this.unitPrice,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.status,
        this.currencyCode,
        this.currencyDescription,
        this.currencyCodeList,
    });

  factory GoodsReceiveItems.fromJson(Map<String, dynamic> json){
      return GoodsReceiveItems(
      documentNo: json["DocumentNo"],
      poNo: json["PONo"],
      productCode: json["ProductCode"],
      productDescription: json["ProductDescription"],
      quantity: double.parse(json["Quantity"].toString()),
      receiveQuantity: double.parse(json["ReceiveQuantity"].toString()),
      pendingQuantity: double.parse(json["PendingQuantity"].toString()),
      uom: json["UOM"],
      unitPrice: double.parse(json["UnitPrice"].toString()),
      createdBy: json["CreatedBy"],
      createdOn: DateTime.parse(json["CreatedOn"]),
      modifiedBy: json["ModifiedBy"],
      modifiedOn: DateTime.parse(json["ModifiedOn"]),
      status: json["Status"],   //== 1 ? true : false,
      currencyCode: json["CurrencyCode"],
      currencyDescription: json["CurrencyDescription"],
      currencyCodeList: json["CurrencyCodeList"],
    );
  }

  Map<String, dynamic> toJson() => {
      "DocumentNo": documentNo,
      "PONo": poNo,
      "ProductCode": productCode,
      "ProductDescription": productDescription,
      "Quantity": quantity,
      "ReceiveQuantity": receiveQuantity,
      "PendingQuantity": pendingQuantity,
      "UOM": uom,
      "UnitPrice": unitPrice,
      "CreatedBy": createdBy,
      "CreatedOn": createdOn.toIso8601String(),
      "ModifiedBy": modifiedBy,
      "ModifiedOn": modifiedOn.toIso8601String(),
      "Status": status,
      "CurrencyCode": currencyCode,
      "CurrencyDescription": currencyDescription,
      "CurrencyCodeList": currencyCodeList,
  };
}
