import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/core/common/widgets/custom_button.dart';
import 'package:rent_now/core/common/widgets/custom_text_field.dart';

import 'package:rent_now/core/const/colors.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/rent_request/presentation/bloc/rent_request_type_bloc.dart';

class CreaterentRequestPage extends StatefulWidget {
  static const String routeName = '/create_rent_request';
  const CreaterentRequestPage({super.key});

  @override
  State<CreaterentRequestPage> createState() => _CreaterentRequestPageState();
}

class _CreaterentRequestPageState extends State<CreaterentRequestPage> {
  // "one_day", "One Day"
  // "one_week", "One Week"
  // "one_month", "One Month"
  // "one_year", "One Year"
  // "direct_buy", "Direct Buy"

  List<Map<String, String>> rentRequestTypes = [
    {"one_day": "One Day"},
    {"one_week": "One Week"},
    {"one_month": "One Month"},
    {"one_year": "One Year"},
    {"direct_buy": "Direct Buy"}
  ];

  double pricePerDuration = 0.0;
  String rentRequestType = "one_day";

  TextEditingController _pricePerDurationController = TextEditingController();

  //fouse node
  FocusNode _pricePerDurationFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Rent Request'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<RentRequestTypeBloc, RentRequestTypeState>(
            listener: (context, state) {
              if (state is RentRequestTypeError) {
                showSnackBar(context, state.message);
              }

              if (state is RentRequestTypeLoaded) {
                setState(() {});
                Navigator.pop(context);
                StaticData.rentRequestList.add(state.rentRequestModel);
                showSnackBar(context, "Rent Request Type Created Successfully");
                //get its state to initai
              }
            },
            builder: (context, state) {
              if (state is RentRequestTypeLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return Column(
                children: [
                  Container(
                    height: getDeviceHeight(context) * 0.75,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              labelText: "Rent Request Type",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            value: rentRequestType,
                            onChanged: (String? value) {
                              setState(() {
                                rentRequestType = value!;
                                log(rentRequestType);
                              });
                            },
                            items: rentRequestTypes
                                .map((e) => DropdownMenuItem<String>(
                                      value: e.keys.first,
                                      child: Text(e.values.first),
                                    ))
                                .toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            textColor: Colors.black,
                            activeTextColor: Colors.blue,
                            backgroundColor: Colors.transparent,
                            borderActiveColor: Colors.blue,
                            controller: _pricePerDurationController,
                            node: _pricePerDurationFocusNode,
                            hintText: 'Price Per Rent Duration',
                            isNum: true,
                            maxLength: 50,
                            isPassword: false,
                            autofillHints: null,
                            nextNode: null,
                            tapOn: null,
                          ),
                        ],
                      ),
                    ),
                  ),
                  CustomElevatedBtn(
                      text: "Create Rent Request Type",
                      onPressed: () {
                        context.read<RentRequestTypeBloc>().add(
                            RentRequestTypeCreateEvent(
                                token: StaticData.user!.token,
                                rentRequestType: rentRequestType,
                                pricePerDuration: double.parse(
                                    _pricePerDurationController.text)));
                      },
                      bgColor: AppColors.primaryColor,
                      borderColor: Colors.transparent,
                      textColor: AppColors.whiteColor)
                ],
              );
            },
          ),
        ));
  }
}
