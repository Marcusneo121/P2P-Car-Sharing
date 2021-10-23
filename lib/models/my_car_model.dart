class MyCarModel {
  final String imagePath;
  final String carName,
      carPlate,
      price,
      location,
      seat,
      yearMade,
      color,
      engine,
      toDate,
      fromDate,
      ownerID,
      ownerEmail,
      ownerContact,
      ownerName,
      ownerImage;
  final List<String> images;

  MyCarModel({
    required this.toDate,
    required this.fromDate,
    required this.imagePath,
    required this.carName,
    required this.carPlate,
    required this.images,
    required this.price,
    required this.location,
    required this.seat,
    required this.yearMade,
    required this.color,
    required this.engine,
    required this.ownerID,
    required this.ownerEmail,
    required this.ownerContact,
    required this.ownerName,
    required this.ownerImage,
  });
}

class MyCarList {
  static List<MyCarModel> myCarList = [];
}
