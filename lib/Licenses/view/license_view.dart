import 'package:flutter/material.dart';
import 'package:lindenhofpark/Licenses/model/License.dart';
import 'package:lindenhofpark/Licenses/view/link_button.dart';
import 'package:lindenhofpark/Licenses/view/box_container.dart';
import 'package:lindenhofpark/Licenses/view/navigation_title.dart';
import 'package:lindenhofpark/Licenses/view/subheadline.dart';
import 'package:lindenhofpark/PlaceDetails/common/view/back_button.dart';
import 'package:lindenhofpark/resources/resources.dart';

class LicenseView extends StatelessWidget {
  const LicenseView({super.key, required this.license});
  final License license;

  @override
  Widget build(BuildContext context) {
    final _backgroundColor = Color.fromRGBO(221, 223, 216, 1);
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  NavigationBackButton(
                    color: Color.fromRGBO(59, 105, 57, 1),
                  ),
                  Spacer(),
                  LinkButton(url: license.source)
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    NavigationTitle(title: license.name),
                    Subheadline(subheadline: license.type),
                    SizedBox(height: 40),
                    Center(
                      child: BoxContainer(
                        icon: FontAwesomeIcon.boxSolid,
                        padding: 10,
                        size: 60,
                        borderRadius: 15,
                        color: Color.fromRGBO(59, 105, 57, 1),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(license.licenseName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    Text(
                      license.licenseText,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
