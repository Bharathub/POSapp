
class StockInquiry {
    String productCode;
    String productDescription;
    String barCode;
    String productCategory;
    double sellRate;
    String color;
    String size;
    String uom;
    String location;
    double stockInHand;
    double reOrderQty;
    String suppliers;
    double buyingPrice;

    StockInquiry({
        this.productCode,
        this.productDescription,
        this.barCode,
        this.productCategory,
        this.sellRate,
        this.color,
        this.size,
        this.uom,
        this.location,
        this.stockInHand,
        this.reOrderQty,
        this.suppliers,
        this.buyingPrice,
    });

    factory StockInquiry.fromJson(Map<String, dynamic> json) => new StockInquiry(
        productCode: json["ProductCode"],
        productDescription: json["ProductDescription"],
        barCode: json["BarCode"],
        productCategory: json["ProductCategory"],
        sellRate:double.parse(json["SellRate"].toString()),
        color: json["Color"],
        size: json["Size"],
        uom: json["UOM"],
        location: json["Location"],
        stockInHand:double.parse(json["StockInHand"].toString()),
        reOrderQty:double.parse(json["ReOrderQty"].toString()),
        suppliers: json["Suppliers"],
        buyingPrice:double.parse(json["BuyingPrice"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "ProductCode": productCode,
        "ProductDescription": productDescription,
        "BarCode": barCode,
        "ProductCategory": productCategory,
        "SellRate": sellRate,
        "Color": color,
        "Size": size,
        "UOM": uom,
        "Location": location,
        "StockInHand": stockInHand,
        "ReOrderQty": reOrderQty,
        "Suppliers": suppliers,
        "BuyingPrice": buyingPrice,
    };
}



class Search4StockEnq {
    int branchId;
    dynamic productCode;
    String productCategory;
    String productLocation;
    dynamic supplierCode;

    Search4StockEnq({
        this.branchId,
        this.productCode,
        this.productCategory,
        this.productLocation,
        this.supplierCode,
    });

    // factory Search4StockEnq.fromJson(Map<String, dynamic> json) => new Search4StockEnq(
    //     branchId: json["BranchID"],
    //     productCode: json["ProductCode"],
    //     productCategory: json["ProductCategory"],
    //     productLocation: json["ProductLocation"],
    //     supplierCode: json["SupplierCode"],
    // );

    Map<String, dynamic> toJson() => {
        "BranchID": branchId,
        "ProductCode": productCode,
        "ProductCategory": productCategory,
        "ProductLocation": productLocation,
        "SupplierCode": supplierCode,
    };
}