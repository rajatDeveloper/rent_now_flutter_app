import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rent_now/features/address/domain/usecases/create_user_address.dart';
import 'package:rent_now/features/address/domain/usecases/get_all_address.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAllAddress _getAllAddress;
  final CreateUserAddress _createAddress;
  AddressBloc({
    required GetAllAddress getAllAddress,
    required CreateUserAddress createAddress,
  })  : _getAllAddress = getAllAddress,
        _createAddress = createAddress,
        super(
          AddressInitial(),
        ) {
    on<AddressEvent>((event, emit) {
      // Nothing to do on this state
    });

    on<CreateAddressEvent>(
      (event, emit) async {
        await _onCreateAddress(event, emit);
      },
    );

    on<GetAllAddressEvent>(
      (event, emit) async {
        await _onGetAllAddress(event, emit);
      },
    );
  }

  //create address

  _onCreateAddress(CreateAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    final res = await _createAddress(
      CreateUserAddressParams(
        inputAddress: event.inputAddress,
        token: event.token,
      ),
    );
    res.fold(
      (failure) => emit(AddressError(message: failure.message)),
      (address) => emit(AddressCreated(addressModel: address)),
    );
  }

  //get all address

  _onGetAllAddress(GetAllAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddressLoading());
    final res = await _getAllAddress(
      GetAllAddressParms(
        userId: event.userId,
        token: event.token,
      ),
    );
    res.fold(
      (failure) => emit(AddressError(message: failure.message)),
      (addressList) => emit(AddressLoaded(addressList: addressList)),
    );
  }
}
