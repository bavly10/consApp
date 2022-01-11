import 'package:flutter/material.dart';
import 'package:helpy_app/modules/User/profile/Widgets/edit_user_password/edit.dart';
import 'package:helpy_app/modules/User/profile/Widgets/user_rate/user_rate_screen.dart';
import 'package:helpy_app/modules/User/profile/Widgets/wallet/wallet_screen.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:hexcolor/hexcolor.dart';



class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('البروفايل' ,
              style:  TextStyle(fontWeight: FontWeight.bold, fontSize:15 , color: HexColor('#C18F3A'),), textAlign: TextAlign.center,
            ),
                ),
                // SizedBox(height: 20,),

                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child:const Center(
                      child: Image(
                        // height: 200,
                        // width: 50,
                        image: AssetImage('assets/cccc.png'),
                      ),
                    )),
                // const SizedBox(
                //   height: 20,
                // ),
                Text(
                  'شركةرؤيةالمعمارية',
                  style: TextStyle(
                      fontSize: 18,
                      color: HexColor('#C18F3A'),
                      fontWeight: FontWeight.bold,
                      wordSpacing: 5,
                      letterSpacing: 3),
                ),
                const SizedBox(
                  height: 20,
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
                  child: InkWell(
                      onTap: (){
                navigateTo(context, MyCustomFormState());
                },
                    child: Row(
                      children: [
                        const Text(
                          "تغيير كلمة السر",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
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
                  child: InkWell(
                    onTap: (){
                      navigateTo(context, WalletScreen());
                    },
                    child: Row(
                      children: [
                        const Text(
                          "المحفظة",
                          style: TextStyle(fontSize: 14),
                        ),
                        const  Spacer(),
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
                  child: InkWell(
                    onTap: (){
                      navigateTo(context,const UserRateScreen());
                    },
                    child: Row(
                      children: [
                        const Text(
                          "تقييمات العملاء",
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
                      const Text(
                        "تواصل معنا",
                        style: TextStyle(fontSize: 14),
                      ),
                      const  Spacer(),
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
                        "تسجيل الخروج",
                        style: TextStyle(fontSize: 14),
                      ),
                      const  Spacer(),
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
            ),
          ),
        ),
      ),
    );
  }
}
