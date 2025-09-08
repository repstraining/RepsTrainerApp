
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class CreateDrillDialogController extends GetxController {
  final TextEditingController drillNameController = TextEditingController();
  final TextEditingController drillDescriptionController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController quickInstructionsController = TextEditingController();
  final TextEditingController detailedInstructionsController = TextEditingController();

  var selectedDrillType = 0.obs; // 0: Video Demo, 1: Instructions Only
  var selectedDifficulty = 'Beginner'.obs;
  var videoFile = Rx<File?>(null);
  var videoDuration = Rx<Duration?>(null);
  var errorMessage = Rx<String?>(null);

  Future<void> pickVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery); // Or ImageSource.camera

    if (video != null) {
      final File file = File(video.path);
      final VideoPlayerController controller = VideoPlayerController.file(file);
      await controller.initialize();
      final Duration duration = controller.value.duration;
      await controller.dispose();

      if (duration.inMinutes > 30) {
        errorMessage.value = 'Video must be 30 minutes or shorter.';
        videoFile.value = null;
        videoDuration.value = null;
      } else {
        videoFile.value = file;
        videoDuration.value = duration;
        errorMessage.value = null;
      }
    }
  }

  @override
  void onClose() {
    drillNameController.dispose();
    drillDescriptionController.dispose();
    durationController.dispose();
    quickInstructionsController.dispose();
    detailedInstructionsController.dispose();
    super.onClose();
  }
}