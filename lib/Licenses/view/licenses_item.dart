import 'package:flutter/material.dart';
import 'package:lindenhofpark/Licenses/model/License.dart';
import 'package:lindenhofpark/Licenses/view/box_container.dart';
import 'package:lindenhofpark/Licenses/view/license_view.dart';
import 'package:lindenhofpark/resources/resources.dart';

class LicensesItem extends StatelessWidget {
  const LicensesItem({super.key, required this.license});

  final License license;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => LicenseView(license: license))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            BoxContainer(
              icon: FontAwesomeIcon.boxSolid,
              padding: 6,
              borderRadius: 6,
              size: 31,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(license.name,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                  Text(license.type,
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.secondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
