import 'package:flutter/material.dart';
import 'package:helpy_app/shared/componotents.dart';

import 'package:hexcolor/hexcolor.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'تعديل البروفايل',
            style: TextStyle(color: HexColor('#C18F3A')),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 102,
                    child: const Center(
                      child: Image(
                        image: AssetImage(
                          'assets/boy-1.png',
                        ),
                        fit: BoxFit.cover,
                        width: 130,
                      ),
                    )),
               const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape:  RoundedRectangleBorder(
                      borderRadius:  BorderRadius.circular(35.0)),
                  color: HexColor('#C18F3A'),
                  onPressed: () {},
                  child: const Text(
                    "تغييرصورة البروفايل",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 2,
                    ),
                  ),
                ),
               const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              right: 10, bottom: 8, top: 8, left: 5),
                          child: Text(
                            'الأسم :',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ProfileTextField(
                          controller: nameController,
                          type: TextInputType.name,
                          hint: 'أحمد علي',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'ادخل اسمك';
                            }
                          },
                          onSubmit: (value) {},
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
                          padding: const EdgeInsets.only(right: 13, left: 15),
                          child: Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[100],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              right: 10, bottom: 8, top: 8, left: 5),
                          child: Text(
                            ' البريد الالكتروني :',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ProfileTextField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          hint: '@AhmedAli@gmail.com',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "ادخل ايميلك";
                            }
                          },
                          onSubmit: (value) {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 13, left: 15),
                          child: Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.grey[100],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              right: 10, bottom: 8, top: 8, left: 5),
                          child: Text(
                            'رقم الجوال  :',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        ProfileTextField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          hint: '5963585462',
                          validate: (value) {
                            if (value!.isEmpty) {
                              return "ادخل رقم الجوال";
                            }
                          },
                          onSubmit: (value) {},
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
