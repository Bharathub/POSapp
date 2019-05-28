class Supplier {
    String customerCode;
    String customerName;
    String registrationNo;
    String customerType;
    bool status;
    String remark;
    double creditTerm;
    String customerMode = "SUPPLIER";
    String addressId;
    String createdBy;
    String createdOn;
    String modifiedBy;
    String modifiedOn;
    String contactPerson;
    String countryList;
    String address1;
    String address2;
    String city;
    String state;
    String zipcode;
    String phonenum;
    String fax;
    String email;

    SupplierAddress supplierAddress;
    //dynamic customerProducts;
    // dynamic customerAddress;
    // dynamic customerModeList;


    Supplier({
        this.customerCode,
        this.customerName,
        this.registrationNo,
        this.customerType,
        this.status,
        this.remark,
        this.creditTerm,
        this.customerMode,
        this.addressId,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.contactPerson,
        // this.customerProducts,
        // this.customerAddress,
        this.countryList,
        // this.customerModeList,
        this.supplierAddress,
        
    });

    factory Supplier.fromJson(Map<String, dynamic> json) =>
      new Supplier(
        customerCode: json["CustomerCode"],
        customerName: json["CustomerName"],
        registrationNo: json["RegistrationNo"],
        customerType: json["CustomerType"],
        status: json["Status"],
        remark: json["Remark"],
        creditTerm: double.parse(json["CreditTerm"].toString()),
        customerMode: json["CustomerMode"],
        addressId: json["AddressID"],
        createdBy: json["CreatedBy"],
        createdOn: json["CreatedOn"],
        modifiedBy: json["ModifiedBy"],
        modifiedOn: json["ModifiedOn"],
        contactPerson: json["ContactPerson"],
        // customerProducts: json["CustomerProducts"],
        supplierAddress: json["CustomerAddress"] != null ? SupplierAddress.fromJson(json["CustomerAddress"]) : null,
        countryList: json["CountryList"],
        // customerModeList: json["CustomerModeList"],
      );
    

    Map<String, dynamic> toJson() => {
        "CustomerCode": customerCode,
        "CustomerName": customerName,
        "RegistrationNo": registrationNo,
        "CustomerType": customerType,
        "Status": status,
        "Remark": remark,
        "CreditTerm": creditTerm,
        "CustomerMode": customerMode,
        "AddressID": addressId,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn,
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn,
        "ContactPerson": contactPerson,
        // "CustomerProducts": customerProducts,
        // "CustomerAddress": supplierAddress.toJson(),
        "CustomerAddress": supplierAddress.toJson(),
        "CountryList": countryList,
        // "CustomerModeList": customerModeList,
    };
}
class SupplierAddress{
  String address1;
  String address2;
  String city;
  String state;
  String zipcode;
  String countryCode;
  String phonenum;
  String fax;
  String email;
  String addressType;

  SupplierAddress({
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.zipcode,
    this.countryCode,
    this.phonenum,
    this.fax,
    this.email,
    this.addressType,

  });
   factory SupplierAddress.fromJson(Map<String, dynamic> json) => new SupplierAddress(
      
        address1: json["Address1"],
        address2: json["Address2"],
        city: json["City"],
        state: json["State"],
        zipcode: json["Zipcode"],
        countryCode: json["CountryCode"],
        phonenum: json["Phonenum"],
        fax:json["Fax"],
        email: json["Email"],
        addressType: json["AddressType"],
      );

    Map<String, dynamic> toJson() => {
        "Address1": address1,
        "Address2": address2,
        "City":city,
        "State":state,
        "Zipcode":zipcode,
        "CountryCode":countryCode,
        "Phonenum":phonenum,
        "Fax":fax,
        "Email":email,
        "AddressType":addressType
    };
} 
class CountryList { 
    String countryCode;
    String countryName;
    String description;

    CountryList({
        this.countryCode,
        this.countryName,
        this.description,
    });

    factory CountryList.fromJson(Map<String, dynamic> json) => new CountryList(
        countryCode: json["CountryCode"],
        countryName: json["CountryName"],
        description: json["Description"],
    );

    Map<String, dynamic> toJson() => {
        "CountryCode": countryCode,
        "CountryName": countryName,
        "Description": description,
    };
}