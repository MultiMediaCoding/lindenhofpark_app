import 'package:flutter/material.dart';
import 'package:lindenhofpark/Licenses/model/licenses.dart';
import 'package:lindenhofpark/Licenses/view/licenses_item.dart';
import 'package:lindenhofpark/Licenses/view/navigation_title.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/back_button.dart';

class LicensesView extends StatelessWidget {
  const LicensesView({super.key});

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = Color.fromRGBO(221, 223, 216, 1);
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationBackButton(
              color: Color.fromRGBO(59, 105, 57, 1),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, right: 10.0, bottom: 0.0, left: 20.0),
              child: NavigationTitle(title: "Lizenzen"),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(20.0),
                shrinkWrap: false,
                itemCount: licenses.length,
                itemBuilder: (context, index) {
                  final license = licenses[index];
                  return Column(
                    children: [
                      LicensesItem(
                        license: license,
                      ),
                      Divider(
                        height: 0.5,
                      )
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
