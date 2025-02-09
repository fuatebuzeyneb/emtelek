import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';
import 'package:emtelek/shared/services/shared_preferences_funs.dart';
import 'package:emtelek/shared/models/city-model/city_model.dart';
import 'package:emtelek/shared/models/district-model/district_model.dart';
import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());

  //---------------------------------------language---------------------------

  String locale = getIt<CacheHelper>().getDataString(key: 'Lang') ?? 'ar';

  void selectLanguageFunction({required String value}) {
    locale = value;
    saveLanguage(value);

    emit(SettingsInitial());
  }

  //---------------------------------------CurrencyConversion---------------------------

//SYP --> Syrian
//USD --> American
//TRL --> Turkish
  String currencyCode =
      getIt<CacheHelper>().getDataString(key: 'currencyCode') ?? 'SYP';

  void selectCurrencyCodeFunction({required String value}) {
    currencyCode = value;
    saveCurrencyCode(value);

    emit(SettingsInitial());
  }

  String convertCurrencySymbol(String input) {
    if (locale == 'ar') {
      switch (input.toUpperCase()) {
        case 'SYP':
          return 'ل.س';
        case 'TRL':
          return 'ل.ت';
        case 'USD':
          return 'دولار';
        default:
      }
    }
    return input; // يعيد النص الأصلي إذا لم تكن العملة موجودة في القائمة
  }
  //---------------------------------------cities---------------------------

  List<CityModel> globalCities = [];
  Box<CityModel>? citiesBox;

  List<DistrictModel> globalDistricts = [];
  Box<DistrictModel>? districtsBox;
  Dio dio = Dio();
  String apiUrl = "https://emtelek.com/api";
  String basicAuth =
      'Basic ${base64Encode(utf8.encode('IIdJEQKxY!CBKnybLaTGqq?2dOZasq95Iqhyh2e6KClkcR3tOb5ewNyXftV-Pawo:QRpmsnr4ma//DwKvNic=uqyix1!9IjwJMWUUTM3rA01zgN1jHrU-N9pY818!kG0o'))}';
  Future<void> openBox() async {
    citiesBox = await Hive.openBox<CityModel>('cityBox');
    districtsBox = await Hive.openBox<DistrictModel>('districtBox');
    if (citiesBox!.isNotEmpty) {
      globalCities = citiesBox!.values.toList();
      emit(CityLoaded());
    } else {
      await fetchCitiesFromApi();
      globalCities = citiesBox!.values.toList();
    }
    if (districtsBox!.isNotEmpty) {
      globalDistricts = districtsBox!.values.toList();
      emit(CityLoaded());
    } else {
      await fetchDistrictFromApi();
      globalDistricts = districtsBox!.values.toList();
    }
  }

  Future<void> fetchCitiesFromApi() async {
    try {
      emit(CityLoading());

      List<dynamic> citiesData = await getCityDataFromApi();

      for (var city in citiesData) {
        if (city.containsKey('CityId') && city.containsKey('CityName')) {
          citiesBox!.add(
              CityModel(cityId: city['CityId'], cityName: city['CityName']));
        }
      }

      emit(CityLoaded());
    } catch (e) {
      emit(CityError('Failed to load cities'));
    }
  }

  Future<List<dynamic>> getCityDataFromApi() async {
    try {
      Response response = await dio.get(
        '$apiUrl/cities',
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['data'] is Map) {
          Map<String, dynamic> cities = response.data['data'];
          List<dynamic> citiesList = [];

          cities.forEach((key, value) {
            citiesList.add(value);
          });

          return citiesList;
        } else {
          throw Exception('Data format is not correct');
        }
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  //---------------------------------------districts---------------------------

  Future<void> fetchDistrictFromApi() async {
    try {
      emit(CityLoading());

      List<dynamic> districtsData = await getDistrictDataFromApi();

      for (var district in districtsData) {
        if (district.containsKey('CityId') &&
            district.containsKey('DistrictId') &&
            district.containsKey('DistrictName')) {
          districtsBox!.add(DistrictModel(
              cityId: district['CityId'],
              districtId: district['DistrictId'],
              districtName: district['DistrictName']));
        }
      }

      emit(CityLoaded());
    } catch (e) {
      emit(CityError('Failed to load districts'));
    }
  }

  Future<List<dynamic>> getDistrictDataFromApi() async {
    try {
      Response response = await dio.get(
        '$apiUrl/districts',
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['data'] is Map) {
          // استخراج البيانات من الخريطة
          Map<String, dynamic> districts = response.data['data'];

          // تحويل الخريطة إلى قائمة
          List<dynamic> districtsList = [];
          districts.forEach((key, value) {
            districtsList.add(value);
          });

          return districtsList;
        } else {
          throw Exception('Data format is not correct');
        }
      } else {
        throw Exception('Failed to load cities');
      }
    } catch (e) {
      print('error: $e');
      return [];
    }
  }

//this function will return the districts of the selected city
  int? cityId;
  List<DistrictModel> filteredDistricts = [];
  void selectCityId(int id) {
    cityId = id;

    emit(SettingsInitial());
  }
}
