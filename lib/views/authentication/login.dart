import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reps_trainer_app/controllers/authentication_controller.dart';
import 'package:reps_trainer_app/utils/colors.dart';
import 'package:reps_trainer_app/utils/fonts.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final OnboardingController authcontroller = Get.put(OnboardingController());
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body:  
              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Image.asset('assets/images/reps.png',   width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height * 0.5 , fit: BoxFit.cover,),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome back!',
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Let's get back to it!",
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(height: 24),
                             TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        //labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                         focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor,),
                   borderRadius: BorderRadius.circular(5),
                        
                            ),
                      ),
                      style: TextStyle(color: Colors.white),
                      controller: authcontroller.emailController,
                      keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!authcontroller.isValidEmail(value)) {
                      return 'Please enter a valid email address (e.g., user@domain.com)';
                    }
                    if (value.trim().length > 100) {
                      return 'Email must not exceed 100 characters';
                    }
                    return null;
                  },
                    ),
                    SizedBox(height: 16,),
                             TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                        //labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                         focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor,),
                   borderRadius: BorderRadius.circular(5),
                        
                            ),
                      ),
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: authcontroller.passwordController,
                      validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (!authcontroller.isValidPassword(value)) {
                      return 'Password must be at least 6 characters long';
                    }
                    // Optional: Add more password rules (e.g., one uppercase, one number)
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return 'Password must contain at least one uppercase letter';
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return 'Password must contain at least one number';
                    }
                    if (value.trim().length > 50) {
                      return 'Password must not exceed 50 characters';
                    }
                    return null;
                  },
                    ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot password?',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            ElevatedButton(
                      onPressed:  () {
                              if (formKey.currentState!.validate()) {
                                authcontroller.login();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0), 
                                ),
                          
                        ),
                      child: Obx(
                        ()=> authcontroller.isLoading.value
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text('Login', style: textStyleNormalBold.copyWith(fontSize: 18)),
                      ),
                    ),
                         
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () => Get.toNamed('/registration'),
                                  child: RichText(
                                          text: TextSpan(
                                            // Default style for the entire RichText, if not overridden by children
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey,
                                            ),
                                            children: <TextSpan>[
                                              // Section 1: Normal text
                                              const TextSpan(
                                                    text:  "Not a member? ",
                                              ),
                                              // Section 2: Bold and red text
                                              TextSpan(
                                                    text: ' Register now ',
                                                    style: TextStyle(
                                                     decoration: TextDecoration.underline,
                                                      color: primaryColor,
                                                    ),
                                              ),
                                            
                                                
                                              
                                            ],
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}