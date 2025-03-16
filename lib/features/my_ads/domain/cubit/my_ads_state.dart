part of 'my_ads_cubit.dart';

@immutable
sealed class MyAdsState {}

final class MyAdsInitial extends MyAdsState {}

final class GetMyAdsLoading extends MyAdsState {}

final class GetMyAdsSuccess extends MyAdsState {}

final class GetMyAdsFailure extends MyAdsState {
  final String errorMassage;

  GetMyAdsFailure({required this.errorMassage});
}
