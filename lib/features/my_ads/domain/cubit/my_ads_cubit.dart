import 'package:bloc/bloc.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/features/my_ads/data/repositories/my_ads_repository.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/models/add-ads-models/ad_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

import 'package:meta/meta.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  final MyAdsRepository myAdsRepository;
  MyAdsCubit(this.myAdsRepository) : super(MyAdsInitial());

  List<AdsModel> myAds = [];

  Future<void> getMyAds() async {
    print('----------------------------------');
    emit(GetMyAdsLoading());
    try {
      final rawData = await myAdsRepository.getMyAds();

      if (rawData.isEmpty) {
        print("No ads data received");
      }

      myAds = rawData;
      print(myAds.length);
      print(myAds[0].adId); // طباعة ID أول إعلان
      emit(GetMyAdsSuccess());
    } catch (e) {
      print("Error in ProfileCubit: $e"); // 🔍 Debugging print statement
      emit(GetMyAdsFailure(errorMassage: e.toString()));
    }
  }

// AdsModel propertyAdModel ;

//   void setPropertyField(String field, dynamic value) {
//     if (field == 'totalArea') {
//       propertyAdModel.totalArea = value;
//     } else if (field == 'netOrBuildingArea') {
//       propertyAdModel.netOrBuildingArea = value;
//     } else if (field == 'roomCount') {
//       propertyAdModel.roomCount = value;
//     } else if (field == 'bathroomCount') {
//       propertyAdModel.bathroomCount = value;
//     } else if (field == 'floorCount') {
//       propertyAdModel.floorCount = value;
//     } else if (field == 'floorNumber') {
//       propertyAdModel.floorNumber = value;
//     } else if (field == 'balconyCount') {
//       propertyAdModel.balconyCount = value;
//     } else if (field == 'constructionDate') {
//       propertyAdModel.constructionDate = value;
//     } else if (field == 'furnished') {
//       propertyAdModel.furnished = value;
//     } else if (field == 'complexName') {
//       propertyAdModel.complexName = value;
//     } else if (field == 'adModelTitle') {
//       propertyAdModel.adModel.title = value;
//     } else if (field == 'adModelPrice') {
//       propertyAdModel.adModel.price = value;
//     } else if (field == 'adModelLocation') {
//       propertyAdModel.adModel.location = value;
//     } else if (field == 'adModelImage') {
//       propertyAdModel.adModel.image = value;
//     } else if (field == 'adModelDescription') {
//       propertyAdModel.adModel.description = value;
//     } else if (field == 'adModelPhone') {
//       propertyAdModel.adModel.phone = value;
//     } else if (field == 'adModelCurrency') {
//       propertyAdModel.adModel.currency = value;
//     } else if (field == 'adModelEmail') {
//       propertyAdModel.adModel.email = value;
//     } else if (field == 'adModelDistrictId') {
//       propertyAdModel.adModel.districtId = value;
//     } else if (field == 'adModelClientId') {
//       propertyAdModel.adModel.clientId = value;
//     } else if (field == 'adModelSellerType') {
//       propertyAdModel.adModel.sellerType = value;
//     } else if (field == 'adModelCategoryId') {
//       propertyAdModel.adModel.categoryId = value;
//     } else if (field == 'adModelAddress') {
//       propertyAdModel.adModel.address = value;
//     } else if (field == 'adModelToken') {
//       propertyAdModel.adModel.token = value;
//     }

//     emit(MyAdsInitial());
//   }
}
