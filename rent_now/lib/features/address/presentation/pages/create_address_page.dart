import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rent_now/core/common/widgets/custom_button.dart';
import 'package:rent_now/core/common/widgets/custom_text_field.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/address/presentation/bloc/address_bloc.dart';
import 'package:rent_now/features/rent_post/data/models/address_model.dart';

class CreateAddressPage extends StatefulWidget {
  static const String routeName = '/create-address';
  const CreateAddressPage({super.key});

  @override
  State<CreateAddressPage> createState() => _CreateAddressPageState();
}

class _CreateAddressPageState extends State<CreateAddressPage> {
  AddressModel? inputAddress;

  //       "address": {
  //           "id": 1,
  //           "address": "bal sath colony",
  //           "pin_code": 136027,
  //           "city": "Kaithal",
  //           "state": "Haryana",
  //           "country": "India",
  //           "latitude": 78907.0,
  //           "longitude": 9898.0,
  //           "user": 3
  //       },
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final _addressFocusNode = FocusNode();
  final _pinCodeFocusNode = FocusNode();
  final _cityFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  final _countryFocusNode = FocusNode();

  Future<AddressModel?> getAddressFromLocation() async {
    try {
      await Geolocator.checkPermission();
      await Geolocator.requestPermission();
      // Get the current position with a timeout duration
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 10));

      // Get the address from the position
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      // Concatenate address components into a single string
      AddressModel? addressModel;
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        addressModel = AddressModel(
          id: 0,
          address: placemark.street.toString(),
          pin_code: int.parse(placemark.postalCode.toString()),
          city: placemark.locality.toString(),
          state: placemark.administrativeArea.toString(),
          country: placemark.country.toString(),
          latitude: position.latitude,
          longitude: position.longitude,
          user: StaticData.user!.id,
        );
      }

      //set the conrtroller
      _addressController.text = addressModel!.address;
      _pinCodeController.text = addressModel.pin_code.toString();
      _cityController.text = addressModel.city;
      _stateController.text = addressModel.state;
      _countryController.text = addressModel.country;

      return addressModel;
    } catch (e) {
      // print('Error getting location: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Address Page'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocConsumer<AddressBloc, AddressState>(
                  listener: (context, state) {
                    if (state is AddressError) {
                      showSnackBar(context, state.message);
                    }

                    if (state is AddressCreated) {
                      showSnackBar(context, "Address Created Successfully");
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is AddressLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomElevatedBtn(
                            text: "Get Current Location",
                            prefixIcon: Icons.location_city,
                            onPressed: () async {
                              inputAddress = await getAddressFromLocation();
                              setState(() {});
                            },
                            bgColor: Colors.teal,
                            borderColor: Colors.teal,
                            textColor: Colors.white,
                          ),
                          CustomTextField(
                            textColor: Colors.black,
                            activeTextColor: Colors.blue,
                            backgroundColor: Colors.transparent,
                            borderActiveColor: Colors.blue,
                            controller: _pinCodeController,
                            node: _pinCodeFocusNode,
                            hintText: 'Pin Code',
                            isNum: true,
                            maxLength: 6,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: _cityFocusNode,
                            tapOn: null,
                          ),
                          CustomTextField(
                            textColor: Colors.black,
                            activeTextColor: Colors.blue,
                            backgroundColor: Colors.transparent,
                            borderActiveColor: Colors.blue,
                            controller: _cityController,
                            node: _cityFocusNode,
                            hintText: 'City',
                            isNum: false,
                            maxLength: 50,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: _stateFocusNode,
                            tapOn: null,
                          ),
                          CustomTextField(
                            textColor: Colors.black,
                            activeTextColor: Colors.blue,
                            backgroundColor: Colors.transparent,
                            borderActiveColor: Colors.blue,
                            controller: _stateController,
                            node: _stateFocusNode,
                            hintText: 'State',
                            isNum: false,
                            maxLength: 50,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: _countryFocusNode,
                            tapOn: null,
                          ),
                          CustomTextField(
                            textColor: Colors.black,
                            activeTextColor: Colors.blue,
                            backgroundColor: Colors.transparent,
                            borderActiveColor: Colors.blue,
                            controller: _countryController,
                            node: _countryFocusNode,
                            hintText: 'Country',
                            isNum: false,
                            maxLength: 50,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: null,
                            tapOn: null,
                          ),
                          CustomTextField(
                            maxLines: 3,
                            textColor: Colors.black,
                            activeTextColor: Colors.blue,
                            backgroundColor: Colors.transparent,
                            borderActiveColor: Colors.blue,
                            controller: _addressController,
                            node: _addressFocusNode,
                            hintText: 'Address',
                            isNum: false,
                            maxLength: 100,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: null,
                            tapOn: null,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                CustomElevatedBtn(
                  text: "Create Address",
                  prefixIcon: Icons.location_city,
                  onPressed: () {
                    inputAddress = AddressModel(
                      id: 0,
                      address: _addressController.text,
                      pin_code: int.parse(_pinCodeController.text),
                      city: _cityController.text,
                      state: _stateController.text,
                      country: _countryController.text,
                      latitude: 76876.99,
                      longitude: 97878.99,
                      user: StaticData.user!.id,
                    );

                    context.read<AddressBloc>().add(CreateAddressEvent(
                          inputAddress: inputAddress!,
                          token: StaticData.user!.token,
                        ));

                    print(inputAddress);
                  },
                  bgColor: Colors.teal,
                  borderColor: Colors.teal,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ));
  }
}
