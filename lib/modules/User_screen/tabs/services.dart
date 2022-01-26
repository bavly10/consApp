import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/modules/User_screen/slide_dialog.dart';
import 'package:helpy_app/shared/error_compon.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:slide_popup_dialog_null_safety/slide_popup_dialog.dart' as slideDialog;

class ServicesIntro extends StatefulWidget {
  final UserStrapi cubit;
   ServicesIntro(this.cubit);

  @override
  State<ServicesIntro> createState() => _ServicesIntroState();
}

class _ServicesIntroState extends State<ServicesIntro> {
  File? f;

  @override
  Widget build(BuildContext context) {
    return widget.cubit.filesIntros!.isEmpty
        ? noPostFound(context)
        : ListView(
      children: widget.cubit.filesIntros!.map((e) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: TextButton(onPressed: (){
                  cons_Cubit.get(context).getMyShared();
                  final myfile=base_api+e.fileIntro!.url!;
                  if(cons_Cubit.get(context).customerToken==null) {
                    slideDialog.showSlideDialog(
                        pillColor: myAmber,
                        backgroundColor:Colors.white,
                        context: context,
                        child: MySlideDialog(e.fileName!,mytranslate(context, "download")));
                  }else{
                    ///payment method
                    downloadFile(myfile,e.fileName!);
                  }

                }, child: Row(
                  children: [
                    Text(e.fileName!,style:const TextStyle(color: Colors.black87),),
                    const Spacer(),
                    const Icon(Icons.picture_as_pdf_rounded,size: 45,color: Colors.black87),
                  ],
                )),
              ),
            ],
          ),
        );
      }).toList(),
      physics: const BouncingScrollPhysics(),
    );
  }

    Future<void> downloadFile(String url, String fileName) async {
      var dio =  Dio();
      var dir = await getExternalStorageDirectory();
      var downloadDir = await io.Directory(dir!.path).create(recursive: true);
      io.File('${downloadDir.path}/$fileName').exists().then((a) async {
          print("Downloading file");
          print(downloadDir.path);
          await dio.download(url, '${downloadDir.path}/$fileName.pdf').then((value) => {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            backgroundColor: myAmber,
            content: Text("Your File in Files/Storage/Android/data/files/$fileName.pdf'"),
          )),
            print("Download completed")
          });
      });
    }
}
