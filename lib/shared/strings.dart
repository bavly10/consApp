import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';

List<String> suaid=const [
  "Abhā",
  "Abqaiq",
  "Al-Baḥah",
  "Al-Dammām",
  "Al-Hufūf",
  "Al-Jawf",
  "Al-Kharj (oasis)",
  "Al-Khubar",
  "Al-Qaṭīf",
  "Al-Ṭaʾif",
  "Buraydah",
  "Dhahran",
  "Ḥāʾil",
  "Jiddah",
  "Jīzān",
  "Khamīs Mushayt",
  "King Khalīd Military City",
  "Mecca",
  "Medina",
  "Najrān",
  "Ras Tanura",
  "Riyadh",
  " Sakākā",
  "Tabūk",
  "Yanbuʿ"];

const kDefaultPadding = 20.0;
String? customerToken = CashHelper.getData("cust_token");
String? customerID = CashHelper.getData("cust_id");
String? userToken = CashHelper.getData("userToken");
int? userID = CashHelper.getData("userId");
//Color(0xFF1D1D35);