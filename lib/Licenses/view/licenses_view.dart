import 'package:flutter/material.dart';
import 'package:lindenhofpark/Licenses/model/licenses.dart';
import 'package:lindenhofpark/Licenses/view/licenses_item.dart';
import 'package:lindenhofpark/Licenses/view/navigation_title.dart';
import 'package:lindenhofpark/Licenses/view/subheadline.dart';

class LicensesView extends StatelessWidget {
  const LicensesView({super.key});

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = Color.fromRGBO(221, 223, 216, 1);
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavigationTitle(title: "Lizenzen"),
            Expanded(
              child: ListView.builder(
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
