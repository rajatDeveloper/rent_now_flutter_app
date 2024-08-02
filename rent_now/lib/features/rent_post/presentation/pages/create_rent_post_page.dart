import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_now/core/common/widgets/cam_file_widget.dart';
import 'package:rent_now/core/common/widgets/custom_button.dart';
import 'package:rent_now/core/common/widgets/custom_text_field.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/address/presentation/bloc/address_bloc.dart';
import 'package:rent_now/features/address/presentation/pages/create_address_page.dart';
import 'package:rent_now/features/rent_request/presentation/bloc/rent_request_type_bloc.dart';
import 'package:rent_now/features/rent_request/presentation/pages/create_rent_request_page.dart';

class CreateMyRentPostPage extends StatefulWidget {
  static const routeName = '/create_my_rent_post_page';
  const CreateMyRentPostPage({super.key});

  @override
  State<CreateMyRentPostPage> createState() => _CreateMyRentPostPageState();
}

class _CreateMyRentPostPageState extends State<CreateMyRentPostPage> {
  //            "title": "xx",
  // "description": "xxx",
  // "post_image": null,
  // "whatsapp_number": "",
  // "phone_number": "",
  // "term_and_condition": "",
  // "category": null,
  // "address": null,
  // "rent_request": [
  // ]

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _whatsappNumberController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _termAndConditionController =
      TextEditingController();
  String addressId = StaticData.adddressList != null
      ? StaticData.adddressList![0].id.toString()
      : "";
  String categoryId = StaticData.categoryList != null
      ? StaticData.categoryList![0].id.toString()
      : "";
  List<int> rentRequestIds = [];

  //foucs node
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _whatsappNumberFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _termAndConditionFocusNode = FocusNode();

