class MyAdsModel {
  final int adId;
  final String adTitle;
  final double price;
  final String currency;
  final String description;
  final String location;
  final String publishDate;
  final int status;
  final Client client;
  final City city;
  final District district;
  final Info info;

  MyAdsModel({
    required this.adId,
    required this.adTitle,
    required this.price,
    required this.currency,
    required this.description,
    required this.location,
    required this.publishDate,
    required this.status,
    required this.client,
    required this.city,
    required this.district,
    required this.info,
  });

  factory MyAdsModel.fromJson(Map<String, dynamic> json) {
    return MyAdsModel(
      adId: json['AdId'],
      adTitle: json['AdTitle'],
      price: double.parse(json['Price']),
      currency: json['Currency'],
      description: json['Description'],
      location: json['Location'],
      publishDate: json['PublishDate'],
      status: json['Status'],
      client: Client.fromJson(json['data']['client']),
      city: City.fromJson(json['data']['city']),
      district: District.fromJson(json['data']['district']),
      info: Info.fromJson(json['data']['info']),
    );
  }
}

class Client {
  final int clientId;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String subscriptionDate;

  Client({
    required this.clientId,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.subscriptionDate,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientId: json['ClientId'],
      firstName: json['FirstName'],
      lastName: json['LastName'],
      phoneNumber: json['PhoneNumber'],
      email: json['Email'],
      subscriptionDate: json['SubscriptionDate'],
    );
  }
}

class City {
  final int cityId;
  final String cityName;

  City({
    required this.cityId,
    required this.cityName,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      cityId: json['CityId'],
      cityName: json['CityName'],
    );
  }
}

class District {
  final int districtId;
  final int cityId;
  final String districtName;

  District({
    required this.districtId,
    required this.cityId,
    required this.districtName,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      districtId: json['DistrictId'],
      cityId: json['CityId'],
      districtName: json['DistrictName'],
    );
  }
}

class Info {
  final int adId;
  final int totalArea;
  final int netArea;
  final int roomCount;
  final int floorNumber;
  final int? floorCount;
  final int bathroomCount;
  final String? furnish;
  final String constructionDate;
  final String address;
  final int balconyCount;
  final String complexName;

  Info({
    required this.adId,
    required this.totalArea,
    required this.netArea,
    required this.roomCount,
    required this.floorNumber,
    required this.floorCount,
    required this.bathroomCount,
    this.furnish,
    required this.constructionDate,
    required this.address,
    required this.balconyCount,
    required this.complexName,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      adId: json['AdId'],
      totalArea: json['TotalArea'],
      netArea: json['NetArea'],
      roomCount: json['RoomCount'] ?? 0,
      floorNumber: json['FloorNumber'] ?? 0,
      floorCount: json['FloorCount'],
      bathroomCount: json['BathroomCount'] ?? 0,
      furnish: json['Furnish'],
      constructionDate: json['ConstructionDate'] ?? '',
      address: json['Address'],
      balconyCount: json['BalconyCount'] ?? 0,
      complexName: json['ComplexName'] ?? '',
    );
  }
}
