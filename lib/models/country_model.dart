import 'package:hive/hive.dart';

part 'country_model.g.dart';

@HiveType(typeId: 0)
class CountryModel {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? region;

  @HiveField(2)
  String? capital;

  @HiveField(3)
  String? population;

  @HiveField(4)
  String? imgUrl;

  CountryModel({
    this.name,
    this.region,
    this.capital,
    this.population,
    this.imgUrl,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      name: json["name"]["common"] as String,
      region: json["region"] as String,
      capital: json["capital"] != null ? json["capital"][0] as String : null,
      population: json["population"]?.toString(),
      imgUrl: json["flags"]["png"] as String,
    );
  }

  CountryModel copyWith({
    String? name,
    String? region,
    String? capital,
    String? population,
    String? imgUrl,
  }) {
    return CountryModel(
      name: name ?? this.name,
      region: region ?? this.region,
      capital: capital ?? this.capital,
      population: population ?? this.population,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }
}
