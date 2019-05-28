class BranchModel {
    int branchId;
    String branchCode;
    String branchName;
    String regNo;
    bool isActive;
    String companyCode;
    String addressId;
    String createdBy;
    DateTime createdOn;
    String modifiedBy;
    DateTime modifiedOn;
    dynamic branchAddress;
    dynamic countryList;

    BranchModel({
        this.branchId,
        this.branchCode,
        this.branchName,
        this.regNo,
        this.isActive,
        this.companyCode,
        this.addressId,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.branchAddress,
        this.countryList,
    });

    factory BranchModel.fromJson(Map<String, dynamic> json) => new BranchModel(
        branchId: json["BranchID"],
        branchCode: json["BranchCode"],
        branchName: json["BranchName"],
        regNo: json["RegNo"],
        isActive: json["IsActive"],
        companyCode: json["CompanyCode"],
        addressId: json["AddressID"],
        createdBy: json["CreatedBy"],
        createdOn: DateTime.parse(json["CreatedOn"]),
        modifiedBy: json["ModifiedBy"],
        modifiedOn: DateTime.parse(json["ModifiedOn"]),
        branchAddress: json["BranchAddress"],
        countryList: json["CountryList"],
    );

    Map<String, dynamic> toJson() => {
        "BranchID": branchId,
        "BranchCode": branchCode,
        "BranchName": branchName,
        "RegNo": regNo,
        "IsActive": isActive,
        "CompanyCode": companyCode,
        "AddressID": addressId,
        "CreatedBy": createdBy,
        "CreatedOn": createdOn.toIso8601String(),
        "ModifiedBy": modifiedBy,
        "ModifiedOn": modifiedOn.toIso8601String(),
        "BranchAddress": branchAddress,
        "CountryList": countryList,
    };
}
