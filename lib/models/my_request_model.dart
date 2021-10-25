class MyRequestModel {
  final String imagePath;
  final String carID,
      carName,
      carPlate,
      price,
      originalPrice,
      location,
      toDate,
      fromDate,
      ownerID,
      ownerEmail,
      ownerName,
      ownerImage,
      status;

  MyRequestModel(
      {required this.carID,
      required this.toDate,
      required this.fromDate,
      required this.imagePath,
      required this.carName,
      required this.carPlate,
      required this.price,
      required this.originalPrice,
      required this.location,
      required this.ownerID,
      required this.ownerEmail,
      required this.ownerName,
      required this.ownerImage,
      required this.status});
}

class MyRequestList {
  static List<MyRequestModel> myRequestList = [];
}
