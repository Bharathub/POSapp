class InquiryModel {
    String productCode;
    String productDescription;
    String barCode;
    String productCategory;
    // int sellRate;
    String color;
    String size;
    String uom;
    String location;
    // int stockInHand;
    // int reOrderQty;
    String suppliers;
    // int buyingPrice;

    InquiryModel({
        this.productCode,
        this.productDescription,
        this.barCode,
        this.productCategory,
        // this.sellRate,
        this.color,
        this.size,
        this.uom,
        this.location,
        // this.stockInHand,
        // this.reOrderQty,
        this.suppliers,
        // this.buyingPrice,
    });

    factory InquiryModel.fromJson(Map<String, dynamic> json) => new InquiryModel(
        productCode: json["ProductCode"],
        productDescription: json["ProductDescription"],
        barCode: json["BarCode"],
        productCategory: json["ProductCategory"],
        // sellRate: json["SellRate"],
        color: json["Color"],
        size: json["Size"],
        uom: json["UOM"],
        location: json["Location"],
        // stockInHand: json["StockInHand"],
        // reOrderQty: json["ReOrderQty"],
        suppliers: json["Suppliers"],
        // buyingPrice: json["BuyingPrice"],
    );

    Map<String, dynamic> toJson() => {
        "ProductCode": productCode,
        "ProductDescription": productDescription,
        "BarCode": barCode,
        "ProductCategory": productCategory,
        // "SellRate": sellRate,
        "Color": color,
        "Size": size,
        "UOM": uom,
        "Location": location,
        // "StockInHand": stockInHand,
        // "ReOrderQty": reOrderQty,
        "Suppliers": suppliers,
        // "BuyingPrice": buyingPrice,
    };
}
