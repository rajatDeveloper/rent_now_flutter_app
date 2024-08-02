import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/core/common/widgets/custom_button.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/rent_post/presentation/bloc/rent_post_bloc.dart';
import 'package:rent_now/features/rent_post/presentation/pages/create_rent_post_page.dart';
import 'package:rent_now/features/rent_post/presentation/widgets/rent_post_card.dart';

class MyRentPostPage extends StatefulWidget {
  static const String routeName = '/my-rent-post';
  const MyRentPostPage({super.key});

  @override
  State<MyRentPostPage> createState() => _MyRentPostPageState();
}

class _MyRentPostPageState extends State<MyRentPostPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<RentPostBloc>().add(GetMyRentPostEvent(
          userId: StaticData.user!.id.toString(),
          token: StaticData.user!.token,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Rent Post'),
      ),
      body: BlocConsumer<RentPostBloc, RentPostState>(
        listener: (context, state) {
          if (state is RentPostFailure) {
            showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is GetMyRentPostLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is GetMyRentPostSuccess) {
            StaticData.myRentPostList = state.rentPosts;
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return StaticData.myRentPostList != null
              ? Column(
                  children: [
                    Container(
                      height: getDeviceHeight(context) * 0.75,
                      // color: Colors.red,
                      child: ListView.builder(
                        itemCount: StaticData.myRentPostList!.length,
                        itemBuilder: (context, index) {
                          final rentPost = StaticData.myRentPostList![index];
                          return RentPostCard(rentPostModel: rentPost);
                        },
                      ),
                    ),
                    CustomElevatedBtn(
                      text: "Create Rent Post",
                      onPressed: () {
                        Navigator.pushNamed(
                            context, CreateMyRentPostPage.routeName);
                      },
                      bgColor: Colors.teal,
                      borderColor: Colors.teal,
                      textColor: Colors.white,
                    )
                  ],
                )
              : const Center(
                  child: Text("No Rent Post"),
                );
        },
      ),
    );
  }
}
