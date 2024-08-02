import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/core/common/widgets/custom_button.dart';
import 'package:rent_now/core/const/static_data.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/address/presentation/bloc/address_bloc.dart';
import 'package:rent_now/features/address/presentation/pages/create_address_page.dart';
import 'package:rent_now/features/address/presentation/widgets/address_card.dart';

class AddressPage extends StatefulWidget {
  static const String routeName = '/address';
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
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
        title: const Text('Address Page'),
      ),
      body: SafeArea(
        child: BlocConsumer<AddressBloc, AddressState>(
          listener: (context, state) {
            if (state is AddressError) {
              showSnackBar(context, state.message);
            }

            if (state is AddressCreated) {
              context.read<AddressBloc>().add(GetAllAddressEvent(
                  userId: StaticData.user!.id.toString(),
                  token: StaticData.user!.token));
            }
          },
          builder: (context, state) {
            if (state is AddressLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is AddressLoaded) {
              StaticData.adddressList = state.addressList;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state.addressList.isEmpty
                      ? Center(
                          child: Container(
                              alignment: Alignment.bottomCenter,
                              height: getDeviceHeight(context) * 0.3,
                              child: Text("No Address Found")))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: state.addressList.length,
                            itemBuilder: (context, index) {
                              return AddressCard(
                                  addressModel: state.addressList[index]);
                            },
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CustomElevatedBtn(
                      text: "Add New Address",
                      prefixIcon: Icons.location_city,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, CreateAddressPage.routeName);
                      },
                      bgColor: Colors.teal,
                      borderColor: Colors.teal,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
