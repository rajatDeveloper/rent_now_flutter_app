import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_now/core/common/widgets/custom_button.dart';
import 'package:rent_now/core/common/widgets/custom_text_field.dart';
import 'package:rent_now/core/utils/use_full_functions.dart';
import 'package:rent_now/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:rent_now/features/auth/presentation/pages/login_page.dart';
import 'package:rent_now/features/rent_post/presentation/pages/rent_post_page.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/registerPage';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();

  bool _vaildateInputs() {
    if (_usernameController.text.isEmpty) {
      showSnackBar(context, "Username is required");
      return false;
    } else if (_passwordController.text.isEmpty) {
      showSnackBar(context, "Password is required");
      return false;
    } else if (_emailController.text.contains('@') == false ||
        _emailController.text.contains(".") == false) {
      showSnackBar(context, "Email is not valid");
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
              return Center(
                child: Column(
                  children: [
                    //Login button
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, LoginPage.routeName);
                        },
                        child: Text("Login")),
                    SizedBox(
                      height: getDeviceHeight(context) * 0.02,
                    ),
                    //User name
                    CustomTextField(
                      textColor: Colors.black,
                      activeTextColor: Colors.blue,
                      backgroundColor: Colors.transparent,
                      borderActiveColor: Colors.blue,
                      controller: _usernameController,
                      node: _usernameFocusNode,
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
                    //Password
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
                      nextNode: _emailFocusNode,
                      tapOn: null,
                    ),
                    SizedBox(
                      height: getDeviceHeight(context) * 0.02,
                    ),
                    //Email
                    CustomTextField(
                      textColor: Colors.black,
                      activeTextColor: Colors.blue,
                      backgroundColor: Colors.transparent,
                      borderActiveColor: Colors.blue,
                      controller: _emailController,
                      node: _emailFocusNode,
                      hintText: 'Email',
                      isNum: false,
                      maxLength: 50,
                      isPassword: false,
                      autofillHints: null,
                      nextNode: null,
                      tapOn: null,
                    ),
                    SizedBox(
                      height: getDeviceHeight(context) * 0.02,
                    ),
                    //Register button
                    CustomElevatedBtn(
                      text: "Register",
                      onPressed: () {
                        print("Working");
                        if (_vaildateInputs()) {
                          context.read<AuthBloc>().add(AuthRegisterEvent(
                              password2: _passwordController.text,
                              username: _usernameController.text,
                              password: _passwordController.text,
                              email: _emailController.text));
                        }
                      },
                      bgColor: Colors.teal,
                      borderColor: Colors.teal,
                      textColor: Colors.white,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
