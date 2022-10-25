import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/controllers/profile_controller.dart';
import 'package:demo_application/services/store_services.dart';
import 'package:demo_application/views/profile_screen/components/picker_dialog.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //init profile controller
    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: profile.text.fontFamily(bold).make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          //save button to update profile
          TextButton(
              onPressed: () async {
                //put upload image method here
                if (controller.imgpath.isEmpty) {
                  //if image is selected then only update the values
                  controller.updateProfile(context);
                } else {
                  //update both profile image and values
                  //lets wait for our image to be uploaded first then
                  //execute the updateProfile method
                  await controller.uploadImage(context);
                }
              },
              child: "Save".text.white.fontFamily(semibold).make())
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),

        //init FutureBuilder
        child: FutureBuilder(
          //passing current user id to the function to get the user document in firestore
          future: StoreServices.getUser(currentUser!.uid),

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //if data is loaded show the widget
            if (snapshot.hasData) {
              //setting snapshot into a variable for each access
              //here doc[0] because it will contain only one document
              var data = snapshot.data!.docs[0];

              //setting values to the text controllers
              controller.nameController.text = data['name'];
              controller.phoneController.text = data['phone'];
              controller.aboutController.text = data['about'];

              return Column(
                children: [
                  //wraping our widget in OBX
                  //now it will update the UI as soon as we select the image

                  Obx(
                    () => CircleAvatar(
                      radius: 80,
                      backgroundColor: btnColor,
                      child: Stack(
                        children: [
                          //when imgpath is empty and data['image_url'] is empty
                          controller.imgpath.isEmpty && data['image_url'] == ''
                              ? Image.asset(
                                  icUser,
                                  color: Colors.white,
                                )
                              //when imgpath is not empty means file is selected
                              //but it wont update on its own. so we have to make it
                              //lets design the image widget using velocity x container

                              : controller.imgpath.isNotEmpty
                                  ? Image.file(
                                      File(controller.imgpath.value),
                                    ).box.roundedFull.clip(Clip.antiAlias).make()
                                  :
                                  //show network image form document
                                  Image.network(
                                      data['image_url'],
                                    ).box.roundedFull.clip(Clip.antiAlias).make(),

                          Positioned(
                            right: 0,
                            bottom: 20,
                            //show dialog on tap of this button
                            child: CircleAvatar(
                              backgroundColor: btnColor,
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                //using velocityX ontap here
                              ).onTap(() {
                                //using getx dialog and passing our widget
                                //passing context and our controller to the widget
                                Get.dialog(pickerDialog(context, controller));
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  20.heightBox,
                  const Divider(color: btnColor, height: 1),
                  10.heightBox,
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: TextFormField(
                      //setting controller
                      controller: controller.nameController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        label: "Name".text.make(),
                        isDense: true,
                        labelStyle: const TextStyle(fontFamily: semibold, color: Colors.white),
                      ),
                    ),
                    subtitle: namesub.text.fontFamily(semibold).gray400.make(),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: TextFormField(
                      controller: controller.aboutController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        label: "About".text.make(),
                        isDense: true,
                        labelStyle: const TextStyle(fontFamily: semibold, color: Colors.white),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    title: TextFormField(
                      controller: controller.phoneController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      readOnly: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: "Phone".text.make(),
                        isDense: true,
                        labelStyle: const TextStyle(fontFamily: semibold, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              //if data is not loaded yet show progress indicator
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
