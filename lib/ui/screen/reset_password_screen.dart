import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/sign_in_screen.dart';
import 'package:task_manager/ui/widget/screen_background.dart';
import '../utlis/app_color.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});
  static const String name = 'forgot_password/reset_password';
  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEControlar = TextEditingController();
  final TextEditingController _confrimPasswordTEControlar = TextEditingController();
  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // appBar: AppBar(title: Text('SignIn'),),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text('Set Password', style: textTheme.titleLarge),
                  const SizedBox(height: 4,),
                  Text('Minimum length password 8 character with Latter and number combination',style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),),
                  const SizedBox(
                    height: 24,
                  ),
              TextFormField(
                  controller: _newPasswordTEControlar,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: 'New Password')),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                      controller: _confrimPasswordTEControlar,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Confrim Password')),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      child: Text('Confrim')),
                  const SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: buitlSignInSection(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buitlSignInSection() {
    return RichText(
      text: TextSpan(
          text: "have an Account? ",
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),
          children: [
            TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  color: AppColor.themeColor,
                ),
                recognizer: TapGestureRecognizer()..onTap = () {
                  Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name , (value) => false);
                }),
          ]),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _newPasswordTEControlar.dispose();
    _confrimPasswordTEControlar.dispose();
    super.dispose();
  }
}
