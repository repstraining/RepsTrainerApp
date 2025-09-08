
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reps_trainer_app/controllers/create_drill_controller.dart';
import 'package:reps_trainer_app/utils/colors.dart';
import 'package:reps_trainer_app/utils/fonts.dart';



class CreateDrillDialog extends StatelessWidget {
  const CreateDrillDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateDrillDialogController controller = Get.put(CreateDrillDialogController());

    return AlertDialog(
      backgroundColor: backgroundColorDialog,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 50,),
          const Text('Create New Drill', style: textStyleH1Bold,),
           const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, size: 14, color: Colors.grey,),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Obx(
          () => Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Drill Name', style: textStyleNormal,),
                TextField(
                  controller: controller.drillNameController,
                  decoration: const InputDecoration(
                    hintText: 'e.g., Form Shooting Close Range',
                    border: OutlineInputBorder(),hintStyle: textStyleNormal
                  ),
                  style: textStyleNormal,
                ),
                const SizedBox(height: 16),
                const Text('Drill Description', style: textStyleNormal,),
                TextField(
                  controller: controller.drillDescriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Brief description of the drill...',
                    border: OutlineInputBorder(),
                    hintStyle: textStyleNormal
                    
                  ),
                  maxLines: 3,
                  style: textStyleNormal,
                ),
                const SizedBox(height: 16),
                const Text('Drill Type', style: textStyleNormal,),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectedDrillType.value = 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: controller.selectedDrillType.value == 0 ? backgroundColor : backgroundColorDialog,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(child: Text('Video Demo', style: textStyleNormal,)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectedDrillType.value = 1,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: controller.selectedDrillType.value == 1 ?  backgroundColor : backgroundColorDialog,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Center(child: Text('Instructions Only' ,style: textStyleNormal,)),
                        ),
                      ),
                    ),
                  ],
                ),
                if (controller.selectedDrillType.value == 0) ...[
                  const SizedBox(height: 16),
                  const Text('Upload Demo Video', style: textStyleNormal,),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: controller.pickVideo,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Center(
                        child: controller.videoFile.value == null
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload, color: textColor,),
                                  Text('Tap to upload video demo', style: textStyleNormal,),
                                ],
                              )
                            : Text(
                                'Selected: ${controller.videoFile.value!.path.split('/').last} (${controller.videoDuration.value!.inMinutes} min)'),
                      ),
                    ),
                  ),
                  if (controller.errorMessage.value != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(controller.errorMessage.value!, style: const TextStyle(color: Colors.red)),
                    ),
                ],
                // const SizedBox(height: 16),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Text('Duration', style: textStyleNormal,),
                //           TextField(
                //             controller: controller.durationController,
                //             decoration: const InputDecoration(
                //               hintText: 'e.g., 10 min',
                //               border: OutlineInputBorder(),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     const SizedBox(width: 16),
                //     Expanded(
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Text('Difficulty'),
                //           Obx(
                //             () => DropdownButtonFormField<String>(
                //               value: controller.selectedDifficulty.value,
                //               decoration: const InputDecoration(
                //                 border: OutlineInputBorder(),
                //               ),
                //               items: const [
                //                 DropdownMenuItem(value: 'Beginner', child: Text('Beginner')),
                //                 DropdownMenuItem(value: 'Intermediate', child: Text('Intermediate')),
                //                 DropdownMenuItem(value: 'Advanced', child: Text('Advanced')),
                //               ],
                //               onChanged: (value) {
                //                 if (value != null) {
                //                   controller.selectedDifficulty.value = value;
                //                 }
                //               },
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 16),
                const Text('Quick Instructions'),
                TextField(
                  controller: controller.quickInstructionsController,
                  decoration: const InputDecoration(
                    hintText: 'Brief description...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                const Text('Detailed Instructions'),
                TextField(
                  controller: controller.detailedInstructionsController,
                  decoration: const InputDecoration(
                    hintText: 'Step-by-step instructions...',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: Save the drill data, e.g., to a database or state
            Get.back();
            Get.snackbar('Success', 'New Drill Created!');
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}


