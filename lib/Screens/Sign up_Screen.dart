import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icthub_2/Screens/home_layout.dart';
import 'package:icthub_2/Widgets/myTextFormField.dart';
import 'package:icthub_2/colors.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailX = TextEditingController();
  TextEditingController passwordX = TextEditingController();
  TextEditingController namedX = TextEditingController();
  TextEditingController phoneX = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> signup(String email,
      String pass,
      String name,
      String phone,) async {
    if (formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: pass).
        then((value) {
          if (value.user != null) {
            saveUserData(
              email,
              pass,
              name,
              phone,
              value.user!.uid,
            ).then((value) {
              if (value){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeLayout(),
                  ),
                      (route) => false,
                );
              }
            });
          }
        },
        );
      }
      catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString(),
            ),
          ),
        );
      }
    }
  }

  Future<bool> saveUserData(
      String email,
      String pass,
      String name,
      String phone,
      String uid,) async {
    try {
      FirebaseFirestore.instance.collection('user').doc(uid).set(
          {
            'userName': name,
            'userEmail': email,
            'userPass': pass,
            'userPhone': phone,
            'uid': uid,
            'image' :'',
          },
          SetOptions(merge: true)
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(
                flex: 3,
              ),
              const Text(
                'Welcome back! Glad to see you, Again!',
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'UrbanistBold',
                ),
              ),
              const Spacer(),
              MyFormFiled(
                controller: namedX,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'name must be not empty';
                  }
                },
                hintText: 'name',
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(
                  Icons.person,
                ),
              ),
              MyFormFiled(
                controller: emailX,
                validator: (value) {
                  if (value!.length < 9) {
                    return 'email  must be at least 12 characters';
                  }
                  if (value.contains('#')) {
                    return '# is not allowed';
                  }
                  return null;
                },
                hintText: 'email',
                prefixIcon: const Icon(
                  Icons.email_outlined,
                ),
              ),
              MyFormFiled(
                controller: passwordX,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                },
                hintText: 'password',
                prefixIcon: const Icon(
                  Icons.password_rounded,
                ),
              ),
              MyFormFiled(
                controller: phoneX,
                validator: (value) {
                  if (value!.length < 11) {
                    return 'phone must be 11 number';
                  }
                },
                hintText: 'phone',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(
                  Icons.phone,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size( double.infinity, 53),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  signup(
                    emailX.text,
                    passwordX.text,
                    namedX.text,
                    phoneX.text,
                  );
                },
                child: const Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 25,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColors.divider,
                        thickness: 1.5,
                      ),
                    ),
                    Text(
                      ' Or Login with',
                      style: TextStyle(
                        color: AppColors.hintTextX,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColors.divider,
                        thickness: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/facebook.svg',
                  ),
                  SvgPicture.asset(
                    'assets/google.svg',
                  ),
                  SvgPicture.asset(
                    'assets/apple.svg',
                  ),
                ],
              ),
              Spacer(),

            ],
          ),
        ),
      ),
    );
  }
}