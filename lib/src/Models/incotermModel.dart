class Incoterm {
    String lookupCode;
    String description;
    String description2;
    String category;
    bool status;

    Incoterm({
        this.lookupCode,
        this.description,
        this.description2,
        this.category,
        this.status,
    });

    factory Incoterm.fromJson(Map<String, dynamic> json) => new Incoterm(
        lookupCode: json["LookupCode"],
        description: json["Description"],
        description2: json["Description2"],
        category: json["Category"],
        status: json["Status"],
    );

    Map<String, dynamic> toJson() => {
        "LookupCode": lookupCode,
        "Description": description,
        "Description2": description2,
        "Category": category,
        "Status": status,
    };
}
