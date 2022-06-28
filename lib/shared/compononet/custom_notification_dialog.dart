import 'package:flutter/material.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';

class CustomNotificationDialog extends StatelessWidget {
  String notifiText;
  CustomNotificationDialog({Key? key, required this.notifiText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .35,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  children: [
                    Text(
                      mytranslate(context, "surely"),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      notifiText,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    MaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      color: myAmber,
                      child: Text(
                        mytranslate(context, "okay"),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Positioned(
                top: -60,
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 60,
                  child: Icon(
                    Icons.notifications_active,
                    color: Colors.white,
                    size: 50,
                  ),
                )),
          ],
        ));
  }
}