  int selectedCategoryIndex = 0;
  File? imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AddressBloc>().add(GetAllAddressEvent(
        userId: StaticData.user!.id.toString(), token: StaticData.user!.token));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create My Rent Post'),
        ),
        body: Column(
          children: [
            Container(
              height: getDeviceHeight(context) * 0.75,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //            "title": "xx",
                      // "description": "xxx",
                      // "post_image": null,
                      // "whatsapp_number": "",
                      // "phone_number": "",
                      // "term_and_condition": "",
                      // "category": null,
                      // "address": null,
                      // "rent_request": [
                      // ]

                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        textColor: Colors.black,
                        activeTextColor: Colors.blue,
                        backgroundColor: Colors.transparent,
                        borderActiveColor: Colors.blue,
                        controller: _titleController,
                        node: _titleFocusNode,
                        hintText: 'Title',
                        isNum: false,
                        maxLength: 50,
                        isPassword: false,
                        autofillHints: null,
                        nextNode: _descriptionFocusNode,
                        tapOn: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        textColor: Colors.black,
                        activeTextColor: Colors.blue,
                        backgroundColor: Colors.transparent,
                        borderActiveColor: Colors.blue,
                        controller: _descriptionController,
                        node: _descriptionFocusNode,
                        hintText: 'Description',
                        isNum: false,
                        maxLength: 50,
                        isPassword: false,
                        autofillHints: null,
                        nextNode: _whatsappNumberFocusNode,
                        tapOn: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Select Category",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize:
                                getFontSize(16.5, getDeviceWidth(context)),
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 130,
                        width: getDeviceWidth(context),
                        child: ListView.builder(
                          itemCount: StaticData.categoryList!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var category = StaticData.categoryList![index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategoryIndex = index;
                                  addressId = category.id.toString();
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: getDeviceWidth(context) * 0.35,
                                    margin: const EdgeInsets.all(8),
                                    // padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color:
                                                index == selectedCategoryIndex
                                                    ? Colors.teal
                                                    : Colors.black,
                                            width: 4),
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: category.category_image,
                                        width: getDeviceWidth(context) * 0.35,
                                        height: 80,
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    category.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: getFontSize(
                                            16.5, getDeviceWidth(context)),
                                        color: index == selectedCategoryIndex
                                            ? Colors.teal
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        textColor: Colors.black,
                        activeTextColor: Colors.blue,
                        backgroundColor: Colors.transparent,
                        borderActiveColor: Colors.blue,
                        controller: _whatsappNumberController,
                        node: _whatsappNumberFocusNode,
                        hintText: 'Whatsapp Number',
                        isNum: false,
                        maxLength: 50,
                        isPassword: false,
                        autofillHints: null,
                        nextNode: _phoneNumberFocusNode,
                        tapOn: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //Address
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select Address",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    getFontSize(16.5, getDeviceWidth(context)),
                                color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CreateAddressPage.routeName);
                            },
                            child: Text(
                              "Add New Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: getFontSize(
                                      16.5, getDeviceWidth(context)),
                                  color: Colors.teal),
                            ),
                          ),
                        ],
                      ),

                      BlocBuilder<AddressBloc, AddressState>(
                        builder: (context, addressState) {
                          if (addressState is AddressLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (addressState is AddressLoaded) {
                            return SizedBox(
                              height: 120,
                              width: getDeviceWidth(context),
                              child: ListView.builder(
                                itemCount: addressState.addressList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var address = addressState.addressList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        addressId = address.id.toString();
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: getDeviceWidth(context) * 0.4,
                                      height: 100,
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: addressId ==
                                                      address.id.toString()
                                                  ? Colors.teal
                                                  : Colors.black,
                                              width: 4),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            address.address,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: getFontSize(12,
                                                    getDeviceWidth(context)),
                                                color: Colors.black),
                                          ),
                                          Text(
                                            address.city,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: getFontSize(12,
                                                    getDeviceWidth(context)),
                                                color: Colors.black),
                                          ),
                                          Text(
                                            address.state,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: getFontSize(12,
                                                    getDeviceWidth(context)),
                                                color: Colors.black),
                                          ),
                                          Text(
                                            address.pin_code.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: getFontSize(12,
                                                    getDeviceWidth(context)),
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          if (addressState is AddressCreated) {
                            context.read<AddressBloc>().add(GetAllAddressEvent(
                                userId: StaticData.user!.id.toString(),
                                token: StaticData.user!.token));
                          }

                          return const SizedBox(
                            child: Text("Error"),
                          );
                        },
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      //Add Image
                      Text(
                        "Add Image",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize:
                                getFontSize(16.5, getDeviceWidth(context)),
                            color: Colors.black),
                      ),

                      imageFile == null
                          ? CustomElevatedBtn(
                              text: "Add Image",
                              onPressed: () {
                                // print("Working");
                                camAndFile(
                                    context: context,
                                    galleryOnTap: () async {
                                      imageFile = await pickImageAndReturnImg(
                                          imageType: ImageSource.gallery);
                                      setState(() {});
                                    },
                                    cameraOnTap: () async {
                                      imageFile = await pickImageAndReturnImg(
                                          imageType: ImageSource.camera);
                                      setState(() {});
                                    });
                              },
                              bgColor: Colors.teal,
                              borderColor: Colors.teal,
                              textColor: Colors.white,
                            )
                          : Container(
                              height: 250,
                              width: getDeviceWidth(context),
                              child: Column(
                                children: [
                                  Image.file(
                                    imageFile!,
                                    height: 200,
                                    fit: BoxFit.fitHeight,
                                  ),
                                  CustomElevatedBtn(
                                    text: "Remove Image",
                                    onPressed: () {
                                      setState(() {
                                        imageFile = null;
                                      });
                                    },
                                    bgColor: Colors.teal,
                                    borderColor: Colors.teal,
                                    textColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),

                      CustomTextField(
                        textColor: Colors.black,
                        activeTextColor: Colors.blue,
                        backgroundColor: Colors.transparent,
                        borderActiveColor: Colors.blue,
                        controller: _phoneNumberController,
                        node: _phoneNumberFocusNode,
                        hintText: 'Phone Number',
                        isNum: false,
                        maxLength: 50,
                        isPassword: false,
                        autofillHints: null,
                        nextNode: _termAndConditionFocusNode,
                        tapOn: null,
                      ),
                      //Rent Request Types
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rent Type",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize:
                                    getFontSize(16.5, getDeviceWidth(context)),
                                color: Colors.black),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CreaterentRequestPage.routeName);
                            },
                            child: Text(
                              "Create Rent Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: getFontSize(
                                      16.5, getDeviceWidth(context)),
                                  color: Colors.teal),
                            ),
                          ),
                        ],
                      ),
                      //Hortizonal list
                      StaticData.rentRequestList.isNotEmpty
                          ? BlocListener<RentRequestTypeBloc,
                              RentRequestTypeState>(
                              listener: (context, state) {
                                log(state.toString());
                                if (state is RentRequestTypeLoaded) {
                                  setState(() {});
                                }
                              },
                              child: SizedBox(
                                height: 80,
                                width: getDeviceWidth(context),
                                child: ListView.builder(
                                  itemCount: StaticData.rentRequestList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    var rentRequest =
                                        StaticData.rentRequestList[index];
                                    return Container(
                                      alignment: Alignment.centerLeft,
                                      width: getDeviceWidth(context) * 0.4,
                                      height: 65,
                                      margin: const EdgeInsets.all(8),
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 4),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            rentRequest.rent_type,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: getFontSize(12,
                                                    getDeviceWidth(context)),
                                                color: Colors.black),
                                          ),
                                          Text(
                                            rentRequest.pay_per_duration
                                                .toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: getFontSize(12,
                                                    getDeviceWidth(context)),
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : const Center(
                              child: Text("No Rent Request Type Created")),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        textColor: Colors.black,
                        activeTextColor: Colors.blue,
                        backgroundColor: Colors.transparent,
                        borderActiveColor: Colors.blue,
                        controller: _termAndConditionController,
                        node: _termAndConditionFocusNode,
                        hintText: 'Term and Condition',
                        isNum: false,
                        maxLines: 3,
                        maxLength: 200,
                        isPassword: false,
                        autofillHints: null,
                        nextNode: null,
                        tapOn: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomElevatedBtn(
                text: "Create Post",
                bgColor: Colors.teal,
                borderColor: Colors.teal,
                textColor: Colors.white,
                onPressed: () {},
              ),
            )
          ],
        ));
  }
}
