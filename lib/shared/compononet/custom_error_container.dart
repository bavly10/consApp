import 'package:flutter/material.dart';
import 'package:helpy_app/shared/localization/translate.dart';

class CustomErrorContainer extends StatelessWidget {
  const CustomErrorContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Image(image: AssetImage("assets/444.jpg")),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              mytranslate(context, "nomoreData"),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
