// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/core/const/keys.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/auth/presentation/pages/splash_page.dart';
import 'package:rent_now/features/rent_post/presentation/bloc/rent_post_bloc.dart';
import 'package:rent_now/features/rent_post/presentation/widgets/category_card.dart';
import 'package:rent_now/features/rent_post/presentation/widgets/main_drawer.dart';
import 'package:rent_now/features/rent_post/presentation/widgets/rent_post_card.dart';

class RentPostPage extends StatefulWidget {
  static const String routeName = '/rentPostPage';
  const RentPostPage({super.key});

  @override
  State<RentPostPage> createState() => _RentPostPageState();
}

class _RentPostPageState extends State<RentPostPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //lunch event of get all rent post and category

    // context.read<RentPostBloc>().add(GetAllCategoriesEvent(
    //       token: StaticData.user!.token,
    //     ));

    context.read<RentPostBloc>().add(GetAllRentPostEvent(
          category: "",
          pin_code: "",
          token: StaticData.user!.token,
        ));
  }

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
        drawer: DrawerMain(),
        body: SafeArea(
          child: BlocConsumer<RentPostBloc, RentPostState>(
            listener: (context, state) {
              if (state is RentPostFailure) {
                showSnackBar(context, state.message);
              }

              if (state is GetAllRentPostSuccess) {
                StaticData.mainScreenList = state.rentPosts;
              }
            },
            builder: (context, state) {
              if (state is GetAllRentPostLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is GetAllRentPostCategorySuccess) {}

              if (state is GetAllRentPostSuccess ||
                  state is GetAllRentPostCategorySuccess) {
                return Column(
                  children: [
                    const Text(
                      "Categories",
                    ),
                    //Horizontal list of categories

                    Container(
                      alignment: Alignment.center,
                      height: getDeviceHeight(context) * 0.2,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: StaticData.categoryList!.length,
                        itemBuilder: (context, index) {
                          var category = StaticData.categoryList![index];
                          return CategoryCard(model: category);
                        },
                      ),
                    ),

                    //Categries list
                    Expanded(
                      child: ListView.builder(
                        itemCount: StaticData.mainScreenList!.length,
                        itemBuilder: (context, index) {
                          var rentPost = StaticData.mainScreenList![index];
                          return RentPostCard(rentPostModel: rentPost);
                        },
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox();
            },
          ),
        )
        //
        );
  }
}
