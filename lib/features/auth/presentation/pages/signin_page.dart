import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/utils/show_snackbar.dart';
import 'package:pust_guest_house/core/common/widgets/bg_home.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/custom_appbar.dart';
import 'package:pust_guest_house/core/common/widgets/custom_button.dart';
import 'package:pust_guest_house/core/common/widgets/loader.dart';
import 'package:pust_guest_house/core/common/widgets/separator.dart';
import 'package:pust_guest_house/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pust_guest_house/features/auth/presentation/pages/signup_page.dart';
import 'package:pust_guest_house/core/common/widgets/error_text.dart';
import 'package:pust_guest_house/core/common/widgets/custom_text_field.dart';
import 'package:pust_guest_house/core/common/widgets/page_title.dart';
import 'package:pust_guest_house/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:pust_guest_house/features/auth/presentation/widgets/auth_text_button.dart';

class SignInPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignInPage(),
      );
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _errorText = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return home_background(
      child: Scaffold(
          appBar: MyAppBar(),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackBar(context, state.message);
                  _errorText = state.message;
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Loader();
                }
                return Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        const PageTitle(text: 'Sign In'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        MyTextField(
                          controller: emailController,
                          hintText: 'Write your official Email',
                          labelText: 'Official Email',
                        ),
                        Separator.textField(),
                        AuthPasswordField(
                          controller: passwordController,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                        ),
                        Separator.textField(),
                        ErrorText(text: '$_errorText'),
                        Separator.textField(),
                        Separator.textField(),
                        MyButton(
                          text: 'Sign In',
                          onPressed: () {
                            _errorText = '';
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthSignIn(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                        ),
                        Separator.textField(),
                        AuthTextButton(
                          text: 'Don\'t have an account? ',
                          boldedText: 'Sign Up',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              SignupPage.route(),
                            );
                          },
                        ),
                        Separator.textField(),
                        Separator.textField(),
                        Separator.textField(),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
