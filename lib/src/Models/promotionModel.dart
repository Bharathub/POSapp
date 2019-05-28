class PromotionMod
{

String promotionID;
int branchID;
String productCode;
DateTime effectiveDate;
DateTime expiryDate;
String discountType;
String promotionType;
double discountAmount;
String promoProduct;
int qty;
bool status;

PromotionMod
({
  this.promotionID,
  this.branchID,
  this.productCode,
  this.effectiveDate,
  this.expiryDate,
  this.promotionType,
  this.discountType,
  this.discountAmount,
  this.promoProduct,
  this.qty,
  this.status
  });


  factory PromotionMod.fromJson(Map<String, dynamic> json) => new PromotionMod(
    promotionID: json["PromotionID"],
    branchID: json["BranchID"],
    productCode: json["ProductCode"],
    effectiveDate: DateTime.parse(json["EffectiveDate"]),
    expiryDate: DateTime.parse(json["ExpiryDate"]),
    promotionType: json['PromotionType'],
    discountType: json["DiscountType"],
    discountAmount: json["DiscountAmount"],
    promoProduct: json["PromoProduct"],
    qty: json["Qty"],
    status: json["Status"] == 1 ? true : false
  );
  
  Map<String, dynamic> toJson() => {
    "PromotionID": promotionID,
    "BranchID":   branchID,
    "ProductCode":productCode,
    "EffectiveDate":effectiveDate.toString(),
    "ExpiryDate":expiryDate.toString(),
    "PromotionType":promotionType,
    "DiscountType":discountType,
    "DiscountAmount":discountAmount,
    "PromoProduct":promoProduct,
    "Qty":qty,
    "Status":status,


  };
}