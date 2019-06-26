
class ReportOptions
{
  String reportName;
  int branchID;
  String customerCode;
  String documentNo;
  DateTime dateFrom;
  DateTime dateTo;

  ReportOptions({ this.reportName, this.branchID, this.customerCode, this.documentNo, this.dateFrom, this.dateTo});

  Map<String, dynamic> toJSon() =>
  { 
    "reportName": reportName,
    "branchID": branchID,
    "customerCode": customerCode,
    "documentNo": documentNo,
    "dateFrom": dateFrom.toIso8601String(),
    "dateTo": dateTo.toIso8601String()
  };

}