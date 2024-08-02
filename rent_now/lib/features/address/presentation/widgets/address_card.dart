import 'package:flutter/material.dart';
import 'package:rent_now/features/address/presentation/pages/address_detail_page.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';

class AddressCard extends StatelessWidget {
  final AddressModel addressModel;
  const AddressCard({super.key, required this.addressModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AddressDetailPage.routeName,
            arguments: addressModel);
      },
      child: Card(
        child: ListTile(
          title: Text(addressModel.address),
          subtitle: Text(addressModel.city),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}