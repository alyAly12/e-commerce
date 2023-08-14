import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:watches_app/consts/app_color.dart';
import 'package:watches_app/consts/auth_validator.dart';
import 'package:watches_app/controllers/provider/theme_provider.dart';
import 'package:watches_app/services/dailogs_sercices.dart';
import 'package:watches_app/widgets/pick_image_widget.dart';

import '../../../widgets/custom_text_widget.dart';
import '../../../widgets/sign_in_button.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  static String id ='signup-screen';
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController emailController ;
  late TextEditingController passwordController;
  late TextEditingController repeatPassword ;
  late TextEditingController fullNameController;
  late FocusNode passFocus ;
  late FocusNode emailFocus ;
  late FocusNode nameFocus ;
  late FocusNode repeatPasswordFocus = FocusNode();

  final formKey = GlobalKey<FormState>();
  var obscureText = true;
  XFile? _pickedImage;

  @override
  void initState() {
    emailController = TextEditingController();
    fullNameController= TextEditingController();
    passwordController= TextEditingController();
    repeatPassword= TextEditingController();
    nameFocus = FocusNode();
    emailFocus = FocusNode();
    passFocus = FocusNode();
    repeatPasswordFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    repeatPassword.dispose();
    fullNameController.dispose();
    emailFocus.dispose();
    repeatPasswordFocus.dispose();
    nameFocus.dispose();
    passFocus.dispose();
    super.dispose();
  }
  bool isLoading = false;
  void submitOnRegister()async{
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(isValid){
      formKey.currentState!.save();
      if(_pickedImage ==null){
        DialogsServices.appDialog(
            context: context,
            title: 'Please pick an image', fct: (){});
      }
    }
  }
  Future<void>localImagePicker()async{
    final ImagePicker picker =ImagePicker();
    await DialogsServices.imagePickerDialog(
        context: context,
        cameraFct: ()async{
          _pickedImage= await picker.pickImage(source: ImageSource.camera);
         setState(() {});
        },
        galleryFct: ()async{
          _pickedImage= await picker.pickImage(source: ImageSource.gallery);
         setState(() {});
        },
        removeFct: (){
          setState(() {
            _pickedImage = null;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeState = Provider.of<ThemeProvider>(context);
    final Color color = themeState.getDarkTheme?Colors.white:Colors.black;
    return  GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body:  Stack(
            children: [
                   Image.network(
                    AppConsts.landingImages,
                    fit: BoxFit.cover,
                     height: double.infinity,
                  ),

              Container(
                color: Colors.black.withOpacity(0.6),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Navigator.canPop(context)?Navigator.pop(context):null;
                          },
                          child: const Icon(CupertinoIcons.back,color: Colors.white,)),
                      const SizedBox(height: 25,),
                      CustomTextWidget(
                          title: 'Welcome  😊 ',
                          fontSize: 30,
                          color: color),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextWidget(
                          title: 'Sign up to continue',
                          fontSize: 15,
                          color: color),
                      const SizedBox(
                        height: 15,
                      ),
                      //TODO add image picker
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height:size.height*0.2 ,
                          width: size.width*0.3,
                          child: PickImageWidget(
                            fun:()async{
                              await localImagePicker();
                            },
                            pickedImage:_pickedImage ,),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: fullNameController,
                              focusNode: nameFocus,
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(emailFocus),
                              keyboardType: TextInputType.multiline,
                              validator: (value) {
                                return AuthValidator.displayNameValidator(value);
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Full name',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: emailController,
                              focusNode: emailFocus,
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(passFocus),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                               return AuthValidator.emailValidator(value);
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'E-mail',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: passwordController,
                              obscureText: obscureText,
                              onEditingComplete: () =>
                                  FocusScope.of(context).requestFocus(repeatPasswordFocus),
                              keyboardType: TextInputType.multiline,
                              focusNode: passFocus,
                              validator: (value) {
                               return AuthValidator.passWordValidator(value);
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    )),
                                hintText: 'Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              maxLines: 2,
                              textInputAction: TextInputAction.done,
                              controller: repeatPassword,
                              focusNode: repeatPasswordFocus,
                              onFieldSubmitted: (value){
                                FocusScope.of(context).requestFocus(repeatPasswordFocus);
                              },
                              onEditingComplete: () {
                                submitOnRegister();
                              },
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                               return AuthValidator.repeatPassWordValidator(value, passwordController.text);
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration:  InputDecoration(
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        obscureText = !obscureText;
                                      });
                                    },
                                    icon: Icon(
                                      obscureText
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.white,
                                    )),
                                hintText: 'Confirm Password',
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),),

                      const SizedBox(height: 20,),
                      SignButton(onPressed: () {
                        submitOnRegister();
                      }, title:  'Sign up',),
                      const SizedBox(height: 30,),
                      Row(
                        children: [
                           const CustomTextWidget(title: 'Already have an account', fontSize: 15,  color: Colors.white),
                          const SizedBox(width: 5,),
                          GestureDetector(
                              onTap: (){
                                Navigator.pushNamed(context, LoginScreen.id);
                              },
                              child: const CustomTextWidget(title: 'Sign in   👍🏼 ', fontSize: 20,  color: Colors.blue)),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
      ),
    );
  }
}