import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/core/common/widgets/custom_button.dart';
import 'package:rent_now/core/common/widgets/custom_text_field.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rent_now/features/rent_post/presentation/pages/rent_post_page.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginPage';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  bool _vaildateInputs() {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            showSnackBar(context, state.message);
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, RentPostPage.routeName, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: [
              CustomTextField(
                textColor: Colors.black,
                activeTextColor: Colors.blue,
                backgroundColor: Colors.transparent,
                borderActiveColor: Colors.blue,
                controller: _usernameController,
                node: _emailFocusNode,
                hintText: 'Username',
                isNum: false,
                maxLength: 50,
                isPassword: false,
                autofillHints: null,
                nextNode: _passwordFocusNode,
                tapOn: null,
              ),
              SizedBox(
                height: getDeviceHeight(context) * 0.02,
              ),
              CustomTextField(
                textColor: Colors.black,
                activeTextColor: Colors.blue,
                backgroundColor: Colors.transparent,
                borderActiveColor: Colors.blue,
                controller: _passwordController,
                node: _passwordFocusNode,
                hintText: 'Password',
                isNum: false,
                maxLength: 50,
                isPassword: true,
                autofillHints: null,
                nextNode: null,
                tapOn: null,
              ),
              SizedBox(
                height: getDeviceHeight(context) * 0.02,
              ),
              CustomElevatedBtn(
                text: "Login",
                onPressed: () {
                  print("Working");
                  context.read<AuthBloc>().add(AuthLoginEvent(
                      username: _usernameController.text,
                      password: _passwordController.text));
                },
                bgColor: Colors.teal,
                borderColor: Colors.teal,
                textColor: Colors.white,
              )
            ],
          );
        },
      ),
    )));
  }
}
