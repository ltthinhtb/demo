import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'logger.dart';

class Utils {
  static Future<bool> checkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      logger.d('Internet not connect');
    }
    return false;
  }

  static String parseDateToString(DateTime dateTime, String format,
      {String locale = "Vi_vi"}) {
    String date = "";
    try {
      date = DateFormat(format, locale).format(dateTime);
    } on FormatException catch (e) {
      logger.e(e.toString());
    }
    return date;
  }

  static DateTime convertDateFromString(String strDate){
    return DateTime.parse(strDate);
  }

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();

  static Future pushAndRemoveUtilPage(BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        (Route<dynamic> route) => false);
  }

  static Future pushAndRemoveUtilKeepFirstPage(
      BuildContext context, Widget widget) {
    return Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => widget),
        ModalRoute.withName(Navigator.defaultRouteName));
  }

  static void popToFirst(BuildContext context) {
    return Navigator.of(context)
        .popUntil((Route<dynamic> route) => route.isFirst);
  }

  static void popByTime(BuildContext context, int count, {dynamic result}) {
    for (int i = 0; i < count - 1; i++) Navigator.of(context).pop();

    Navigator.of(context).pop(result);
  }

  static void popUtil(BuildContext context) {
    return Navigator.of(context).popUntil((Route<dynamic> route) => false);
  }

  static void popDialog(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  static Future navigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  static Future rootNavigatePage(BuildContext context, Widget widget) {
    return Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (context) => widget));
  }

  static navigateNextFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static String convertVNtoText(String str) {
    str = str.replaceAll(RegExp(r'[??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???]'), 'a');

    str = str.replaceAll(RegExp(r'[??|??|???|???|???|??|???|???|???|???|???]'), 'e');
    str = str.replaceAll(RegExp(r'[??|??|???|???|??]'), 'i');
    str = str.replaceAll(RegExp(r'[??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???]'), 'o');
    str = str.replaceAll(RegExp(r'[??|??|???|???|??|??|???|???|???|???|???]'), 'u');
    str = str.replaceAll(RegExp(r'[???|??|???|???|???]'), 'y');
    str = str.replaceAll(RegExp(r'[??]'), 'd');

    str = str.replaceAll(RegExp(r'[??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???]'), 'A');
    str = str.replaceAll(RegExp(r'[??|??|???|???|???|??|???|???|???|???|???]'), 'E');
    str = str.replaceAll(RegExp(r'[??|??|???|???|??]'), 'I');
    str = str.replaceAll(RegExp(r'[??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???]'), 'O');
    str = str.replaceAll(RegExp(r'[??|??|???|???|??|??|???|???|???|???|???]'), 'U');
    str = str.replaceAll(RegExp(r'[???|??|???|???|???]'), 'Y');
    str = str.replaceAll(RegExp(r'[??]'), 'D');
    return str;
  }
}
