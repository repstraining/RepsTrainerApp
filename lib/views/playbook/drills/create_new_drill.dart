import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reps_trainer_app/controllers/create_drill_controller.dart';
import 'package:reps_trainer_app/utils/colors.dart';
import 'package:reps_trainer_app/utils/fonts.dart';



class CreateNewDrillScreen extends StatelessWidget {
  final DrillController controller = Get.put(DrillController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: const Text('Create New Drill', style: textStyleH1Bold,),
      backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Drill Name', style:textStyleNormalBold),
            SizedBox(height: 10,),
                TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Drill Name',
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
                     
                      keyboardType: TextInputType.name,
                 
                    ),
            
            const SizedBox(height: 16),
            const Text('Drill Description',style: textStyleNormalBold),
const SizedBox(height: 10),
            TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Drill Description',
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
                     
                      keyboardType: TextInputType.name,
                      maxLines: 3,
                 
                    ),
            const SizedBox(height: 16),
            const Text('Upload Type',style: textStyleNormalBold,),
            const SizedBox(height: 16),
             const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(() => GestureDetector(
                onTap: () => controller.selectedDrillType.value = 'video',
                child: Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: controller.selectedDrillType.value == 'video'
                        ? primaryColor // Selected: primaryColor background
                        : Colors.grey.withOpacity(0.2), // Unselected: subtle grey
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: controller.selectedDrillType.value == 'video'
                          ? primaryColor
                          : Colors.grey,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.videocam_outlined,
                        color: Colors.white, // White icon for dark mode
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Video',
                        style: TextStyle(
                          color: Colors.white, // White text for dark mode
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Obx(() => GestureDetector(
                onTap: () => controller.selectedDrillType.value = 'audio',
                child: Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: controller.selectedDrillType.value == 'audio'
                        ? primaryColor
                        : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: controller.selectedDrillType.value == 'audio'
                          ? primaryColor
                          : Colors.grey,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.multitrack_audio,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Audio',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          Obx(() => GestureDetector(
                onTap: () => controller.selectedDrillType.value = 'instructions',
                child: Container(
                  width: 100,
                  height: 80,
                  decoration: BoxDecoration(
                    color: controller.selectedDrillType.value == 'instructions'
                        ? primaryColor
                        : Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: controller.selectedDrillType.value == 'instructions'
                          ? primaryColor
                          : Colors.grey,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.integration_instructions,
                        color: Colors.white,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Instructions',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
      const SizedBox(height: 16),
      Obx(() {
        if (controller.selectedDrillType.value == 'video') {
          return Column(
            children: [
              Obx(() => controller.videoFile.value == null
                  ? GestureDetector(
                      onTap: controller.pickVideo,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.upload, color: Colors.white,),
                              Text(
                                'Tap to upload video',
                                style: TextStyle(color: Colors.white), // White text
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Text(
                      'Video selected: ${controller.videoFile.value!.path}',
                      style: const TextStyle(color: Colors.white),
                    )),
            ],
          );
        } else if (controller.selectedDrillType.value == 'audio') {
          return Column(
            children: [
              Obx(() => controller.isRecording.value
                  ? const Text(
                      'Recording audio...',
                      style: TextStyle(color: Colors.white),
                    )
                  : controller.audioFile.value == null
                      ?
                      GestureDetector(
                      onTap: controller.startRecording,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.audio_file, color: Colors.white,),
                              Text(
                                'Record Audio (max 2 min)',
                                style: TextStyle(color: Colors.white), // White text
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                      
                      
                      : Text(
                          'Audio recorded: ${controller.audioFile.value!.path}',
                          style: const TextStyle(color: Colors.white),
                        )),
            ],
          );
        } else {
          return Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Quick Instructions',
                  hintStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                keyboardType: TextInputType.name,
                maxLines: 3,
              ),
            ],
          );
        }
      }),
      const SizedBox(height: 16),
       Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           const Text('Drill Repetitions', style: textStyleNormalBold,),
           Obx(() => Container(
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey)
              

            ),

             child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white,),
                        onPressed: () {
                          if (controller.repetitions.value > 1) controller.repetitions.value--;
                        },
                      ),
                      Text('${controller.repetitions.value}', style: textStyleNormalBold,),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white,),
                        onPressed: () => controller.repetitions.value++,
                      ),
                    ],
                  ),
           )),
         ],
       ),
            
            
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Require player video submission', style: textStyleNormalBold,),
                Obx(() => Switch(
                      value: controller.requireSubmission.value,
                      onChanged: (value) => controller.requireSubmission.value = value,
                    )),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Skill Tags', style: textStyleNormalBold,),
            SizedBox(height: 10,),
            Obx(() => Wrap(
                  spacing: 8.0,
                  children: controller.allTags.map((tag) {
                    return FilterChip(
                      label: Text(tag),
                      selected: controller.selectedTags.contains(tag),
                      onSelected: (selected) {
                        if (selected) {
                          controller.selectedTags.add(tag);
                        } else {
                          controller.selectedTags.remove(tag);
                        }
                      },
                    //   selectedColor: primaryColor,
                    //   labelStyle: textStyleNormal,
                    //  showCheckmark: false,
                    //  disabledColor: Colors.grey.withOpacity(0.2),

                    );
                  }).toList(),
                )),
          
          
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.withOpacity(0.2),  ),
                    child: const Text('Cancel', style: TextStyle(color: Colors.white),),
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: controller.onReview,
                    style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    child: const Text('Review', style: textStyleNormal,),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}