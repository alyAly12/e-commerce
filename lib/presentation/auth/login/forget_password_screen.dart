import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:watches_app/consts/auth_validator.dart';
import 'package:watches_app/widgets/custom_text_widget.dart';
import 'package:watches_app/widgets/sign_in_button.dart';

import '../../../widgets/app_animated_name.dart';
import '../../../widgets/custom_subtitle_widget.dart';

class ForgetPassWordScreen extends StatefulWidget {
  const ForgetPassWordScreen({super.key});
  static String id ='forget-pass-screen';

  @override
  State<ForgetPassWordScreen> createState() => _ForgetPassWordScreenState();
}

class _ForgetPassWordScreenState extends State<ForgetPassWordScreen> {
  late TextEditingController emailController;
  GlobalKey<FormState>formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController =TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
     if(mounted){
       emailController.dispose();
     }
    super.dispose();
  }
  Future<void>forgetPassFct()async{
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){}

  }
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const AppAnimatedName(name: 'Shop Smart'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          physics: const BouncingScrollPhysics(),
          children: [
            Image.asset('asset/images/reset password.png',
            ),
            const SizedBox(height: 10,),
            const CustomTextWidget(title: 'Forget Password'),
            const SizedBox(height: 10,),
            const SubTitleWidget(subTitle: 'Please enter your e-mail address',fontSize: 17,color: Colors.grey,),
            const SizedBox(height: 40,),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller:emailController ,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: 'e-mail@example.com',
                      prefixIcon: Icon(IconlyLight.message,
                      color: Colors.lightBlueAccent,
                      )
                    ),
                    validator: (value){
                      return AuthValidator.emailValidator(value);
                    },
                    onFieldSubmitted: (_){
                      // forgetPassFct();
                    },
                  ),
                  const SizedBox(height: 40,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: ElevatedButton(
                       onPressed: ()async{
                         await forgetPassFct();
                       },
                       child: const Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(IconlyBold.send),
                           CustomTextWidget(title: 'Request link',fontSize: 20,)
                         ],
                       )),
                 )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
