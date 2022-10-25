import 'package:demo_application/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "REST API Tutorial",
      home: UsersApp(),
    );
  }
}

class UsersApp extends StatefulWidget {
  const UsersApp({Key? key}) : super(key: key);

  @override
  State<UsersApp> createState() => _UsersAppState();
}

class _UsersAppState extends State<UsersApp> {
  late User data;
  bool isloading = false;
  @override
  void initState() {
    readLocalJson();
    super.initState();
  }

  readLocalJson() async {
    isloading = true;
    var d = await rootBundle.loadString("assets/json.json");
    data = userFromJson(d);
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOCAL JSON"),
      ),
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(data.name.toString()),
                  Text(data.age.toString()),
                  Text(data.married.toString()),
                  Text(data.kids.toString()),
                  Row(
                    children: List.generate(data.hobbies!.length, (index) {
                      return Text(data.hobbies![index].toString());
                    }).toList(),
                  )
                ],
              ),
            ),
    );
  }
}
