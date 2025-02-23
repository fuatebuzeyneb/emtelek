import 'package:bloc/bloc.dart';
import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/features/profile/data/repositories/profile_repository.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;

  ClientsResponseModel? accountData;

  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  Future<void> getAccountSettings() async {
    print('----------------------------------');
    emit(AccountSettingsLoading());
    try {
      final rawData = await profileRepository.getAccountSettings();
      //   print("Raw Data: $rawData"); // 🔍 Debugging print statement
      accountData = rawData;
      // print("Parsed Data: $accountData"); // 🔍 Debugging print statement
      emit(AccountSettingsSuccess());
    } catch (e) {
      print("Error in ProfileCubit: $e"); // 🔍 Debugging print statement
      emit(AccountSettingsFailure(errorMassage: e.toString()));
    }
  }
}
