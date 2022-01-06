import 'package:flutter/material.dart';
import 'package:helpy_app/modules/customer/taps/profile/edit_profile/edit.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:hexcolor/hexcolor.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 102,
              child: Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    const Image(
                      image: AssetImage('assets/boy-1.png'),
                    ),
                    Positioned(
                      left: 15,
                      child: Container(
                        // alignment: AlignmentDirectional.topStart,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          color: HexColor('#C18F3A'),
                        ),
                        //  alignment: Alignment.topRight,
                        height: 20,
                        width: 20,
                        child: InkWell(
                          onTap: () {},
                          child:const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.mode_edit_rounded,
                              color: Colors.white54,
                              size: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(
            height: 20,
          ),
          Text(
            'أحمد علي',
            style: TextStyle(
                fontSize: 18,
                color: HexColor('#C18F3A'),
                fontWeight: FontWeight.bold,
                wordSpacing: 5,
                letterSpacing: 3),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 15, bottom: 8, top: 5, left: 5),
            child: InkWell(
              onTap: () {
                navigateTo(context, const EditScreen());
              },
              child: Row(
                children: [
                  const Text(
                    'تعديل الملف الشخصي',
                    style: TextStyle(fontSize: 14),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 22,
                        color: HexColor('#C18F3A'),
                      ))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13, left: 15),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 15, bottom: 8, top: 5, left: 5),
            child: Row(
              children: [
                const Text(
                  "تغيير كلمة السر",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 22,
                      color: HexColor('#C18F3A'),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13, left: 15),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 15, bottom: 8, top: 5, left: 5),
            child: Row(
              children: [
                const Text(
                  'الشروط والاحكام',
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 22,
                      color: HexColor('#C18F3A'),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13, left: 15),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 15, bottom: 8, top: 5, left: 5),
            child: Row(
              children: [
                const  Text(
                  "تواصل معنا",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 22,
                      color: HexColor('#C18F3A'),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13, left: 15),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                right: 15, bottom: 8, top: 5, left: 5),
            child: Row(
              children: [
                const Text(
                  "تسجيل الخروج",
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 22,
                      color: HexColor('#C18F3A'),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 13, left: 15),
            child: Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[100],
            ),
          ),
        ],
      )
    );
  }
}
