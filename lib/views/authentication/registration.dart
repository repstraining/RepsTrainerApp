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
  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body:  Column(
        children: [
         SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                TextField(
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
                ),
                SizedBox(height: 24),
                Text('Email Address', style: textStyleNormal.copyWith(fontSize: 18),), SizedBox(height: 16,),
                TextField(
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
                ),
                 SizedBox(height: 24),
                Text('Password', style: textStyleNormal.copyWith(fontSize: 18),), SizedBox(height: 16,),
                TextField(
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
                ),
      
                SizedBox(height: 32,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
                                 
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                      activeColor: primaryColor ,
                    ),
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), 
                            ),
                      
                    ),
                    child: Text('Register', style: textStyleNormalBold.copyWith(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 40,)
        ],
      ),
    );
  }
}