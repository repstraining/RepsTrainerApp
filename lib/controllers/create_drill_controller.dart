import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DrillController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();

  final RxInt repetitions = 12.obs;
  final RxBool requireSubmission = false.obs;
  final RxBool isTeamDrill = false.obs;
  final RxList<String> selectedTags = <String>[].obs;
  final List<String> allTags = [
   'Foot work',
'Body Control',
'Balance',
'Speed/Quickness',
'Situational awareness',
'Composure under pressure',
'Confidence building',
'Hand-eye coordination',
'Ball control',
'Versatility'
  ];

  final Rx<File?> videoFile = Rx<File?>(null);
  final Rx<File?> audioFile = Rx<File?>(null);
  final RxBool isRecording = false.obs;
  final RxString selectedDrillType = 'video'.obs; // Options: 'video', 'audio', 'instructions'

  FlutterSoundRecorder? _recorder;

  @override
  void onInit() {
    super.onInit();
    initRecorder();
  }

  Future<void> initRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
  }

  Future<void> pickVideo() async {
    final picker = ImagePicker();
    final pickedVideo = await picker.pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      videoFile.value = File(pickedVideo.path);
    }
  }

  Future<void> startRecording() async {
    if (await Permission.microphone.request().isGranted) {
      final tempDir = await getTemporaryDirectory();
      final audioPath = '${tempDir.path}/audio.aac';
      await _recorder!.startRecorder(toFile: audioPath);
      isRecording.value = true;
      Future.delayed(const Duration(minutes: 2), () {
        if (isRecording.value) {
          stopRecording();
        }
      });
    } else {
      Get.snackbar('Permission Denied', 'Microphone permission is required to record audio.');
    }
  }

  Future<void> stopRecording() async {
    final path = await _recorder!.stopRecorder();
    if (path != null) {
      audioFile.value = File(path);
    }
    isRecording.value = false;
  }

  Future<String?> uploadFile(File file, String extension) async {
    try {
      final ref = FirebaseStorage.instance.ref('drills/${DateTime.now().millisecondsSinceEpoch}.$extension');
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      Get.snackbar('Upload Error', 'Failed to upload file: $e');
      return null;
    }
  }

  bool validate() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Drill name is required.');
      return false;
    }
    if (selectedDrillType.value == 'video' && videoFile.value == null) {
      Get.snackbar('Validation Error', 'Please upload a video.');
      return false;
    }
    if (selectedDrillType.value == 'audio' && audioFile.value == null) {
      Get.snackbar('Validation Error', 'Please record an audio.');
      return false;
    }
    if (selectedDrillType.value == 'instructions' && instructionsController.text.trim().isEmpty) {
      Get.snackbar('Validation Error', 'Please enter instructions.');
      return false;
    }
    return true;
  }

  Future<void> onReview() async {
    if (!validate()) return;

    String? videoUrl;
    String? audioUrl;

    if (selectedDrillType.value == 'video' && videoFile.value != null) {
      videoUrl = await uploadFile(videoFile.value!, 'mp4');
    }
    if (selectedDrillType.value == 'audio' && audioFile.value != null) {
      audioUrl = await uploadFile(audioFile.value!, 'aac');
    }

    final data = {
      'name': nameController.text.trim(),
      'description': descriptionController.text.trim(),
      'videoUrl': videoUrl,
      'audioUrl': audioUrl,
      'instructions': selectedDrillType.value == 'instructions' ? instructionsController.text.trim() : null,
      'repetitions': repetitions.value,
      'requireSubmission': requireSubmission.value,
      'skillTags': selectedTags.toList(),
      'isTeamDrill': isTeamDrill.value,
      'createdAt': Timestamp.now(),
    };

    try {
      await FirebaseFirestore.instance.collection('drills').add(data);
      Get.back();
      Get.snackbar('Success', 'Drill created successfully.');
      clearFields();
    } catch (e) {
      Get.snackbar('Error', 'Failed to create drill: $e');
    }
  }

  void clearFields() {
    nameController.clear();
    descriptionController.clear();
    instructionsController.clear();
    repetitions.value = 12;
    requireSubmission.value = false;
    isTeamDrill.value = false;
    selectedTags.clear();
    videoFile.value = null;
    audioFile.value = null;
    selectedDrillType.value = 'video'; // Reset to default
  }

  @override
  void onClose() {
    nameController.dispose();
    descriptionController.dispose();
    instructionsController.dispose();
    _recorder?.closeRecorder();
    super.onClose();
  }
}