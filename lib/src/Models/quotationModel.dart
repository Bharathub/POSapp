class QuotationHd {
    String quotationNo;
    int branchId;
    DateTime quotationDate;
    DateTime effectiveDate;
    DateTime expiryDate;
    String customerCode;
    String customerName;
    bool status;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    String quotationType;
    List<QuotationItems> quotationItems;

    QuotationHd({
        this.quotationNo,
        this.branchId,
        this.quotationDate,
        this.effectiveDate,
        this.expiryDate,
        this.customerCode,
        this.customerName,
        this.status,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.quotationType,
        this.quotationItems,
    });

    factory QuotationHd.fromJson(Map<String, dynamic> json) => new QuotationHd(
        quotationNo: json["QuotationNo"],
        // branchId: json["BranchID"],
        branchId: int.parse(json["BranchID"].toString()),
        quotationDate: DateTime.parse(json["QuotationDate"]),
        effectiveDate: DateTime.parse(json["EffectiveDate"]),
        expiryDate: DateTime.parse(json["ExpiryDate"]),
        customerCode: json["CustomerCode"],
        customerName: json["CustomerName"],
        status: json["Status"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"]),
        quotationType: json["QuotationType"],
        quotationItems: json["QuotationItems"] != null ? 
                        List<QuotationItems>.from(json["QuotationItems"].map((qItems) => new QuotationItems.fromJson(qItems))).toList()
                        : null,
    );

    Map<String, dynamic> toJson() => {
        "QuotationNo": quotationNo,
        "BranchID": branchId,
        "QuotationDate": quotationDate.toString(),
        "EffectiveDate": effectiveDate.toString(),
        "ExpiryDate": expiryDate.toString(),
        "CustomerCode": customerCode,
        "CustomerName": customerName,
        "Status": status,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toString(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toString(),
        "QuotationType": quotationType,
        "QuotationItems": quotationItems.map((quotDtl) => quotDtl.toJson()).toList(),
    };
}

class QuotationItems {
    String quotationNo;
    int itemId;
    String productCode;
    String productDescription;
    String barCode;
    double sellRate;
    String currencyCode;
    bool status;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    int recordStatus;

  //String CurrencyCodeList;
    // String productsList;

    QuotationItems({
        this.quotationNo,
        this.itemId,
        this.productCode,
        this.productDescription,
        this.barCode,
        this.sellRate,
        this.currencyCode,
        this.status,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.recordStatus,
        // this.productsList,
    });

    factory QuotationItems.fromJson(Map<String, dynamic> json) {
      return QuotationItems(
        quotationNo: json["QuotationNo"],
        itemId: json["ItemID"],
        productCode: json["ProductCode"],
        productDescription: json["ProductDescription"],
        barCode: json["BarCode"],
        sellRate: json["SellRate"],
        currencyCode: json["CurrencyCode"],
        status: json["Status"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"]),
        recordStatus: json["RecordStatus"],
        // productsList: json["ProductsList"],
      );
    }

    Map<String, dynamic> toJson() => {
        "QuotationNo": quotationNo,
        "ItemID": itemId,
        "ProductCode": productCode,
        "ProductDescription": productDescription,
        "BarCode": barCode,
        "SellRate": sellRate,
        "CurrencyCode": currencyCode,
        "Status": status,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toIso8601String(),
        "RecordStatus": recordStatus,
        // "ProductsList": productsList,
    };
}
