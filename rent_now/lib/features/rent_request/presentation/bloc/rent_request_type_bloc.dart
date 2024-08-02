import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/features/rent_post/data/models/rent_request_model.dart';
import 'package:rent_now/features/rent_request/domain/usecases/create_rent_request_type.dart';

part 'rent_request_type_event.dart';
part 'rent_request_type_state.dart';

class RentRequestTypeBloc
    extends Bloc<RentRequestTypeEvent, RentRequestTypeState> {
  final CreateRentRequestType _createRentRequestType;

  RentRequestTypeBloc(CreateRentRequestType create_rent_request_type)
      : _createRentRequestType = create_rent_request_type,
        super(RentRequestTypeInitial()) {
    on<RentRequestTypeEvent>((event, emit) {
      //nothing to do
    });

    on<RentRequestTypeCreateEvent>((event, emit) async {
      await _onCreateRentRequestType(event, emit);
    });
  }

  Future<void> _onCreateRentRequestType(RentRequestTypeCreateEvent event,
      Emitter<RentRequestTypeState> emit) async {
    emit(RentRequestTypeLoading());
    final res = await _createRentRequestType(CreateRentRequestTypeParams(
      token: event.token,
      rentRequestType: event.rentRequestType,
      pricePerDuration: event.pricePerDuration,
    ));

    res.fold(
      (failure) => emit(RentRequestTypeError(failure.message)),
      (rentRequestModel) => emit(RentRequestTypeLoaded(rentRequestModel)),
    );
  }
}
