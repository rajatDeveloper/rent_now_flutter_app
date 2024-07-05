import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

double getDeviceHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

double getDeviceWidth(BuildContext context) =>
    MediaQuery.of(context).size.width;

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

//do not use this one if app is for web also
double getFontSize(double size, double screenWidth) {
  return size * screenWidth / 414;
}

void setDataToLocal({required String key, required String value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}

Future<String> getSavedDataByKey({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? data = prefs.getString(key);
  return data ?? "";
}

Future<void> removeDataByKey({required String key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
