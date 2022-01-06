import 'dart:io';

import 'package:helpy_app/layout/layout.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class image_logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    File? _image = UserCubit.get(context).imagee;
    final cubit=UserCubit.get(context);
    return Container(
      padding:const EdgeInsets.all(8.0),
      decoration:const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.red))),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                  radius: 80,
                  child: _image == null
                      ? Center(
                    child: Text(
                      mytranslate(context, "Noimage"),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                      : CircleAvatar(
                    radius: 80,
                    backgroundImage: FileImage(_image),
                  )),
              Positioned(
                bottom: -15,
                right: -1,
                child: Container(
                  height: 100,
                  decoration:const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle
                  ),
                  child: Center(
                    child: IconButton(
                      icon:const Icon(Icons.add_a_photo_rounded),
                      iconSize: 35,
                      color: Colors.white,
                      onPressed: () {
                        var ad = AlertDialog(
                          title: Text(mytranslate(context, "ChoosePicturefrom"),),
                          content: Container(
                              height: MediaQuery.of(context).size.height*0.38,
                              width: MediaQuery.of(context).size.width*0.70,
                              child: Column(children: [
                                const Divider(color: Colors.black),
                                buildDialogItemLogin(context, mytranslate(context, "Camera"),
                                    Icons.add_a_photo_outlined,
                                    ImageSource.camera),
                                const SizedBox(height: 10),
                                buildDialogItemLogin(context, mytranslate(context, "Gallery"),
                                    Icons.image_outlined,
                                    ImageSource.gallery),
                                const  Spacer(),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius:const BorderRadius.only(
                                      topRight: Radius.circular(60),
                                    ),
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.lightBlue,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child:  TextButton(
                                      style: ButtonStyle(elevation: MaterialStateProperty.all(10.0)),
                                      onPressed: (){
                                        cubit.deleteImageBlocLogin();
                                        Navigator.pop(context);
                                      },
                                      child: Text(mytranslate(context, "RemovePhoto"), style:const TextStyle(color: Colors.white, fontSize: 18),)),
                                ),
                              ])),
                        );
                        showDialog(
                            context: context, builder: (context) => ad);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
