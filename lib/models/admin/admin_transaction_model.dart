class AdminTransModel {
  final String transactionID,
      createdAt,
      paymentMethod,
      carID,
      ownerID,
      ownerEmail,
      ownerName,
      ownerImage,
      renterID,
      renterEmail,
      renterName,
      renterImage,
      totalAmount;

  AdminTransModel({
    required this.transactionID,
    required this.createdAt,
    required this.paymentMethod,
    required this.carID,
    required this.ownerID,
    required this.ownerEmail,
    required this.ownerName,
    required this.ownerImage,
    required this.renterID,
    required this.renterEmail,
    required this.renterName,
    required this.renterImage,
    required this.totalAmount,
  });
}

class AdminTransList {
  static List<AdminTransModel> adminTransList = [];
}
