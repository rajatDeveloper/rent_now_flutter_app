import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';

class RentPostDetailPage extends StatefulWidget {
  static const routeName = '/rent_post_detail_page';
  final RentPostModel rentPostPage;
  const RentPostDetailPage({super.key, required this.rentPostPage});

  @override
  State<RentPostDetailPage> createState() => _RentPostDetailPageState();
}

class _RentPostDetailPageState extends State<RentPostDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.rentPostPage.title),
      ),
      body: Center(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: widget.rentPostPage.post_image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Text(widget.rentPostPage.title),
            Text(widget.rentPostPage.description),
            Text(widget.rentPostPage.rent_request.length.toString()),
          ],
        ),
      ),
    );
  }
}
