import 'package:flutter/material.dart';
import 'package:helpy_app/shared/compononet/custom_text.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:hexcolor/hexcolor.dart';

class MyCustomFormState extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String? prepass, newpass, confirmpass;
  var prepassController = TextEditingController();
  var newpassController = TextEditingController();
  var confirmPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: CustomText(text: 'تغيير كلمة السر',alignment: Alignment.center, fontsize: 20,),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                const Center(child:Image(image: AssetImage('assets/pass.png',),fit: BoxFit.contain, width: 150,)),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('يجب أن تكون كلمة مرورك الجديدة مختلفة عن  كلمة مرورك السابقة المستخدمة',
                  style: TextStyle(color: Colors.black, fontSize: 20, letterSpacing: 2),),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 8, top: 8, left: 5),
                      child: Text(
                        'كلمة السر القديمة :',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ProfileTextField(
                      controller: prepassController,
                      type: TextInputType.text,
                      hint: '*********',
                      // isClickable: true,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return '  ادخل كلمة السر القديمة';
                        }
                      },
                      onSubmit: (value) {},
                      onSave: (value) {
                        prepass = value;
                      },
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
                      padding: EdgeInsets.only(right: 10, bottom: 8, top: 8, left: 5),
                      child: Text(
                        ' كلمة السر الجديدة :',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ProfileTextField(
                      controller: newpassController,
                      onSave: (value) {
                        newpass = value;
                      },
                      type: TextInputType.text,
                      hint: '********',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "ادخل كلمة السر الجديدة";
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
                      padding: EdgeInsets.only(right: 10, bottom: 8, top: 8, left: 5),
                      child: Text(
                        ' تأكيد كلمة السر : ',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    ProfileTextField(
                      controller: confirmPassController,
                      type: TextInputType.text,
                      onSave: (value) {
                        confirmpass = value;
                      },
                      hint: '********',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return " ادخل كلمة السرالجديدة";
                        }
                        if (newpassController.text != confirmPassController.text) {
                          return "كلمة السر غير صحيحة";
                        }
                      },
                      onSubmit: (value) {},
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 13, left: 15, bottom: 15),
                      child: Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey[100],
                      ),
                    ),
                    Center(
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:  BorderRadius.circular(35.0)),
                        color: HexColor('#C18F3A'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text(
                          "اعادة تعيين كلمة السر",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
          ),
        ),
      ),
    );
  }
}
