import 'package:flutter/material.dart';

// Colors
// const kBackgroundColor = Color(OxFFFEFEFE);
// const kTitleTextColor = Color(0xFF303030);
// const kBodyTextColor = Color(0xFF4B4B4B);
// const kTextLightColor = Color(0xFF959595);
// const kInfectedColor = Color(OxFFFF8748);
// const kDeathColor = Color(OxFFFF4848);
// const kRecovercolor = Color(0xFF36C12C);
// const kPrimaryColor = Color(0xFF3382CC);
// final kShadowColor = Color(OxFFB7B7B7).withOpacity(.16);
// final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

const kColors = {
  'lightGreen': Color(0xFFE3F8FA),
  'green': Color(0xFF26C6DA),
  'lightRed': Color(0xFFFFE6E2),
  'red': Color(0xFFFC573B),
  'black1': Color(0xFF1F1F1F)
};
// Text Style
var kFilledStyles = {
  'h1': TextStyle(
    fontSize: 30,
    color: kColors['red'],
    fontWeight: FontWeight.bold,
  ),
  'p': TextStyle(
      fontSize: 16, color: kColors["lightRed"], fontWeight: FontWeight.w500)
};

var kEmptyStyles = {
  'h1': TextStyle(
    fontSize: 30,
    color: kColors['green'],
    fontWeight: FontWeight.bold,
  ),
  'p': TextStyle(
      fontSize: 16, color: kColors["lightGreen"], fontWeight: FontWeight.w500)
};
