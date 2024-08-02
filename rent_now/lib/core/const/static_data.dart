import 'package:rent_now/features/auth/data/models/user_model.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';
import 'package:rent_now/features/rent_post/data/models/rent_request_model.dart';

class StaticData {
  static UserModel? user;
  static List<RentPostModel>? mainScreenList;
  static List<RentPostModel>? searchAbleList;
  static List<CategoryModel>? categoryList;
  static List<AddressModel>? adddressList;
  static List<RentPostModel>? myRentPostList;
  static List<RentPostModel>? catListData;

  // rent quest list when we create new rent post

  static List<RentRequestModel> rentRequestList = [];
}
