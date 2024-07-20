import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/presentation/bloc/rent_post_bloc.dart';

class CategoryRentPostPage extends StatefulWidget {
  static const routeName = '/category_rent_post_page';
  final CategoryModel categoryModel;
  const CategoryRentPostPage({super.key, required this.categoryModel});

  @override
  State<CategoryRentPostPage> createState() => _CategoryRentPostPageState();
}

class _CategoryRentPostPageState extends State<CategoryRentPostPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<RentPostBloc>().add(GetAllRentPostOfCategoryEvent(
        category: widget.categoryModel.id.toString(),
        pin_code: "",
        token: StaticData.user!.token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.categoryModel.name),
        ),
        body: BlocConsumer<RentPostBloc, RentPostState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is GetAllRentPostLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is GetAllRentPostCategorySuccess) {
              return ListView.builder(
                itemCount: state.rentPosts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Text(state.rentPosts[index].title),
                        Text(state.rentPosts[index].description),
                        Text(state.rentPosts[index].rent_request.length
                            .toString()),
                      ],
                    ),
                  );
                },
              );
            }

            return SizedBox();
          },
        ));
  }
}
