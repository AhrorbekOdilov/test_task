import 'dart:io';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_task/main.dart';
import 'package:test_task/models/country_model.dart';

class LocalService {
  static const boxName = "countries";
  static Box<CountryModel> box = Hive.box<CountryModel>(boxName);

  static Future<void> saveCountry(CountryModel country) async {
    final imgUrl = await saveImage(country.imgUrl);
    await box.put(country.name, country.copyWith(imgUrl: imgUrl));
  }

  static List<CountryModel> getCountries() {
    return box.values.toList();
  }

  static Future<String?> saveImage(String? imgUrl) async {
    if (imgUrl == null) return null;

    try {
      final response = await dio.get(imgUrl,
          options: Options(responseType: ResponseType.bytes));

      final String fileName = imgUrl.hashCode.toString();

      if (response.statusCode == 200) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/$fileName.jpg';

        File imageFile = File(imagePath);
        await imageFile.writeAsBytes(response.data!);

        return imagePath;
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
