part of 'property_cubit.dart';

@immutable
sealed class PropertyState {}

final class PropertyInitial extends PropertyState {}

final class PropertyHomeSearchChangerState extends PropertyState {}
