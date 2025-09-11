import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final isTermsAccepted = false.obs;

  // Text controllers for form fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Email validation (basic regex for email format)
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email.trim());
  }

  // Password validation (minimum 6 characters)
  bool isValidPassword(String password) {
    return password.trim().length >= 6;
  }

  void showSnackBar(String title, String message, {bool isError = false}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      backgroundColor: isError ? Colors.red.withOpacity(0.9) : Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      borderRadius: 12,
      isDismissible: true,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.easeInBack,
      maxWidth: 300, // Compact width for sleek appearance
      snackStyle: SnackStyle.FLOATING,
    );
  }

  // Registration function with enhanced error handling
  Future<void> register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String name = nameController.text.trim();

    // Validation checks
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      errorMessage.value = 'Please fill all fields';
      showSnackBar('Error', 'Please fill all fields', isError: true);
      return;
    }
    if (!isValidEmail(email)) {
      errorMessage.value = 'Please enter a valid email address';
      showSnackBar('Error', 'Please enter a valid email address', isError: true);
      return;
    }
    if (!isValidPassword(password)) {
      errorMessage.value = 'Password must be at least 6 characters';
      showSnackBar('Error', 'Password must be at least 6 characters', isError: true);
      return;
    }
     if (!isTermsAccepted.value) {
       errorMessage.value = 'You must accept the terms and conditions';
       showSnackBar('Error', 'You must accept the terms and conditions', isError: true);
       return;
     }

    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(name);
      errorMessage.value = 'Registration successful';
      showSnackBar('Success', 'Registration successful');
      clearFields();
      Get.offAllNamed('/login');
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = 'This email is already registered';
          break;
        case 'invalid-email':
          message = 'Invalid email format';
          break;
        case 'weak-password':
          message = 'Password is too weak';
          break;
        case 'operation-not-allowed':
          message = 'Email registration is disabled';
          break;
        case 'too-many-requests':
          message = 'Too many attempts, try again later';
          break;
        default:
          message = e.message ?? 'Registration failed';
      }
      errorMessage.value = message;
      showSnackBar('Error', message, isError: true);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
      showSnackBar('Error', 'An unexpected error occurred', isError: true);
    } finally {
      isLoading.value = false;
    }
  }

  // Login function with enhanced error handling
  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Validation checks
    if (email.isEmpty || password.isEmpty) {
      errorMessage.value = 'Please fill all fields';
      showSnackBar('Error', 'Please fill all fields', isError: true);
      return;
    }
    if (!isValidEmail(email)) {
      errorMessage.value = 'Please enter a valid email address';
      showSnackBar('Error', 'Please enter a valid email address', isError: true);
      return;
    }
    if (!isValidPassword(password)) {
      errorMessage.value = 'Password must be at least 6 characters';
      showSnackBar('Error', 'Password must be at least 6 characters', isError: true);
      return;
    }

    isLoading.value = true;
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      errorMessage.value = 'Login successful';
      showSnackBar('Success', 'Login successful');
      clearFields();
      Get.offNamed('/bottomNav');
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'invalid-email':
          message = 'Invalid email format';
          break;
        case 'user-disabled':
          message = 'This account has been disabled';
          break;
        case 'too-many-requests':
          message = 'Too many attempts, try again later';
          break;
        case 'invalid-credential':
          message = 'Invalid email or password';
          break;
        default:
          message = e.message ?? 'Login failed';
      }
      errorMessage.value = message;
      showSnackBar('Error', message, isError: true);
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
      showSnackBar('Error', 'An unexpected error occurred', isError: true);
    } finally {
      isLoading.value = false;
    }
  }


  // Clear form fields
  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }}