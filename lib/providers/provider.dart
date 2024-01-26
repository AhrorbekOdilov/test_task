import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_task/main.dart';
import 'package:test_task/models/country_model.dart';
import 'package:test_task/services/local_service.dart';

class MyProvider extends ChangeNotifier {
  List<CountryModel> countries = [];
  bool requestSended = false;

  void init() {
    Future.delayed(Duration.zero, () {
      countries = LocalService.getCountries();
      if (countries.isEmpty) {
        getCountries();
      }
      notifyListeners();
    });
  }

  Future<void> getCountries() async {
    requestSended = true;
    notifyListeners();
    try {
      Response res = await dio.get("https://restcountries.com/v3.1/all");

      if (res.statusCode == 200) {
        res.data.forEach((countryJson) {
          final CountryModel countryModel = CountryModel.fromJson(countryJson);
          saveCounrty(countryModel);
        });
        requestSended = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveCounrty(CountryModel countryModel) async {
    await LocalService.saveCountry(countryModel);
    countries = LocalService.getCountries();
    notifyListeners();
  }

  void searchCountry(String text) {
    if (text.trim().isEmpty) {
      countries = LocalService.getCountries();
    } else {
      countries = LocalService.getCountries().where((country) {
        return country.name == null
            ? false
            : country.name!.toLowerCase().startsWith(text);
      }).toList();
    }

    notifyListeners();
  }
}
