part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetAccountSettingsLoading extends ProfileState {}

final class GetAccountSettingsSuccess extends ProfileState {}

final class GetAccountSettingsFailure extends ProfileState {
  final String errorMassage;

  GetAccountSettingsFailure({required this.errorMassage});
}

final class GeMyAdsLoading extends ProfileState {}

final class GeMyAdsSuccess extends ProfileState {}

final class GeMyAdsFailure extends ProfileState {
  final String errorMassage;

  GeMyAdsFailure({required this.errorMassage});
}
