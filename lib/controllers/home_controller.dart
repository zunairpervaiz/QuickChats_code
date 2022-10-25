import 'package:demo_application/consts/consts.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  //we'll initialize it later
  late SharedPreferences prefs;

  //creating a varible to access home controller variables in other controlleres
  static HomeController instance = Get.find();

  String username = '';
  String userImage = '';

  //get user details method
  getUsersDetails() async {
    await firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) async {
      username = value.docs[0]['name'];
      userImage = value.docs[0]['image_url'];
      //here we are getting our current user details stored in the value variable
      prefs = await SharedPreferences.getInstance();
      prefs.setStringList('user_details', [
        //store name and image url on index 0 and 1
        value.docs[0]['name'],
        value.docs[0]['image_url']
      ]);
    });
  }

  //execute this method on start
  @override
  void onInit() {
    getUsersDetails();
    super.onInit();
  }
}
