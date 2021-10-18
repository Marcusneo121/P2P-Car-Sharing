class MyCarModel {
  final String imagePath;
  final String carName,
      carPlate,
      price,
      location,
      seat,
      yearMade,
      color,
      engine;
  final List<String> images;

  MyCarModel({
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
  });
}

class MyCarList {
  static List<MyCarModel> myCarList = [];
}
