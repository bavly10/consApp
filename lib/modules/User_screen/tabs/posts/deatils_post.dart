import 'package:flutter/material.dart';
import 'package:helpy_app/model/user_model.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/network.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
class DetailsPost extends StatelessWidget {
  final String? content,publishedAt,url,username;
  final Img_user? img_user;
  const DetailsPost(this.content,this.publishedAt,this.img_user,this.url,this.username, {Key? key}) : super(key: key) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mytranslate(context, "post_details")),
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(12.0),
          child:Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5,right: 12, left: 4),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(url!),
                      radius: 40
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                   Text(username!,style: TextStyle(color: myAmber,fontWeight: FontWeight.bold,fontSize: 22),
                  ),
                  Align(alignment: Alignment.topRight, child:Text(publishedAt!, style:const TextStyle(color: Colors.grey),)),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("$content", style:const TextStyle(fontSize: 18,),textDirection: TextDirection.rtl,),
                  ),
                ],
              ),
            ),),
          ),
      ),
    );
  }
}
