class DashBoards {
    double totalPurchases;
    double totalInvoice;
    double totalGr;

    DashBoards({
        this.totalPurchases,
        this.totalInvoice,
        this.totalGr,
    });

    factory DashBoards.fromJson(Map<String, dynamic> json) => new DashBoards(
        totalPurchases: double.parse(json["TotalPurchases"].toString()),
        totalInvoice:double.parse(json["TotalInvoice"].toDouble().toString()),
        totalGr: double.parse(json["TotalGR"].toString()),
    );

    Map<String, dynamic> toJson() => {
        "TotalPurchases": totalPurchases,
        "TotalInvoice": totalInvoice,
        "TotalGR": totalGr,
    };
}
