
class ProductCategorys {
    String categoryCode;
    String description;
    bool isInternalStock;
    String createdBy;
    String createdOn;
    String modifiedBy;
    String modifiedOn;

    ProductCategorys({
        this.categoryCode,
        this.description,
        this.isInternalStock,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
    });

    factory ProductCategorys.fromJson(Map<String, dynamic> json) => new ProductCategorys(
        categoryCode: json["CategoryCode"],
        description: json["Description"],
        isInternalStock: json["IsInternalStock"],
        createdBy: json["CreatedBy"],
        createdOn: json["CreatedOn"],
        modifiedBy: json["ModifiedBy"],
        modifiedOn: json["ModifiedOn"],
    );

    Map<String, dynamic> toJson() => {
        "CategoryCode": categoryCode,
        "Description": description,
        "IsInternalStock": isInternalStock,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn,
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn,
    };
}
   
class ProductSaveDetails 
{
  String categoryCode;
  String description;
  String createdBy;
  
  ProductSaveDetails(
  {
  this.categoryCode,
  this.description,
  this.createdBy,
  });
    
  Map<String, dynamic> toJson() => 
  {
  'categoryCode': categoryCode,
  'description': description,
  'createdBy': createdBy,
  };


      
}