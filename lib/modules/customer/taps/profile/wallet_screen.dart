import 'package:flutter/material.dart';
import 'package:helpy_app/model/customer_model.dart';
import 'package:helpy_app/shared/compononet/custom_clip_slider.dart';
import 'package:helpy_app/shared/compononet/custom_text.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';

class WalletScreenCustomer extends StatelessWidget {
  CustomerModel? model;
  WalletScreenCustomer({Key? key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: myAmber,
          appBar: AppBar(
            title: CustomText(
              text: mytranslate(context, "wallet"),
              fontsize: 25,
              alignment: Alignment.center,
              color: myAmber,
            ),
          ),
          body: Column(
            children: [
              ClipPath(
                clipper: TsClip1(),
                child: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height * .40,
                  width: MediaQuery.of(context).size.width,
                  child: const Image(
                    //color: Colors.transparent,
                    image: AssetImage(
                      'assets/wallet.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomText(
                  text: mytranslate(context, "current"),
                  fontsize: 29,
                  alignment: Alignment.center,
                  color: Colors.white,
                  isBold: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomText(
                text: mytranslate(context, "valid"),
                fontsize: 18,
                alignment: Alignment.center,
                color: Colors.white,
              ),
              const SizedBox(
                height: 40,
              ),
              CustomText(
                fontsize: 29,
                text: model?.walletPoint != 0.0
                    ? model!.walletPoint.toString() +
                        "  " +
                        mytranslate(context, "SR")
                    : "0.0  " + mytranslate(context, "SR"),
                alignment: Alignment.center,
                color: Colors.blueGrey[700],
                isBold: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
