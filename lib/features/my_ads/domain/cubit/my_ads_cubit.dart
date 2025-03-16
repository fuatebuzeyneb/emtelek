import 'package:bloc/bloc.dart';
import 'package:emtelek/core/errors/exceptions.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/features/my_ads/data/repositories/my_ads_repository.dart';
import 'package:emtelek/features/profile/data/models/ads_model.dart';
import 'package:emtelek/shared/models/add-ads-models/ad_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:intl/intl.dart';

import 'package:meta/meta.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  final MyAdsRepository myAdsRepository;
  MyAdsCubit(this.myAdsRepository) : super(MyAdsInitial());

  late int editIndex;

  void setEditIndex({required int index}) {
    editIndex = index;
  }

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

  late AdsModel adsModel = AdsModel(
    token: getIt<CacheHelper>().getDataString(key: 'token')!,
    adId: myAds[editIndex].adId,
    adTitle: myAds[editIndex].adTitle,
    price: myAds[editIndex].price,
    currency: myAds[editIndex].currency,
    description: myAds[editIndex].description,
    location: myAds[editIndex].location,
    publishDate: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    status: 5,
    sellerType: myAds[editIndex].sellerType,
    categoryId: myAds[editIndex].categoryId,
    client: Client(
        clientId: myAds[editIndex].client.clientId,
        firstName: myAds[editIndex].client.firstName,
        lastName: myAds[editIndex].client.lastName,
        phoneNumber: myAds[editIndex].client.phoneNumber,
        email: myAds[editIndex].client.email,
        subscriptionDate: myAds[editIndex].client.subscriptionDate),
    city: myAds[editIndex].city,
    district: myAds[editIndex].district,
    info: Info(
      adId: myAds[editIndex].info.adId,
      totalArea: myAds[editIndex].info.totalArea,
      netOrBuildingArea: myAds[editIndex].info.netOrBuildingArea,
      roomCount: myAds[editIndex].info.roomCount,
      floorNumber: myAds[editIndex].info.floorNumber,
      floorCount: myAds[editIndex].info.floorCount,
      bathroomCount: myAds[editIndex].info.bathroomCount,
      constructionDate: myAds[editIndex].info.constructionDate,
      address: myAds[editIndex].info.address,
      balconyCount: myAds[editIndex].info.balconyCount,
      complexName: myAds[editIndex].info.complexName,
    ),
  );

  // late AdsModel adsModel;
  void updatePropertyField(
    String field,
    dynamic value,
  ) {
    if (field == 'totalArea') {
      adsModel.info.totalArea = value;
    } else if (field == 'netOrBuildingArea') {
      adsModel.info.netOrBuildingArea = value;
    } else if (field == 'roomCount') {
      adsModel.info.roomCount = value;
    } else if (field == 'bathroomCount') {
      adsModel.info.bathroomCount = value;
    } else if (field == 'floorCount') {
      adsModel.info.floorCount = value;
    } else if (field == 'floorNumber') {
      adsModel.info.floorNumber = value;
    } else if (field == 'balconyCount') {
      adsModel.info.balconyCount = value;
    } else if (field == 'constructionDate') {
      adsModel.info.constructionDate = value;
    } else if (field == 'furnished') {
      adsModel.info.furnish = value;
    } else if (field == 'complexName') {
      adsModel.info.complexName = value;
    } else if (field == 'adModelTitle') {
      adsModel.adTitle = value;
    } else if (field == 'adModelPrice') {
      adsModel.price = value;
    } else if (field == 'adModelLocation') {
      adsModel.location = value;
    }
    // else if (field == 'adModelImage') {
    //  adsModel.image = value;
    // }
    else if (field == 'adModelDescription') {
      adsModel.description = value;
    } else if (field == 'adModelPhone') {
      adsModel.client.phoneNumber = value;
    } else if (field == 'adModelCurrency') {
      adsModel.currency = value;
    } else if (field == 'adModelEmail') {
      adsModel.client.email = value;
    } else if (field == 'adModelDistrictId') {
      adsModel.district = value;
    } else if (field == 'adModelClientId') {
      adsModel.client.clientId = value;
    } else if (field == 'adModelSellerType') {
      adsModel.sellerType = value;
    } else if (field == 'adModelCategoryId') {
      adsModel.categoryId = value;
    } else if (field == 'adModelAddress') {
      adsModel.info.address = value;
    }

    emit(MyAdsInitial());
  }

  Future<void> updateAdPropertyFunc() async {
    try {
      emit(PropertyUpdateAdLoading());

      // إنشاء النسخة المعدلة من PropertyAdModel
      final updatedData = await myAdsRepository.updateAdProperty(
        adsModel: adsModel,
      );

      print("🔵 PropertyUpdateAdCubit.updateAdProperty data: $updatedData");

      emit(PropertyUpdateAdSuccess());
    } on ServerException catch (e) {
      emit(PropertyUpdateAdFailure(errorMassage: e.errorModel.errorMessage));
    }
  }
}
