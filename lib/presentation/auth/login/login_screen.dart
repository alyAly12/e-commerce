import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:watches_app/consts/app_color.dart';
import 'package:watches_app/consts/auth_validator.dart';
import 'package:watches_app/presentation/auth/login/forget_password_screen.dart';
import 'package:watches_app/presentation/auth/login/sign_up_screen.dart';
import 'package:watches_app/widgets/custom_text_widget.dart';
import 'package:watches_app/widgets/google_button.dart';
import 'package:watches_app/widgets/guest_button.dart';
import 'package:watches_app/widgets/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  static String id ='login-screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode emailNode;
  late FocusNode passwordNode;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var obscureText = true;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  Future<void> loginFct() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {}
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          body: Stack(
        children: [
          Image.network(
            AppConsts.ozaroImage,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const CustomTextWidget(
                    title: 'Welcome Back  😊',
                    fontSize: 30,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: CustomTextWidget(title: 'Login to continue')),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          focusNode: emailNode,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          decoration:  const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                              focusedBorder:OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ) ,
                              hintText: 'E-mail',
                              hintStyle: TextStyle(color: Colors.white),
                              prefixIcon: Icon(IconlyLight.message,color: Colors.lightBlueAccent,)),
                          validator: (value) {
                            return AuthValidator.emailValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(passwordNode);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          focusNode: passwordNode,
                          obscureText: obscureText,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder:const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ) ,
                            hintText: '**********',
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(IconlyLight.lock,color: Colors.lightBlueAccent,),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                              icon: Icon(obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                              ),
                            ),
                          ),
                          validator: (value) {
                            return AuthValidator.passWordValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            loginFct();
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, ForgetPassWordScreen.id);
                              //  TODO navigate to forget password screen
                            },
                            child: const Text(
                              'Forget password ?',
                              maxLines: 1,
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SignButton(
                            onPressed: () {
                              //  TODO login fct
                            },
                            title: 'Log in'),
                        const SizedBox(
                          height: 20,
                        ),
                        const CustomTextWidget(
                          title: '-OR-',
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GoogleButton(),
                      GuestButton(onPressed: (){

                      })
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomTextWidget(title: 'Don\'t have account?', fontSize: 15),
                      const SizedBox(width: 5,),
                      GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, SignUpScreen.id);
                          },
                          child: const CustomTextWidget(title: 'SignUp 😀', fontSize: 20, color: Colors.blue)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }
}
