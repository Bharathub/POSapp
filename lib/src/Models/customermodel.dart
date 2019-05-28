
class Customer {
    String customerCode;
    String customerName;
    String registrationNo;
    String customerType = "CUSTOMER";
    bool status;
    String remark;
    int creditTerm;
    String customerMode = "CUSTOMER";
    String addressId;
    String createdBy;
    String createdOn;
    String modifiedBy;
    String modifiedOn;
    String contactPerson;
    
    // dynamic customerProducts;
    CustomerAddress customerAddress;
    // dynamic countryList;
    // dynamic customerModeList;


    Customer({
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
        this.customerAddress,
        // this.countryList,
        // this.customerModeList,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => new Customer(
        customerCode: json["CustomerCode"],
        customerName: json["CustomerName"],
        registrationNo: json["RegistrationNo"],
        customerType: json["CustomerType"],
        status: json["Status"],
        remark: json["Remark"],
        creditTerm: int.parse(json["CreditTerm"].toString()),
        customerMode: json["CustomerMode"],
        addressId: json["AddressID"],
        createdBy: json["CreatedBy"],
        createdOn: json["CreatedOn"],
        modifiedBy: json["ModifiedBy"],
        modifiedOn: json["ModifiedOn"],
        contactPerson: json["ContactPerson"],
        customerAddress: json["CustomerAddress"]  != null ? CustomerAddress.fromJson(json["CustomerAddress"]) : null,
        
      );
    Map<String, dynamic> toJson() => {
        "CustomerCode": customerCode,
        "CustomerName": customerName,
        "RegistrationNo": registrationNo,
        "CustomerType": customerType,
        "Status": status,
        "Remark": remark,
        "CreditTerm": creditTerm.toString(),
        "CustomerMode": customerMode,
        "AddressID": addressId,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn,
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn,
        "ContactPerson": contactPerson,
        // "CustomerProducts": customerProducts,
        "CustomerAddress": customerAddress.toJson(),
        // "CountryList": countryList,
        // "CustomerModeList": customerModeList,
    };
    
}


class CustomerAddress{
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

  CustomerAddress({
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

  factory CustomerAddress.fromJson(Map<String, dynamic> json) => new CustomerAddress(
      
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
    


