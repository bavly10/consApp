import 'package:flutter/material.dart';
import 'package:helpy_app/shared/compononet/custom_text.dart';
import 'package:helpy_app/shared/my_colors.dart';

class WalletScreenCustomer extends StatelessWidget {
  const WalletScreenCustomer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double customerWallet=0.0;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: CustomText(
              text: 'المحفظة',fontsize: 25,alignment: Alignment.center,color: myAmber,
            ),
          ),
          body: Column(
            children: [
               SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2,
                  child:const Center(
                    child: Image(
                      // height: 200,
                      // width: 50,
                      image: AssetImage('assets/wallet.png',),
                    ),
                  )),
              CustomText(
                text: 'رصيدك الحالي',fontsize: 29,alignment: Alignment.center,color: myAmber,isBold: true,
              ),
              const SizedBox(height: 10,),
              CustomText(
                text: 'صالحة للاستخدام في طلباتك',fontsize: 15,alignment: Alignment.center,color: Colors.black,
              ),
              const SizedBox(height: 40,),
              CustomText(
                text: '$customerWallet  ر.س  ',fontsize: 29,alignment: Alignment.center,color: myAmber,isBold: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
