import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:helpy_app/shared/shared_prefernces.dart';

List<String> suaid = const [
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
  "Yanbuʿ"
];

const kDefaultPadding = 20.0;
final RegExp nameRegExp = RegExp('[a-zA-Z]');
String pattern = r'(^(?:[+0]966)?[0-9]{10,12}$)';
RegExp regExp = RegExp(pattern);
//Color(0xFF1D1D35);