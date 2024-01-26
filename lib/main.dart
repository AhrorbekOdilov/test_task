import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_task/models/country_model.dart';
import 'package:test_task/providers/provider.dart';
import 'package:test_task/screens/countries_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/services/local_service.dart';

Dio dio = Dio();

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CountryModelAdapter());
  await Hive.openBox<CountryModel>(LocalService.boxName);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyProvider>(
          create: (context) => MyProvider(),
        )
      ],
      child: ScreenUtilInit(
          designSize: const Size(411, 866),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, __) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: const CountriesScreen(),
            );
          }),
    );
  }
}
