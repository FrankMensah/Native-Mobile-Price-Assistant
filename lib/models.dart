class PricoData {
  final int? id;
  final String productCode;
  final String productName;
  final String productAmount;

  const PricoData(
      {this.id,
      required this.productCode,
      required this.productName,
      required this.productAmount});
}

class UserAccess {
  final int? id;
  final String loginPin;
  final String phoneNo;
  final String dodYear;
  final String adminPass;

  const UserAccess({
    this.id,
    required this.loginPin,
    required this.phoneNo,
    required this.dodYear,
    required this.adminPass,
  });
}
