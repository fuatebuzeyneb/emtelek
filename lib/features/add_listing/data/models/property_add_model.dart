import 'package:emtelek/shared/models/add-ads-models/ad_model.dart';

class PropertyAdModel {
  AdModel adModel;
  double? totalArea;
  double? netOrBuildingArea;
  int? romeCount;
  int? bathroomCount;
  int? floorCount;
  int? floorNumber;
  int? balconyCount;
  DateTime? constructionDate;
  bool? furnished; //If we add to the land, this means that it contains trees
  String? complexName;

  PropertyAdModel({
    required this.adModel,
    required this.totalArea,
    this.netOrBuildingArea,
    this.romeCount,
    this.bathroomCount,
    this.floorCount,
    this.floorNumber,
    this.balconyCount,
    this.constructionDate,
    this.furnished = false,
    this.complexName,
  });

  factory PropertyAdModel.fromJson(Map<String, dynamic> json) {
    return PropertyAdModel(
      adModel: AdModel.fromJson(json),
      totalArea: json["totalArea"],
      netOrBuildingArea: json["netOrBuildingArea"],
      romeCount: json["romeCount"],
      bathroomCount: json["bathroomCount"],
      floorCount: json["floorCount"],
      floorNumber: json["floorNumber"],
      balconyCount: json["balconyCount"],
      constructionDate: json["constructionDate"],
      furnished: json["furnished"],
      complexName: json["complexName"],
    );
  }

  Map<String, dynamic> toJson() => {
        ...adModel.toJson(),
        "totalArea": totalArea,
        "netOrBuildingArea": netOrBuildingArea,
        "romeCount": romeCount,
        "bathroomCount": bathroomCount,
        "floorCount": floorCount,
        "floorNumber": floorNumber,
        "balconyCount": balconyCount,
        "constructionDate": constructionDate,
        "furnished": furnished,
        "complexName": complexName,
      };

  @override
  String toString() {
    return 'PropertyAdModel('
        'adModel: $adModel, '
        'totalArea: $totalArea, '
        'netOrBuildingArea: $netOrBuildingArea, '
        'romeCount: $romeCount, '
        'bathroomCount: $bathroomCount, '
        'floorCount: $floorCount, '
        'floorNumber: $floorNumber, '
        'balconyCount: $balconyCount, '
        'constructionDate: $constructionDate, '
        'furnished: $furnished, '
        'complexName: $complexName)';
  }
}
