import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/utils/show_snackbar.dart';
import 'package:pust_guest_house/core/common/widgets/bg_home.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/custom_appbar.dart';
import 'package:pust_guest_house/core/common/widgets/custom_button.dart';
import 'package:pust_guest_house/core/common/widgets/loader.dart';
import 'package:pust_guest_house/core/common/widgets/separator.dart';
import 'package:pust_guest_house/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pust_guest_house/features/auth/presentation/pages/signin_page.dart';
import 'package:pust_guest_house/core/common/widgets/error_text.dart';
import 'package:pust_guest_house/core/common/widgets/custom_text_field.dart';
import 'package:pust_guest_house/core/common/widgets/page_title.dart';
import 'package:pust_guest_house/features/auth/presentation/widgets/auth_password_field.dart';
import 'package:pust_guest_house/features/auth/presentation/widgets/auth_text_button.dart';
import 'package:pust_guest_house/features/auth/presentation/widgets/department_dropdown.dart';

class SignupPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const SignupPage(),
      );
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final designationController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final departmentController = TextEditingController();

  String _errorText = '';

  @override
  void dispose() {
    userNameController.dispose();
    designationController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    departmentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return home_background(
      child: Scaffold(
          appBar: MyAppBar(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if(state is AuthFailure){
                  showSnackBar(context, state.message);
                  _errorText = state.message;
                }
              },
              builder: (context, state) {
                if(state is AuthLoading){
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
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        const PageTitle(text: 'Sign UP'),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        MyTextField(
                          controller: userNameController,
                          labelText: "User Name",
                          hintText: 'Enter your full name',
                        ),
                        Separator.textField(),
                        MyTextField(
                          controller: designationController,
                          labelText: "Designation",
                          hintText: 'Write your designation',
                        ),
                        Separator.textField(),
                        MyTextField(
                          controller: emailController,
                          hintText: 'Write your official Email',
                          labelText: 'Official Email',
                        ),
                        Separator.textField(),
                        MyTextField(
                          controller: phoneNumberController,
                          hintText: 'Enter your phone number',
                          labelText: 'User Phone Number',
                        ),
                        Separator.textField(),
                        AuthPasswordField(
                          controller: passwordController,
                          labelText: 'Password',
                          hintText: 'Enter your password',
                        ),
                        Separator.textField(),
                        AuthPasswordField(
                            controller: confirmPasswordController,
                            labelText: 'Confirm Password',
                            hintText: 'Enter your password again to confirm'),
                        Separator.textField(),
                        DepartmentDropdown(
                          controller: departmentController,
                        ),
                        Separator.textField(),
                        ErrorText(text: '$_errorText'),
                        Separator.textField(),
                        Separator.textField(),
                        MyButton(
                            text: 'Sign Up',
                            onPressed: () {
                              _errorText = '';
                              if (formKey.currentState!.validate()) {
                                if (passwordController.text.trim() ==
                                    confirmPasswordController.text.trim()) {
                                  context.read<AuthBloc>().add(
                                        AuthSignUp(
                                          userName:
                                              userNameController.text.trim(),
                                          designation:
                                              designationController.text.trim(),
                                          email: emailController.text.trim(),
                                          userPhoneNumber:
                                              phoneNumberController.text.trim(),
                                          password:
                                              passwordController.text.trim(),
                                          department:
                                              departmentController.text.trim(),
                                        ),
                                      );
                                } else {
                                  setState(() {
                                    _errorText =
                                        "Password and Confirm password does't match.";
                                  });
                                }
                              }
                            }),
                        Separator.textField(),
                        AuthTextButton(
                          text: 'Don\'t have an account? ',
                          boldedText: 'Sign In',
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              SignInPage.route(),
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
