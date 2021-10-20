class FavCarModel {
  final String imagePath;
  final String carID,
      carName,
      carPlate,
      price,
      location,
      seat,
      yearMade,
      color,
      engine,
      toDate,
      fromDate;
  final List<String> images;

  FavCarModel({
    required this.carID,
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
  });
}

class FavCarList {
  static List<FavCarModel> favCarList = [];
}

// class CarList {
//   static List<CarModel> list = [
//     CarModel(
//       imagePath: 'assets/Tesla Model X.png',
//       carName: 'Tesla Model X',
//       carPlate: 'KAE 9866',
//       price: '190',
//       images: [
//         'assets/Tesla Model X.png',
//         'assets/Tesla Model X.png',
//         'assets/Tesla Model X.png',
//         'assets/Tesla Model X.png',
//       ],
//     ),
//     CarModel(
//       imagePath: 'assets/Honda Civic.png',
//       carName: 'Honda Civic',
//       carPlate: 'KAE 9866',
//       price: '300',
//       images: [
//         'assets/Honda Civic 2022.png',
//         'assets/Honda Civic 2022.png',
//         'assets/Honda Civic.png',
//         'assets/Honda Civic.png',
//       ],
//     ),
//     CarModel(
//       imagePath: 'assets/Tesla Model 3.png',
//       carName: 'Tesla Model 3',
//       carPlate: 'KAE 9866',
//       price: '190',
//       images: [
//         'assets/Tesla Model 3.png',
//         'assets/Tesla Model 3.png',
//         'assets/Tesla Model 3.png',
//         'assets/Tesla Model 3.png',
//       ],
//     ),
//     CarModel(
//       imagePath: 'assets/Tesla Cybertruck.png',
//       carName: 'Tesla Cybertruck',
//       carPlate: 'KAE 9866',
//       price: '190/day',
//       images: [
//         'assets/Tesla Cybertruck.png',
//         'assets/Tesla Cybertruck.png',
//         'assets/Tesla Cybertruck.png',
//         'assets/Tesla Cybertruck.png',
//       ],
//     ),
//   ];
// }
