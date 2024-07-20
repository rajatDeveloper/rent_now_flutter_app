import 'package:flutter/material.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';
import 'package:rent_now/features/rent_post/presentation/pages/rent_post_detail_page.dart';

class RentPostCard extends StatelessWidget {
  final RentPostModel rentPostModel;
  const RentPostCard({super.key, required this.rentPostModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RentPostDetailPage.routeName,
            arguments: rentPostModel);
      },
      child: Card(
        child: Column(
          children: [
            Text(rentPostModel.title),
            Text(rentPostModel.description),
            Text(rentPostModel.rent_request.length.toString()),
          ],
        ),
      ),
    );
  }
}
