import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/shared/models/add-ads-models/ad_model.dart';
import 'package:emtelek/shared/models/district-model/district_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'property_add_ad_state.dart';

class PropertyAddAdCubit extends Cubit<PropertyAddAdState> {
  PropertyAddAdCubit() : super(PropertyAddAdInitial());

  // 6--> Property for buy
// 5--> Property for rent
  int? categoryForAdType;

  void changeCategoryForAdType(int type) {
    categoryForAdType = type;
    emit(PropertyAddAdInitial());
  }

  //just for testing
  List<XFile> imagesProperty = [];

  void addAllImages(List<XFile> image) {
    imagesProperty.clear();
    imagesProperty.addAll(image);
    emit(PropertyAddAdInitial());
  }

  PropertyAdModel propertyAdModel = PropertyAdModel(
      totalArea: null,
      netOrBuildingArea: null,
      romeCount: null,
      bathroomCount: null,
      floorCount: null,
      floorNumber: null,
      balconyCount: null,
      constructionDate: null,
      furnished: null,
      complexName: null,
      adModel: AdModel(
        title: null,
        price: null,
        location: null,
        image: null,
        description: null,
        phone: null,
        currency: null,
        email: null,
        districtId: null,
        clientId: 0,
        sellerType: null,
        categoryId: null,
        token: '',
        address: null,
      ));

  void setPropertyField(String field, dynamic value) {
    if (field == 'totalArea') {
      propertyAdModel.totalArea = value;
    } else if (field == 'netOrBuildingArea') {
      propertyAdModel.netOrBuildingArea = value;
    } else if (field == 'romeCount') {
      propertyAdModel.romeCount = value;
    } else if (field == 'bathroomCount') {
      propertyAdModel.bathroomCount = value;
    } else if (field == 'floorCount') {
      propertyAdModel.floorCount = value;
    } else if (field == 'floorNumber') {
      propertyAdModel.floorNumber = value;
    } else if (field == 'balconyCount') {
      propertyAdModel.balconyCount = value;
    } else if (field == 'constructionDate') {
      propertyAdModel.constructionDate = value;
    } else if (field == 'furnished') {
      propertyAdModel.furnished = value;
    } else if (field == 'complexName') {
      propertyAdModel.complexName = value;
    } else if (field == 'adModelTitle') {
      propertyAdModel.adModel.title = value;
    } else if (field == 'adModelPrice') {
      propertyAdModel.adModel.price = value;
    } else if (field == 'adModelLocation') {
      propertyAdModel.adModel.location = value;
    } else if (field == 'adModelImage') {
      propertyAdModel.adModel.image = value;
    } else if (field == 'adModelDescription') {
      propertyAdModel.adModel.description = value;
    } else if (field == 'adModelPhone') {
      propertyAdModel.adModel.phone = value;
    } else if (field == 'adModelCurrency') {
      propertyAdModel.adModel.currency = value;
    } else if (field == 'adModelEmail') {
      propertyAdModel.adModel.email = value;
    } else if (field == 'adModelDistrictId') {
      propertyAdModel.adModel.districtId = value;
    } else if (field == 'adModelClientId') {
      propertyAdModel.adModel.clientId = value;
    } else if (field == 'adModelSellerType') {
      propertyAdModel.adModel.sellerType = value;
    } else if (field == 'adModelCategoryId') {
      propertyAdModel.adModel.categoryId = value;
    } else if (field == 'adModelAddress') {
      propertyAdModel.adModel.address = value;
    } else if (field == 'adModelToken') {
      propertyAdModel.adModel.token = value;
    }

    emit(PropertyAddAdInitial());
  }

  void submitProperty() {
    print('----------------------------------------------');
    print(propertyAdModel);
    print('----------------------------------------------');
  }
}
