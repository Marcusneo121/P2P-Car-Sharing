class RenterRequestModel {
  final String imagePath;
  final String carID,
      carName,
      carPlate,
      price,
      originalPrice,
      location,
      toDate,
      fromDate,
      renterID,
      renterEmail,
      renterContact,
      renterName,
      renterImage,
      status;

  RenterRequestModel(
      {required this.carID,
      required this.toDate,
      required this.fromDate,
      required this.imagePath,
      required this.carName,
      required this.carPlate,
      required this.price,
      required this.originalPrice,
      required this.location,
      required this.renterID,
      required this.renterEmail,
      required this.renterContact,
      required this.renterName,
      required this.renterImage,
      required this.status});
}

class RenterRequestList {
  static List<RenterRequestModel> renterList = [];
}

// RenterRequestModel(
//   carID: "rtUNPxVxjPi2ZvPetZ6s",
//   toDate: "2021-10-26 00:00:00.000",
//   fromDate: "2021-10-24 03:09:10.050390",
//   imagePath:
//       "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/cars%2FTesla%20Model%20X.png?alt=media&token=c99aabf4-1662-45f8-9cf5-39c8c2a52f18",
//   carName: "Tesla Model X",
//   carPlate: "WRE 8392",
//   price: "380",
//   originalPrice: "430",
//   location: "71, Awana Puri Condominium",
//   renterID: "3FitQFF1naVCUymrnrLDqzhhkme2",
//   renterEmail: "marcus121neo@gmail.com",
//   renterContact: "0124939394",
//   renterName: "Admin Testing",
//   renterImage:
//       "https://firebasestorage.googleapis.com/v0/b/p2p-car-sharing.appspot.com/o/profilePic%2Fmarcus121neo%40gmail.com_3FitQFF1naVCUymrnrLDqzhhkme2.jpg?alt=media&token=bbe819e6-a9e5-4559-b5d9-63bc604403c3",
//   status: "requesting",
// ),
