import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class SetLocalztion {
  late Locale locale;
   SetLocalztion(this.locale);

  static SetLocalztion of(BuildContext context) {
    return Localizations.of<SetLocalztion>(context, SetLocalztion)!;
  }

  static const LocalizationsDelegate<SetLocalztion> localizationsDelegate=_GetlocalizationDeleget();

  Map<String,String>? _localvalues;
  Future load() async{
    String jsonStringvalue=await rootBundle.loadString("lib/shared/localization/lang/${locale.languageCode}.json");

    Map<String,dynamic> mapjson=json.decode(jsonStringvalue);
    _localvalues=mapjson.map((key, value) => MapEntry(key, value.toString()));
  }


  String getTranslatevalue(String key){
    return _localvalues![key]!;
  }

}


class _GetlocalizationDeleget extends LocalizationsDelegate<SetLocalztion>{

  const _GetlocalizationDeleget();
  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
   return ['en','ar'].contains(locale.languageCode);
  }

  @override
  Future<SetLocalztion> load(Locale locale) async{

    SetLocalztion setLocalztion=SetLocalztion(locale);
    await setLocalztion.load();
    return setLocalztion;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<SetLocalztion> old) {
    // TODO: implement shouldReload
  return false;
  }

}