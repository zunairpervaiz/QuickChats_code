import 'package:demo_application/consts/consts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

Widget pickerDialog(context, controller) {
  //setting listicons and titles
  var listTitle = [camera, gallery, cancel];
  var icons = [Icons.camera_alt_rounded, Icons.photo_size_select_actual_rounded, Icons.cancel];
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: const EdgeInsets.all(12),
      color: bgColor,
      child: Column(
        //setting size to min
        mainAxisSize: MainAxisSize.min,
        children: [
          source.text.fontFamily(semibold).white.make(),
          const Divider(),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
                3,
                (index) => ListTile(
                      onTap: () {
                        //setting ontap according to index
                        switch (index) {
                          //ontap of camera
                          case 0:
                            //providing camera source
                            Get.back();
                            controller.pickImage(context, ImageSource.camera);

                            break;
                          //ontap of gallery
                          case 1:
                            //providing gallery source
                            Get.back();
                            controller.pickImage(context, ImageSource.gallery);
                            break;
                          //ontap of cancel
                          case 2:
                            //close dialog
                            Get.back();
                            break;
                        }
                      },
                      //getting icons from our list
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                      ),
                      //getting titles from our list
                      title: listTitle[index].text.white.make(),
                    )),
          ),
        ],
      ),
    ),
  );
}
