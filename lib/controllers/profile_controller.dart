// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  //text editing controllers
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var phoneController = TextEditingController();

  //variables for image
  var imgpath = ''.obs;
  var imglink = '';

  //update profile method
  updateProfile(context) async {
    //setting store variable to the document of our current user
    var store = firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);
    //lets update the data now
    await store.set({
      'name': nameController.text,
      'about': aboutController.text,
      //we are not updating phone controller because it cant be changed
      //update the image_url field
      //it will be empty if image is not selected
      'image_url': imglink
    }, SetOptions(merge: true));
    //show toast when done
    VxToast.show(context, msg: "Profile updated successfully!");
  }

  //image picking method
  pickImage(context, source) async {
    //get permission from user
    await Permission.photos.request();
    await Permission.camera.request();
    //getting state of our permission to handle

    var status = await Permission.photos.status;

    //handle status
    if (status.isGranted) {
      //when status is granted
      try {
        //source will be according to user choice
        //picking image and saving in img variable
        final img = await ImagePicker().pickImage(source: source, imageQuality: 80);
        //setting our variable equal to this image path
        imgpath.value = img!.path;
        //show toast after picking image
        VxToast.show(context, msg: "Image selected");
      } on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    } else {
      //when status is not granted
      VxToast.show(context, msg: "Permission denied");
    }
  }

  //lets upload the image to fire storage

  uploadImage(context) async {
    VxToast.show(context, msg: "Uploading started...");
    //getting name of the selected file
    //importing path.dart for this basename
    //add the path of selected image
    var name = basename(imgpath.value);
    //setting destination of file on firestorage
    //it will create a path in storage with images folder
    //and in that folder it will create a folder with current user id
    //and in that folder it will store our file
    var destination = 'images/${currentUser!.uid}/$name';
    //trigering firestorage to save our file
    //adding the destination to create file
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    //uploading our file
    await ref.putFile(File(imgpath.value));
    //getting url of our uploaded file and saving it into our imglink variable
    var d = await ref.getDownloadURL();

    imglink = d;
    updateProfile(context);
  }
}
