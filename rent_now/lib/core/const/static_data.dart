import 'package:rent_now/features/auth/data/models/user_model.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';

class StaticData {
  static UserModel? user;
  static List<RentPostModel>? mainScreenList;
  static List<RentPostModel>? searchAbleList;
  static List<CategoryModel>? categoryList;
  static List<AddressModel>? adddressList;
}
