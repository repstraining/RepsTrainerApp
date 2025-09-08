import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reps_trainer_app/controllers/playbook_controller.dart';
import 'package:reps_trainer_app/utils/colors.dart';
import 'package:reps_trainer_app/utils/fonts.dart';
import 'package:reps_trainer_app/views/playbook/drills/drills.dart';
import 'package:reps_trainer_app/views/playbook/plans/plans.dart';




class PlaybookScreen extends StatefulWidget {
  const PlaybookScreen({super.key});

  @override
  State<PlaybookScreen> createState() => _PlaybookScreenState();
}

class _PlaybookScreenState extends State<PlaybookScreen> {
  @override
  Widget build(BuildContext context) {
    final PlaybookController controller = Get.put(PlaybookController());

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Playbook', style: textStyleH1Bold,),
        centerTitle: false,
        actions: [
           IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.purple),
              onPressed: controller.createItem,
            
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => TextField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  hintText: controller.searchHint,
                  prefixIcon: const Icon(Icons.search, color: Colors.grey,),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  filled: true,
                  fillColor: backgroundColor,
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                      borderRadius: BorderRadius.circular(30.0),
                  )
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Obx(
              () => Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[400]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.selectedTab.value = 0;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),),
                                color: controller.selectedTab.value == 0
                              ? Colors.grey[200]
                              : null,
                              ),
                          child: Center(child: Text('Plans', style: TextStyle(color: primaryColor),)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            controller.selectedTab.value = 1;
                          });

                        } ,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10),),
                                color: controller.selectedTab.value == 1
                              ? Colors.grey[200]
                              : null,
                              ),
                          child: Center(child: Text('Drills',style: TextStyle(color: primaryColor),)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
         
          Expanded(
            child: Obx(
              () => controller.selectedTab.value == 0
                  ? const PlansWidget()
                  : const DrillsWidget(),
            ),
          ),
        ],
      ),
    );
  }
}



