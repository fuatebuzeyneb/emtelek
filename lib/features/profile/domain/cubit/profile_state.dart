part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class AccountSettingsLoading extends ProfileState {}

final class AccountSettingsSuccess extends ProfileState {}

final class AccountSettingsFailure extends ProfileState {
  final String errorMassage;

  AccountSettingsFailure({required this.errorMassage});
}
