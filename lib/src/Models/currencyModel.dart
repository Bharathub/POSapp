class Currency {
    String currencyCode;
    String description;
    String description1;

    Currency({
        this.currencyCode,
        this.description,
        this.description1,
    });

    factory Currency.fromJson(Map<String, dynamic> json) => new Currency(
        currencyCode: json["CurrencyCode"],
        description: json["Description"],
        description1: json["Description1"],
    );

    Map<String, dynamic> toJson() => {
        "CurrencyCode": currencyCode,
        "Description": description,
        "Description1": description1,
    };
}
