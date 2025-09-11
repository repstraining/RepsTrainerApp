import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reps_trainer_app/controllers/authentication_controller.dart';
import 'package:reps_trainer_app/utils/colors.dart';
import 'package:reps_trainer_app/utils/fonts.dart';




class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final OnboardingController authcontroller = Get.put(OnboardingController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body:  SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
            maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
          ),
          child: Form(
            key: formKey,
            child: Column(
          
              mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 70,),
                          Text(
                            'Register',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Create an account to get started.',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 24),
                          Text('Name', style: textStyleNormal.copyWith(fontSize: 18),), SizedBox(height: 16,),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Name',
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
                            controller: authcontroller.nameController,
                            validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          if (value.trim().length < 2) {
                            return 'Name must be at least 2 characters long';
                          }
                          if (value.trim().length > 50) {
                            return 'Name must not exceed 50 characters';
                          }
                          return null;
                        },
                          ),
                          SizedBox(height: 24),
                          Text('Email Address', style: textStyleNormal.copyWith(fontSize: 18),), SizedBox(height: 16,),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'name@email.com',
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
                           SizedBox(height: 24),
                          Text('Password', style: textStyleNormal.copyWith(fontSize: 18),), SizedBox(height: 16,),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Create a password',
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
                
                          SizedBox(height: 32,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                                           
                            children: [
                             Obx(() => Checkbox(
                            value: authcontroller.isTermsAccepted.value,
                            onChanged: (value) {
                              authcontroller.isTermsAccepted.value = value ?? false;
                            },
                            activeColor: primaryColor,
                          )),
                              Flexible(
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
                                                  text:  "I've read and agree with the ",
                                            ),
                                            // Section 2: Bold and red text
                                            TextSpan(
                                                  text: ' Terms and Conditions ',
                                                  style: TextStyle(
                                                   
                                                    color: primaryColor,
                                                  ),
                                            ),
                                             TextSpan(
                                                  text: 'and the',
                                                  style: TextStyle(
                                                    
                                                    color: Colors.grey,
                                                  ),
                                            ),
                                           
                                            TextSpan(
                                                  text: ' Privacy Policy.',
                                                  style: TextStyle(
                                                  
                                                    color: primaryColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                              ),
                             
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => Get.toNamed('/login'),
                                child: RichText(
                                            text: TextSpan(
                                              // Default style for the entire RichText, if not overridden by children
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white,
                                              ),
                                              children: <TextSpan>[
                                                // Section 1: Normal text
                                                const TextSpan(
                                                      text:  "Have an account? ",
                                                ),
                                                // Section 2: Bold and red text
                                                TextSpan(
                                                      text: ' Login ',
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
                    Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ElevatedButton(
                             onPressed: authcontroller.isLoading.value
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      authcontroller.register();
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
                                  : Text('Register', style: textStyleNormalBold.copyWith(fontSize: 18)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,)
                  ],
                ),
              ),
        ),
      ),
        
      
    );
  }
}