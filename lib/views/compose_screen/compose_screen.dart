import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/services/store_services.dart';
import 'package:demo_application/views/chat_screen.dart/chat.dart';
import 'package:get/get.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: "New Message".text.fontFamily(semibold).make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            //make top two corners rounded
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            color: Colors.white),
        //we are using stream builder here for realtime changes
        child: StreamBuilder(
          //set stream function
          stream: StoreServices.getAllUsers(),

          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //but you notices that we got a read screen just for a mili second
            //lets fix that
            if (!snapshot.hasData) {
              //if data is not loaded yet
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bgColor),
                ),
              );
            } else {
              //when data is loaded
              //you can see we are not getting that red screen now
              //we are using grid view here
              return GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                //here we are coverting our snapshot into a map for easy access to all the docs
                children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                  //setting our each doc into a variable for easy access
                  var doc = snapshot.data!.docs[index];
                  //wrapping in card to get the elevation
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: bgColor.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      //lets see if our data is coming or not
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage("${doc['image_url']}"),
                              ),
                              20.widthBox,
                              "${doc['name']}".text.fontFamily(semibold).color(txtColor).make()
                            ],
                          ),
                          10.heightBox,
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(12),
                                  primary: bgColor,
                                ),
                                onPressed: () {
                                  //on tap of this button we are going to send our user to the chat screen
                                  //but we want to change the name of the user
                                  Get.to(
                                    () => const ChatScreen(),
                                    transition: Transition.downToUp,
                                    arguments: [
                                      //but here in compose chat screen we have implemented everything so lets add
                                      //real values
                                      doc['name'],
                                      doc['id'],
                                    ],
                                  );
                                },
                                icon: const Icon(Icons.message),
                                label: "Message".text.make()),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
