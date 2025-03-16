class AdsModel {
  String token;
  int adId;
  String adTitle;
  double price;
  String currency;
  String description;
  String location;
  String publishDate;
  int status;
  int categoryId;
  int sellerType;
  Client client;
  City city;
  District district;
  Info info;

  AdsModel({
    required this.token,
    required this.adId,
    required this.adTitle,
    required this.price,
    required this.currency,
    required this.description,
    required this.location,
    required this.publishDate,
    required this.status,
    required this.sellerType,
    required this.categoryId,
    required this.client,
    required this.city,
    required this.district,
    required this.info,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      token: json['Token'] ?? '',
      adId: json['AdId'],
      adTitle: json['AdTitle'],
      price: double.parse(json['Price']),
      currency: json['Currency'],
      description: json['Description'],
      location: json['Location'],
      publishDate: json['PublishDate'],
      status: json['Status'],
      sellerType: json['SellerType'],
      categoryId: json['CategoryId'],
      client: Client.fromJson(json['data']['client']),
      city: City.fromJson(json['data']['city']),
      district: District.fromJson(json['data']['district']),
      info: Info.fromJson(json['data']['info']),
    );
  }

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'AdId': adId,
      'AdTitle': adTitle,
      'Price': price,
      'Currency': currency,
      'Description': description,
      'Location': location,
      'PublishDate': publishDate,
      'Status': status,
      'SellerType': sellerType,
      'CategoryId': categoryId,
      'Client': client.toJson(),
      'City': city.toJson(),
      'District': district.toJson(),
      'Info': info.toJson(),
    };
  }
}

class Client {
  int clientId;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String subscriptionDate;

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

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'ClientId': clientId,
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'SubscriptionDate': subscriptionDate,
    };
  }
}

class City {
  int cityId;
  String cityName;

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

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'CityId': cityId,
      'CityName': cityName,
    };
  }
}

class District {
  int districtId;
  int cityId;
  String districtName;

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

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'DistrictId': districtId,
      'CityId': cityId,
      'DistrictName': districtName,
    };
  }
}

class Info {
  int adId;
  int totalArea;
  int netOrBuildingArea;
  int roomCount;
  int floorNumber;
  int? floorCount;
  int bathroomCount;
  dynamic furnish;
  String constructionDate;
  String address;
  int balconyCount;
  String complexName;

  Info({
    required this.adId,
    required this.totalArea,
    required this.netOrBuildingArea,
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
      netOrBuildingArea: json['NetArea'],
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

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      'AdId': adId,
      'TotalArea': totalArea,
      'NetArea': netOrBuildingArea,
      'RoomCount': roomCount,
      'FloorNumber': floorNumber,
      'FloorCount': floorCount,
      'BathroomCount': bathroomCount,
      'Furnish': furnish,
      'ConstructionDate': constructionDate,
      'Address': address,
      'BalconyCount': balconyCount,
      'ComplexName': complexName,
    };
  }
}
