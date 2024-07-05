import 'package:flutter/material.dart';

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
      body: Center(
        child: Text('Rent Post Page'),
      ),
    );
  }
}
