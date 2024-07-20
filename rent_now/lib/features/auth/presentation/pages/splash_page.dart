// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rent_now/core/const/keys.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/auth/data/models/user_model.dart';
import 'package:rent_now/features/auth/data/models/user_model.dart';
import 'package:rent_now/features/auth/presentation/pages/login_page.dart';
import 'package:rent_now/features/rent_post/presentation/pages/rent_post_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = '/splashPage';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void checkUserLogedInOrNot() async {
    //1 sec wait
    await Future.delayed(Duration(seconds: 1));
    var localData = await getSavedDataByKey(key: userKey);

    if (localData == "") {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginPage.routeName, (route) => false);
    } else {
      log("Local data: $localData");
      StaticData.user = UserModel.fromJson(localData);
      Navigator.pushNamedAndRemoveUntil(
          context, RentPostPage.routeName, (route) => false);

      // Navigator.pushNamedAndRemoveUntil(
      //     context, RentPostPage.routeName, (route) => false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUserLogedInOrNot();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Page'),
      ),
    );
  }
}
