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

class CreateFile extends StatelessWidget {
  CreateFile({Key? key}) : super(key: key);
  var textController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, cons_login_Register_States>(
      listener: (context, state) {
        if (state is UploadUserFileLoadingState) {
          myToast(message: mytranslate(context, "loadfile"));
        } else if (state is UploadUserFileSueeeState) {
          My_CustomAlertDialog(
            pressTitle: mytranslate(context, "done"),
            onPress: () {
              navigateToFinish(context, UserMain());
            },
            content: mytranslate(context, "suessfully"),
            context: context,
            bigTitle: mytranslate(context, "surely"),
            pressColor: myAmber,
          );
        } else if (state is UploadUserFileErrorState) {
          myToast(message: mytranslate(context, "errorpass"));
        } else if (state is DeleteImages_State) {
          myToast(message: mytranslate(context, "delete"));
        }
      },
      builder: (context, state) {
        final result = UserCubit.get(context).result;
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              mytranslate(context, "nfile"),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    UserCubit.get(context).pickFiles(['pdf'], false);
                  },
                  child: Icon(
                    Icons.picture_as_pdf_rounded,
                    color: HexColor('#C18F3A'),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
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
                          mytranslate(context, "pricepdf"),
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
                  Row(
                    children: [
                      Form(
                        key: form,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .50,
                          child: My_TextFormFiled(
                            textInputType: TextInputType.number,
                            validator: (String? s) {
                              if (s!.isEmpty) return "price is required";
                            },
                            controller: textController,
                            myhintText: mytranslate(context, "pricef"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          mytranslate(context, "SR"),
                          style: TextStyle(
                              color: HexColor('#C18F3A'),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (result != null)
                    Stack(
                      // alignment: Alignment,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0, bottom: 20),
                          child: Text(
                            mytranslate(context, "detailsf"),
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#C18F3A')),
                          ),
                        ),
                        // ignore: sized_box_for_whitespace
                        Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * .20,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            mytranslate(context, "filen"),
                                            style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        Text(
                                          result.files.single.name,
                                          style: const TextStyle(
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            mytranslate(context, "filez"),
                                            style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        Text(
                                          '${result.files.single.size} KB',
                                          style: const TextStyle(
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            mytranslate(context, "fileE"),
                                            style: const TextStyle(
                                                color: Colors.blueGrey,
                                                fontWeight: FontWeight.w600,
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                        Text(
                                          result.files.single.extension
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.blueGrey,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 5,
                          child: IconButton(
                              onPressed: () {
                                UserCubit.get(context).deleteImageBlocList();
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: HexColor('#C18F3A'),
                                size: 20,
                              )),
                        ),
                      ],
                    ),
                  Mybutton(
                      context: context,
                      onPress: () {
                        FocusScope.of(context).unfocus();
                        if (form.currentState!.validate()) {
                          if (result != null) {
                            UserCubit.get(context).addFile(
                              textController.text,
                              ConsCubit.get(context).userID.toString(),
                              result.files.first.path,
                              result.files.first.name,
                            );
                          } else {
                            return myToast(
                                message: mytranslate(context, "pdffile"));
                          }
                        }
                      },
                      title: Text(
                        mytranslate(context, "uploadfile"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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
