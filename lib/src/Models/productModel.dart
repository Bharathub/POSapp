
class Product {
    String productCode;
    String description;
    String productCategory;
    String barCode;
    String uom;
    String size;
    String color;
    double currentQty;
    bool status;
    String createdBy;
    String createdOn;
    String modifiedBy;
    String modifiedOn;
    double reOrderQty;
    String location;
    String locationDescription;
    String productCategoryDescription;
    String uomDescription;
    double buyingPrice;
    double sellingPrice;
    // dynamic productCategoryList;
    // dynamic uomList;
    // dynamic locationList;
    // dynamic photo;

    Product({
        this.productCode,
        this.description,
        this.productCategory,
        this.barCode,
        this.uom,
        this.size,
        this.color,
        this.currentQty,
        this.status,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.reOrderQty,
        this.location,
        this.locationDescription,
        this.productCategoryDescription,
        this.uomDescription,
         this.buyingPrice,
        this.sellingPrice,
        // this.productCategoryList,
        // this.uomList,
        // this.locationList,
        // this.photo,
    });

    factory Product.fromJson(Map<String, dynamic> json) => new Product(
        productCode:  json["ProductCode"],
        description: json["Description"],
        productCategory: json["ProductCategory"],
        barCode: json["BarCode"],
        uom: json["UOM"],
        size: json["Size"],
        color: json["Color"],
        currentQty:double.parse(json["CurrentQty"].toString()),
        status: json["Status"],
        createdBy: json["CreatedBy"],
        createdOn: json["CreatedOn"],
        modifiedBy: json["ModifiedBy"],
        modifiedOn: json["ModifiedOn"],
        reOrderQty:double.parse(json["ReOrderQty"].toString()),
        location: json["Location"],
        locationDescription: json["LocationDescription"],
        productCategoryDescription: json["ProductCategoryDescription"],
        uomDescription: json["UOMDescription"],
        buyingPrice:double.parse(json["BuyingPrice"].toString()),
        sellingPrice: double.parse(json["SellingPrice"].toString()),

        // productCategoryList: json["ProductCategoryList"],
        // uomList: json["UOMList"],
        // locationList: json["LocationList"],
        // photo: json["Photo"],
    );

    Map<String, dynamic> toJson() => {
        "ProductCode": productCode,
        "Description": description,
        "ProductCategory": productCategory,
        "BarCode": barCode,
        "UOM": uom,
        "Size": size,
        "Color": color,
        "CurrentQty": currentQty,
        "Status": status,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn,
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn,
         "ReOrderQty": reOrderQty,
        "Location": location,
        "LocationDescription": locationDescription,
        "ProductCategoryDescription": productCategoryDescription,
        "UOMDescription": uomDescription,
        "BuyingPrice": buyingPrice,
        "SellingPrice": sellingPrice,
    //     "ProductCategoryList": productCategoryList,
    //     "UOMList": uomList,
    //     "LocationList": locationList,
    //     "Photo": photo,
     };
}
