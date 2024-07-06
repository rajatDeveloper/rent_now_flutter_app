// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:rent_now/core/const/keys.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/auth/presentation/pages/splash_page.dart';

class RentPostPage extends StatefulWidget {
  static const String routeName = '/rentPostPage';
  const RentPostPage({super.key});

  @override
  State<RentPostPage> createState() => _RentPostPageState();
}

class _RentPostPageState extends State<RentPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rent Post Page'),
        actions: [
          IconButton(
            onPressed: () async {
              await removeDataByKey(key: userKey);
              Navigator.pushNamedAndRemoveUntil(
                  context, SplashPage.routeName, (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: const Center(
        child: Text('Rent Post Page'),
      ),
    );
  }
}
