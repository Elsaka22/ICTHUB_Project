import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icthub_2/Screens/Sign%20up_Screen.dart';
import 'package:icthub_2/Screens/home_layout.dart';
import 'package:icthub_2/Widgets/myTextFormField.dart';
import 'package:icthub_2/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailX = TextEditingController();
  TextEditingController passwordX = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> login({
    required String email,
    required String pass,
  }) async {
    if (formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass)
            .then((value) {
          if (value.user != null) {
            setState(() {
              isLoading = false;

            });
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeLayout(),
              ),
                  (route) => false,
            );
          }
        },
        );
      }
      on  FirebaseException catch(e){
        setState(() {
          isLoading = false;
        });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
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
              MyFormField(
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
              ),
              MyFormField(
                controller: passwordX,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
                hintText: 'password',
              ),
              const  Spacer(
                flex: 2,
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
                    login(
                      email: emailX.text,
                      pass: passwordX.text,
                    );
                    FocusScope.of(context).unfocus();
                  },
                  child: isLoading ?
                      const Center(
                        child: CircularProgressIndicator(),

                      )
                   :const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  )
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
                  ),SvgPicture.asset(
                    'assets/google.svg',
                  ),
                  SvgPicture.asset(
                    'assets/apple.svg',
                  ),
                ],
              ),
              const Spacer(
                flex: 2 ,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(' Don’t have an account?',
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.blackBold,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.regX,
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
