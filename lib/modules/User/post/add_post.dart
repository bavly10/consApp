import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User/main.dart';
import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class CreatePost extends StatelessWidget {
  var textController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();
  CreatePost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, cons_login_Register_States>(
      listener: (context, state) {
        if (state is ConsAddPostUserSucessState) {
          My_CustomAlertDialog(
            pressTitle: mytranslate(context, "done"),
            onPress: () {
              navigateToFinish(context, UserMain());
            },
            content: mytranslate(context, "postdone"),
            context: context,
            bigTitle: mytranslate(context, "surely"),
            pressColor: myAmber,
          );

          //  myToast(message: mytranslate(context, "postdone"));
        } else if (state is ConsAddPostUserErrorState) {
          myToast(message: mytranslate(context, "postfailed"));
        }
      },
      builder: (context, state) {
        final image = UserCubit.get(context).image1;
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              mytranslate(context, "npost"),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    UserCubit.get(context)
                        .getImageBloc(ImageSource.gallery, image);
                  },
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    color: HexColor('#C18F3A'),
                  ),
                ),
              ),
            ],
          ),
          body: Form(
            key: form,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      children: [
                        Text(
                          mytranslate(context, "detail"),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.grey[700]),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey[400],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                    maxLines: 8,
                    validator: (String? s) {
                      if (s!.isEmpty) return "Post is required";
                    },
                    controller: textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: HexColor('#F7F7F7'),
                      hintText: mytranslate(context, "decribe"),
                      hintStyle: const TextStyle(fontSize: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  )),
                  //  if (SocialCubit.get(context).postImage != null)
                  if (image != null)
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit
                                        .cover, //borderRadius: BorderRadius.circular(4)
                                    image: FileImage(image)),
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          IconButton(
                              onPressed: () {
                                UserCubit.get(context).deleteImageBlocLogin();
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: HexColor('#C18F3A'),
                                size: 20,
                              )),
                        ],
                      ),
                    ),
                  Mybutton(
                      context: context,
                      onPress: () {
                        if (form.currentState!.validate()) {
                          UserCubit.get(context).AddPost(
                              textController.text,
                              DateTime.now().toString(),
                              ConsCubit.get(context).userID);
                        }
                      },
                      title: Text(
                        mytranslate(context, "posts"),
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      color: HexColor('#C18F3A'))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
