import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rent_now/features/address/presentation/pages/address_page.dart';
import 'package:rent_now/features/address/presentation/pages/create_address_page.dart';
import 'package:rent_now/features/auth/presentation/pages/login_page.dart';
import 'package:rent_now/features/auth/presentation/pages/register_page.dart';
import 'package:rent_now/features/auth/presentation/pages/splash_page.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';
import 'package:rent_now/features/rent_post/presentation/pages/rent_post_category_post_page.dart';
import 'package:rent_now/features/rent_post/presentation/pages/rent_post_detail_page.dart';
import 'package:rent_now/features/rent_post/presentation/pages/rent_post_page.dart';

Map<String, Widget Function(BuildContext)> getAppRoutes() {
  Map<String, Widget Function(BuildContext)> appRoutes = {
    LoginPage.routeName: (context) => const LoginPage(),
    RegisterPage.routeName: (context) => const RegisterPage(),
    SplashPage.routeName: (context) => const SplashPage(),
    RentPostPage.routeName: (context) => const RentPostPage(),
    RentPostDetailPage.routeName: (context) {
      RentPostModel rentPostModel =
          ModalRoute.of(context)!.settings.arguments as RentPostModel;
      return RentPostDetailPage(rentPostPage: rentPostModel);
    },
    CategoryRentPostPage.routeName: (context) {
      CategoryModel categoryModel =
          ModalRoute.of(context)!.settings.arguments as CategoryModel;
      return CategoryRentPostPage(categoryModel: categoryModel);
    },
    AddressPage.routeName: (context) => const AddressPage(),
    CreateAddressPage.routeName: (context) => const CreateAddressPage()
  };

  return appRoutes;
}
