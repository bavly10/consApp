import 'package:helpy_app/shared/localization/set_localization.dart';
import 'package:flutter/material.dart';

String mytranslate(BuildContext context,key){
  return SetLocalztion.of(context).getTranslatevalue(key);
}