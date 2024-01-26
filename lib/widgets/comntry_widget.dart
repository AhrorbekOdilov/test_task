import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task/core/constatnts.dart';
import 'package:test_task/models/country_model.dart';

class CountryWidget extends StatefulWidget {
  final CountryModel country;

  const CountryWidget({
    super.key,
    required this.country,
  });

  @override
  State<CountryWidget> createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        myButtomSheet();
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        widget.country.name ?? "",
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: widget.country.imgUrl != null
          ? Image.file(
              File(widget.country.imgUrl!),
              height: 30,
              width: 30,
            )
          : const SizedBox(
              height: 30,
              width: 30,
            ),
    );
  }

  Future<void> myButtomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(defaultPadding),
        height: 200,
        width: 1.sw,
        child: Column(
          children: [
            if (widget.country.name != null)
              Text(
                widget.country.name!,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            infoText("Joylashuv:", widget.country.region),
            infoText("Poytaxti:", widget.country.capital),
            infoText("Aholi soni:", widget.country.population),
            // infoText("Joylashuv:", widget.country.region),
          ],
        ),
      ),
    );
  }

  Widget infoText(String? desc, String? value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (value != null) ...[
          Text(
            desc!,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer(),
        ]
      ],
    );
  }
}
