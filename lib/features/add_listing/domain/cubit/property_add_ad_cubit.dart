import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/shared/models/add-ads-models/ad_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

part 'property_add_ad_state.dart';

class PropertyAddAdCubit extends Cubit<PropertyAddAdState> {
  PropertyAddAdCubit() : super(PropertyAddAdInitial());

  // 6--> Property for buy
// 5--> Property for rent
  int? categoryForAdType;

  changeCategoryForAdType(int type) {
    categoryForAdType = type;
    emit(PropertyAddAdInitial());
  }

  PropertyAdModel propertyAdModel = PropertyAdModel(
      totalArea: 0,
      netOrBuildingArea: 0,
      romeCount: 0,
      bathroomCount: 0,
      floorCount: 0,
      roomNumber: 0,
      balconyCount: 0,
      constructionDate: '',
      furnished: true,
      complexName: '',
      adModel: AdModel(
        title: '',
        price: 0,
        location: LatLng(0, 0),
        image: '',
        description: '',
        phone: '',
        currency: '',
        email: '',
        districtId: 0,
        clientId: 0,
        sellerType: 0,
        categoryId: 0,
        token: '',
        address: '',
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
    } else if (field == 'roomNumber') {
      propertyAdModel.roomNumber = value;
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

    // emit(PropertyUpdated(propertyAdModel)); // إرسال الحالة الجديدة
  }

  void submitProperty() {
    print('----------------------------------------------');
    print(propertyAdModel);
    print('----------------------------------------------');
  }
}
