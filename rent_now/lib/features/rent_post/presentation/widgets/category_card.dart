import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/presentation/pages/rent_post_category_post_page.dart';

class CategoryCard extends StatelessWidget {
  final CategoryModel model;
  const CategoryCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getDeviceWidth(context) * 0.3,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, CategoryRentPostPage.routeName,
              arguments: model);
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CachedNetworkImage(
                imageUrl: model.category_image,
                height: getDeviceHeight(context) * 0.15,
                fit: BoxFit.fitHeight,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Text(model.name),
            ],
          ),
        ),
      ),
    );
  }
}
