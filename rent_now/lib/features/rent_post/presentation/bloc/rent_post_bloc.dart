import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/features/rent_post/data/models/category_model.dart';
import 'package:rent_now/features/rent_post/data/models/rent_post_model.dart';
import 'package:rent_now/features/rent_post/domain/usecases/get_all_categories.dart';
import 'package:rent_now/features/rent_post/domain/usecases/get_all_rent_post.dart';
import 'package:rent_now/features/rent_post/domain/usecases/get_my_rent_post.dart';

part 'rent_post_event.dart';
part 'rent_post_state.dart';

class RentPostBloc extends Bloc<RentPostEvent, RentPostState> {
  final GetAllRentPost _getAllRentPost;
  final GetAllCategories _getAllCategories;
  final GetMyRentPost _getMyRentPost;

  RentPostBloc({
    required GetMyRentPost getMyRentPost,
    required GetAllRentPost getAllRentPost,
    required GetAllCategories getAllCategories,
  })  : _getAllRentPost = getAllRentPost,
        _getMyRentPost = getMyRentPost,
        _getAllCategories = getAllCategories,
        super(RentPostInitial()) {
    on<RentPostEvent>((event, emit) {
      // Nothing to do on this state
    });

    on<GetAllRentPostEvent>((event, emit) async {
      await _onGetAllRentPost(event, emit);
    });

    on<GetAllRentPostOfCategoryEvent>((event, emit) async {
      await _onGetAllRentPostCategory(event, emit);
    });

    on<GetMyRentPostEvent>((event, emit) async {
      await _onGetMyRentPost(event, emit);
    });
  }

  Future<void> _onGetMyRentPost(
      GetMyRentPostEvent event, Emitter<RentPostState> emit) async {
    //lodding state
    emit(GetMyRentPostLoading());

    final res = await _getMyRentPost(GetMyRentPostParams(
      token: event.token,
      userId: event.userId,
    ));

    res.fold(
      (failure) => emit(RentPostFailure(message: failure.message)),
      (rentPosts) => emit(GetMyRentPostSuccess(rentPosts: rentPosts)),
    );
  }

  Future<void> _onGetAllRentPostCategory(
      GetAllRentPostOfCategoryEvent event, Emitter<RentPostState> emit) async {
    //lodding state
    emit(GetAllRentPostLoading());

    if (StaticData.categoryList == null) {
      final res2 = await _getAllCategories(GetAllCategoriesParams(
        token: event.token,
      ));

      res2.fold((failure) => emit(RentPostFailure(message: failure.message)),
          (catList) {
        StaticData.categoryList = catList;
      });
    }

    final res = await _getAllRentPost(GetAllRentPostParams(
      category: event.category,
      pin_code: event.pin_code,
      token: event.token,
    ));

    res.fold(
      (failure) => emit(RentPostFailure(message: failure.message)),
      (rentPosts) => emit(GetAllRentPostCategorySuccess(rentPosts: rentPosts)),
    );
  }

  Future<void> _onGetAllRentPost(
      GetAllRentPostEvent event, Emitter<RentPostState> emit) async {
    //lodding state
    emit(GetAllRentPostLoading());

    if (StaticData.categoryList == null) {
      final res2 = await _getAllCategories(GetAllCategoriesParams(
        token: event.token,
      ));

      res2.fold((failure) => emit(RentPostFailure(message: failure.message)),
          (catList) {
        StaticData.categoryList = catList;
      });
    }

    final res = await _getAllRentPost(GetAllRentPostParams(
      category: event.category,
      pin_code: event.pin_code,
      token: event.token,
    ));

    res.fold(
      (failure) => emit(RentPostFailure(message: failure.message)),
      (rentPosts) => emit(GetAllRentPostSuccess(rentPosts: rentPosts)),
    );
  }
}
