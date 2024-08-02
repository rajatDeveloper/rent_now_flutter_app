import 'package:flutter/material.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';

class AddressDetailPage extends StatelessWidget {
  static const String routeName = '/addressDetailPage';
  final AddressModel addressModel;
  const AddressDetailPage({super.key, required this.addressModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Detail Page'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Address: ${addressModel.address}'),
            Text('City: ${addressModel.city}'),
            Text('Country: ${addressModel.country}'),
            Text('Postal Code: ${addressModel.pin_code}'),
            Text('State: ${addressModel.state}'),
          ],
        ),
      ),
    );
  }
}
