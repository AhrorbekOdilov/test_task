import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_task/core/constatnts.dart';
import 'package:test_task/providers/provider.dart';
import 'package:test_task/widgets/comntry_widget.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  bool searching = false;
  Timer? timer;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    context.read<MyProvider>().init();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MyProvider>();

    return PopScope(
      onPopInvoked: (didPop) {
        setState(() {
          searching = false;
          controller.text = '';
          provider.searchCountry("");
        });
      },
      canPop: !searching,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              padding: const EdgeInsets.only(right: defaultPadding),
              onPressed: () {
                setState(() {
                  searching = true;
                });
              },
              icon: const Icon(Icons.search),
            )
          ],
          title: searching
              ? TextFormField(
                  controller: controller,
                  autofocus: true,
                  onChanged: (value) {
                    if (timer != null) {
                      timer?.cancel();
                    }
                    timer = Timer.periodic(const Duration(milliseconds: 1300),
                        (timer) {
                      timer.cancel();
                      provider
                          .searchCountry(controller.text.trim().toLowerCase());
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: "Davlat nomini kiriting",
                  ),
                )
              : const SizedBox(),
        ),
        body: provider.requestSended
            ? const Center(child: CircularProgressIndicator())
            : provider.countries.isNotEmpty
                ? Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    height: 1.sh,
                    width: 1.sw,
                    child: ListView.builder(
                      itemBuilder: (context, index) =>
                          CountryWidget(country: provider.countries[index]),
                      itemCount: provider.countries.length,
                    ),
                  )
                : Center(
                    child: Text(
                      "Ma'lumot topilmadi",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
      ),
    );
  }
}
