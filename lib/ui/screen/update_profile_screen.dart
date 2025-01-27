import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/Urls/urls.dart';
import 'package:task_manager/data/service/network_caller.dart';
import 'package:task_manager/ui/controllers/auth_coltrollers.dart';
import 'package:task_manager/ui/widget/center_circular_progress_indicator.dart';
import 'package:task_manager/ui/widget/screen_background.dart';
import 'package:task_manager/ui/widget/snack_bar_message.dart';
import 'package:task_manager/ui/widget/tm_app_bar.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});
  static const String name = '/update-profile';
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEControlar = TextEditingController();
  final TextEditingController _firstNameTEControlar = TextEditingController();
  final TextEditingController _lastNameTEControlar = TextEditingController();
  final TextEditingController _mobileNumberTEControlar = TextEditingController();
  final TextEditingController _passwordTEControlar = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProfileInProgress= false;
  XFile? _pickedImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTEControlar.text = AuthColtroller.userModel?.email ?? '';
    _firstNameTEControlar.text = AuthColtroller.userModel?.firstName ?? '';
    _lastNameTEControlar.text = AuthColtroller.userModel?.lastName ?? '';
    _mobileNumberTEControlar.text = AuthColtroller.userModel?.mobile ?? '';
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: const TMAppBar(
        fromUpdateProfile: true,
      ),
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
                  height: 32,
                ),
                Text('Update Profile', style: textTheme.titleLarge),
                const SizedBox(
                  height: 24,
                ),
                _buildPhotoPicker(),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  enabled: false,
                    controller: _emailTEControlar,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: 'Email')),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _firstNameTEControlar,
                    decoration: const InputDecoration(hintText: 'First Name'),
                  validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter Your FirstName';
                      }
                      return null;
                  },
                ),

                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _lastNameTEControlar,
                    decoration: const InputDecoration(hintText: 'Last Name'),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter Your LastName';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _mobileNumberTEControlar,
                    decoration:
                        const InputDecoration(hintText: 'Mobile Number'),
                  validator: (String? value){
                    if(value?.trim().isEmpty ?? true){
                      return 'Enter Your Phone Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _passwordTEControlar,
                    obscureText: true,
                    decoration: const InputDecoration(hintText: 'Password')),
                const SizedBox(
                  height: 24,
                ),
                Visibility(
                  visible: _updateProfileInProgress == false,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          _updateProfile();
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_rounded)),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget _buildPhotoPicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Photos',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
             Text( _pickedImage== null ?  'No Item Selected': _pickedImage!.name,maxLines: 1,),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    ImagePicker picker= ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if(image != null){
      _pickedImage = image;
      setState(() {});
    }

  }
  Future<void> _updateProfile() async {
    _updateProfileInProgress = true;
    setState(() {});
    Map<String,dynamic> requestBody = {
      'email' : _emailTEControlar.text.trim(),
      'firstName' : _firstNameTEControlar.text.trim(),
      'lastName' : _lastNameTEControlar.text.trim(),
      'mobile' : _mobileNumberTEControlar.text.trim(),
    };
    if(_pickedImage != null){
      List<int> imageBytes= await _pickedImage!.readAsBytes();
      requestBody['photo']= base64Encode(imageBytes);
    }
    if(_passwordTEControlar.text.isNotEmpty){
      requestBody['password'] = _passwordTEControlar.text;
    }
    final NetworkResponse response = await NetworkCaller.getPost(url: Urls.updateProfile,body: requestBody);
    _updateProfileInProgress = false;
    setState(() {});
    if(response.isSuccess){
      _passwordTEControlar.clear();
      ShowSnackBarMessage(context, 'Update Profile Success');
    } else{
      ShowSnackBarMessage(context, response.errorMessage);
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _emailTEControlar.dispose();
    _firstNameTEControlar.dispose();
    _lastNameTEControlar.dispose();
    _mobileNumberTEControlar.dispose();
    _passwordTEControlar.dispose();
    super.dispose();
  }
}
