import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/ui/screen/forgot_password_verify_otp_screen.dart';
import 'package:task_manager/ui/widget/screen_background.dart';
import '../utlis/app_color.dart';

class ForgotPasswordVerifyEmailScreen extends StatefulWidget {
  const ForgotPasswordVerifyEmailScreen({super.key});
  static const String name = 'forgot_password_verify_email_screen';
  @override
  State<ForgotPasswordVerifyEmailScreen> createState() => _ForgotPasswordVerifyEmailScreenState();
}

class _ForgotPasswordVerifyEmailScreenState extends State<ForgotPasswordVerifyEmailScreen> {
  final TextEditingController _emailTEControlar = TextEditingController();
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
                  Text('Your Email Address', style: textTheme.titleLarge),
                  const SizedBox(height: 4,),
                  Text('A 6 digit of OTP will be sent to Your Email Address',style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                      controller: _emailTEControlar,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(hintText: 'Email')),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ForgotPasswordVerifyOtpScreen.name);
                      },
                      child: const Icon(Icons.arrow_circle_right_rounded)),
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
                  Navigator.pop(context);
                }),
          ]),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEControlar.dispose();
    super.dispose();
  }
}
