import 'package:bloc/bloc.dart';
import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/models/my_ads_model.dart';
import 'package:emtelek/features/profile/data/repositories/profile_repository.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/features/add_listing/data/models/property_add_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ClientsResponseModel? accountData;
  List<MyAdsModel> myAds = [];

  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  Future<void> getAccountSettings() async {
    print('----------------------------------');
    emit(GetAccountSettingsLoading());
    try {
      final rawData = await profileRepository.getAccountSettings();

      accountData = rawData;

      emit(GetAccountSettingsSuccess());
    } catch (e) {
      print("Error in ProfileCubit: $e"); // 🔍 Debugging print statement
      emit(GetAccountSettingsFailure(errorMassage: e.toString()));
    }
  }

  Future<void> getMyAds() async {
    print('----------------------------------');
    emit(GetAccountSettingsLoading());
    try {
      final rawData = await profileRepository.getMyAds();

      if (rawData.isEmpty) {
        print("No ads data received");
      }

      myAds = rawData;
      print(myAds.length);
      print(myAds[0].adId); // طباعة ID أول إعلان
      emit(GetAccountSettingsSuccess());
    } catch (e) {
      print("Error in ProfileCubit: $e"); // 🔍 Debugging print statement
      emit(GetAccountSettingsFailure(errorMassage: e.toString()));
    }
  }
}
