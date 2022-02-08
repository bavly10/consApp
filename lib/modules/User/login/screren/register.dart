import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:helpy_app/Cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/cubit.dart';
import 'package:helpy_app/modules/User/cubit/states.dart';
import 'package:helpy_app/modules/User/login/main_login.dart';
import 'package:helpy_app/modules/MainScreen/main_screen.dart';
import 'package:helpy_app/layout/layout.dart';
import 'package:helpy_app/model/categories_model.dart';
import 'package:helpy_app/model/specailsts_model.dart';

import 'package:helpy_app/shared/componotents.dart';
import 'package:helpy_app/shared/localization/translate.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpy_app/shared/my_colors.dart';
import 'package:helpy_app/shared/strings.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Register_intro extends StatefulWidget {
  final String email;

  const Register_intro(this.email);

  @override
  State<Register_intro> createState() => _Register_introState();
}

class _Register_introState extends State<Register_intro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> form = GlobalKey();
  late String images;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    aboutController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    aboutController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = UserCubit.get(context);
    final listCateg = cons_Cubit.get(context).mycat;
    final listSpec = cons_Cubit.get(context).myspec.where((element) => element.catTitle.title == cubit.catSelect);
    return BlocConsumer<UserCubit, cons_login_Register_States>(
      listener: (ctx, state) {
        /// success
        if (state is cons_Register_Scusess) {
          My_CustomAlertDialog(
            bigTitle: mytranslate(context, "dialogRegistertitle"),
            content: mytranslate(context, "dialogRegister"),
            context: context,
            pressTitle:mytranslate(context, "done"),
            pressColor:myAmber,
            icon: MdiIcons.checkCircleOutline,
            pressText: () {
              navigateToFinish(context, Mainscreen());
            },);
        }
        /// lw error fe viladte nfso
        else if (state is cons_Login_Error) {
          state.loginModel.message!
              .map((e) => e.messages!.map((e) =>  myToast(message: e.message!)
              .toString()));
        }

        ///lw fe error mn database
        else if (state is cons_Registerr_Error) {
          myToast(message: "Can't Connect Please Try again later");
        }

        /// format exception e7tyAty
        else if (state is cons_Register_final_Error) {
          myToast(message: "Try again Later");
        }

        ///lw kol 7aga tmm bs mfe4 net 3nd el user
        else if (state is cons_Register_finaly_Error) {
          myToast(message: "Check Your internet");
        }
      },
      builder: (ctx, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              mytranslate(context, "Register"),
              style: TextStyle(color: myAmber, fontWeight: FontWeight.bold),
            ),
          ),
          body: SingleChildScrollView(
           physics: const BouncingScrollPhysics(),
            child:  Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: form,
                child: Column(
                  children: [
                    Image(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: double.infinity,
                      image:const ExactAssetImage("assets/logo.png"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      mytranslate(context, "registerText"),
                      style:const TextStyle(height: 1.4, fontSize: 16),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 4,
                          child: Text(
                            mytranslate(context, "registerText2"),
                            style:const TextStyle(height: 1.4, fontSize: 13),
                          ),
                        ),
                        Flexible(
                          flex:4,
                          child: Text(widget.email,style: TextStyle(color: myAmber,
                              fontSize: 12 ,
                              fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    textForm(context),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButton(
                      hint: cubit.mycity == null
                          ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${mytranslate(context, "city")} '
                            ,style: TextStyle(color: myAmber,fontWeight: FontWeight.bold)),
                      )
                          : Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(cubit.mycity!, style: TextStyle(color: myAmber, fontSize:14, fontWeight: FontWeight.bold)),
                      ),
                      underline:const SizedBox(),
                      icon: Icon(Icons.keyboard_arrow_down_sharp, color: myAmber, size: 35,),
                      items: suaid.map<DropdownMenuItem<String>>((spec) => DropdownMenuItem(
                        value: spec,
                        child: Text(spec),
                      ))
                          .toList(),
                      onChanged: (val) {
                        cubit.changeSelectCity(val);
                      },
                    ),
                    My_TextFormFiled(
                      validator:(String? s){if(s!.isEmpty)return  "Address is required";},
                      maxLines: 3,
                      controller: addressController,
                      myhintText: mytranslate(context, "adress"),
                    ),
                    My_TextFormFiled(
                      validator:(String? s){if(s!.isEmpty)return  "About is required";},
                      maxLines:5,
                      controller: aboutController,
                      myhintText: mytranslate(context, "aboutus"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    typeService(context),

                    cons_Cubit.get(context).mycat.isEmpty
                        ?const Text("No internet Connetcion")
                        : SizedBox(
                      width: double.infinity,
                      child: Card(
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            DropdownButton(
                              isExpanded: true,
                              underline: SizedBox(),
                              elevation: 2,
                              hint: cubit.catSelect == null
                                  ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  mytranslate(context, "service"),style: TextStyle(color: myAmber,fontWeight: FontWeight.bold),
                                ),
                              )
                                  : Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(cubit.catSelect!,
                                    style: TextStyle(
                                        color: myBlodblue,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                              icon: Icon(Icons.keyboard_arrow_down_sharp,
                                color:myAmber,
                                size: 35,
                              ),
                              items: listCateg.map<DropdownMenuItem<Categories>>((cat) => DropdownMenuItem(value: cat, child: Center(child: Text(cat.title),),)).toList(),
                              onChanged: (val) {
                                cubit.changeSelectCategory(val);
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            DropdownButton(
                              isExpanded: true,
                              hint: cubit.specSelect == null
                                  ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('${mytranslate(context, "spec")} ',style: TextStyle(color: myAmber,fontWeight: FontWeight.bold)),
                              )
                                  : Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(cubit.specSelect!, style: TextStyle(color: myAmber, fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                              underline:const SizedBox(),
                              icon: Icon(Icons.keyboard_arrow_down_sharp, color: myAmber, size: 35,),
                              items: listSpec.map<DropdownMenuItem<Specailsts>>((spec) => DropdownMenuItem(
                                value: spec,
                                child: Text(spec.specTitle),
                              ))
                                  .toList(),
                              onChanged: (val) {
                                cubit.changeSelectSpec(val);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: ElevatedButton(
                                child: Text(mytranslate(context, "Uploadimage"), style:const TextStyle(color: Colors.white)),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  CustomAlertDialogButtons(onTapPdf: (){
                                    cubit.pickFiles(['pdf'],true);
                                    cubit.changeMedia(false);Navigator.of(context).pop();
                                  },onTapImages: (){
                                    cubit.pickFiles(['png', 'jpg'],true);
                                    cubit.changeMedia(true);
                                    Navigator.pop(context);
                                  },context: context,
                                      pdf: "PDF",
                                      images: "Images",
                                      onTapDelete: (){
                                        if(cubit.result==null) {
                                          myToast(message:"Not Selected");

                                        }else{
                                          cubit.deleteImageBlocList();
                                          Navigator.pop(context);
                                        }
                                      });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(myAmber)),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if(cubit.result!=null) Column(
                              children: [
                                CarouselSlider(
                                    carouselController: CarouselControllerImpl(),
                                    items: cubit.result!.files.map((e) => Column(
                                      children: [
                                        FadeInImage(
                                            height: MediaQuery.of(context).size.height * 0.23,
                                            width: double.infinity,
                                            placeholder:const ExactAssetImage("assets/logo.png"),
                                            imageErrorBuilder: (context, object, stacktrace) {
                                              return const Icon(Icons.picture_as_pdf, size: 130,);
                                            },
                                            image: FileImage(File(e.path!))),
                                        Text(e.name, style:const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ))
                                        .toList(),
                                    options: CarouselOptions(
                                        enableInfiniteScroll:
                                        true,
                                        viewportFraction: 1.0,
                                        onPageChanged:
                                            (int i, _) {},
                                        autoPlayInterval:
                                        const Duration(seconds: 4),
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        initialPage: 0,
                                        scrollDirection:
                                        Axis.horizontal)),
                                const  SizedBox(
                                  height: 1,
                                ),
                                Text(
                                    "${cubit.myimagecount} ${mytranslate(context, "list_image")}")
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Mybutton(
                          color: myAmber,
                          context: context,
                          onPress: () async {
                            FocusScope.of(context).unfocus();
                            if (form.currentState!.validate()) {
                              if (cubit.result != null) {
                                try{
                                  for (var element in cubit.result!.files) {
                                    images = element.path!;
                                    print(element.path);
                                    await cubit.register(
                                        address: addressController.text,
                                        email: widget.email,
                                        username: nameController.text,
                                        password: passwordController.text,
                                        phone: phoneController.text,
                                        about: aboutController.text,
                                        listImages: images);
                                  }
                                }on FirebaseException catch (e) {
                                  var emesage = "Error In Signup";
                                  if (e.code == 'email-already-in-use') {
                                    emesage = ('The account already exists for that email.');
                                  }
                                  My_CustomAlertDialog(
                                    bigTitle: "MyCompany",
                                    content: emesage,
                                    context: context,
                                    pressTitle:mytranslate(context, "done"),
                                    pressColor:myAmber,
                                    icon: MdiIcons.alert,
                                    pressText: () {
                                      Navigator.pop(context);
                                    },);
                                }
                                catch(e){
                                  print(e);
                                }
                              } else {
                                myToast(message:"Please Complete All Fields");
                              }
                            }
                          },
                          title: state is cons_Loading_Register
                              ? const SpinKitCircle(
                            color: Colors.white,
                          )
                              : Text(
                            mytranslate(context, "Register"),
                            style:const TextStyle(
                                color: Colors.white, fontSize: 18),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          navigateTo(context, Main_login());
                        },
                        child: Text(
                          mytranslate(context, "Back"),
                          style: TextStyle(fontSize: 14, color: mymainColor),
                        )),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget typeService(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
              flex: 3,
              child: myRadioButton(
                  context, mytranslate(context, "Company"), false)),
          Flexible(
              flex: 4,
              child: myRadioButton(
                  context, mytranslate(context, "Freelancer"), true)),
        ],
      );

  Widget textForm(context) => Column(
        children: [
          My_TextFormFiled(
            validator:(String? s){if(s!.isEmpty)return  "name is required";},
            controller: nameController,
              myhintText: mytranslate(context, "name"),
      ),
          const SizedBox(
            height: 15,
          ),
          const  SizedBox(
            height: 15,
          ),
          My_PasswordFormFiled(
            suffix: cons_Cubit.get(context).iconVisiblity,
            suffixPressed: () {
              cons_Cubit.get(context).changPasswordVisibilty();
            },
            isPassword: cons_Cubit.get(context).isPassword,
            validator: (String? s) {
              if (s!.isEmpty) {
                return "Password is required";
              } else if (s.length < 6) {
                return "Too Short Number";
              } else {
                return null;
              }
            },
            controller: passwordController,
            myhintText: mytranslate(context, "Password"),
          ),
          const  SizedBox(
            height: 15,
          ),
          My_TextFormFiled(
            textInputType: TextInputType.number,
            validator:(String? s){
              if(s!.isEmpty) {
                return  "Number is required";
              }
              else if (s.length < 9) {
                return "Too Short Number";
              } else if (!s.startsWith("05")&&!s.startsWith("966")) {
                return "invalid Mobile Number";
              } else {return null;}
              },
            controller: phoneController,
            myhintText: mytranslate(context, "phone"),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );

}
