import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reps_trainer_app/views/playbook/drills/create_new_drill.dart';

class PlaybookController extends GetxController {
  var selectedTab = 0.obs;
  final searchController = TextEditingController();

  String get searchHint {
    return selectedTab.value == 0 ? 'Search Plans' : 'Search Drills';
  }

 void createItem() {
    final String itemType = selectedTab.value == 0 ? 'Plan' : 'Drill';
    if (itemType == 'Plan') {
      Get.snackbar('Creating', 'Creating a new Plan... (Implement Plan creation dialog here)');
    } else {
      Get.toNamed('/createDrill');
      //showCreateDrillDialog();
    }
  }

  // void showCreateDrillDialog() {
  //   Get.dialog(const CreateDrillDialog());
  // }
}