import 'package:demo_application/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:demo_application/consts/consts.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: letsconnect.text.color(txtColor).fontFamily(bold).make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              //username field
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return "Please enter your username";
                          }
                          return null;
                        },
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: lightgreyColor,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: lightgreyColor),
                            ),
                            prefixIcon: const Icon(
                              Icons.phone_android_rounded,
                              color: btnColor,
                            ),
                            alignLabelWithHint: true,
                            labelText: "Username",
                            hintText: " eg. Alex",
                            labelStyle: const TextStyle(
                              color: txtColor,
                              fontFamily: semibold,
                            )),
                      ),
                      10.heightBox,
                      //phone field
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 9) {
                            return "Please enter your phone number";
                          }
                          return null;
                        },
                        controller: controller.phoneController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: lightgreyColor,
                                )),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: lightgreyColor),
                            ),
                            prefixIcon: const Icon(
                              Icons.phone_android_rounded,
                              color: btnColor,
                            ),
                            alignLabelWithHint: true,
                            labelText: "Phone Number",
                            prefixText: "+92",
                            hintText: " eg. 1234567890",
                            labelStyle: const TextStyle(
                              color: txtColor,
                              fontFamily: semibold,
                            )),
                      ),
                    ],
                  )),
              10.heightBox,
              otp.text.fontFamily(semibold).gray400.make(),

              //otpField
              Obx(
                () => Visibility(
                  visible: controller.isOtpSent.value,
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          6,
                          (index) => SizedBox(
                                width: 56,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.otpController[index],
                                  cursorColor: btnColor,
                                  onChanged: (value) {
                                    if (value.length == 1 && index <= 5) {
                                      FocusScope.of(context).nextFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  style: const TextStyle(
                                    fontFamily: bold,
                                    color: btnColor,
                                  ),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: bgColor)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: bgColor)),
                                    hintText: "*",
                                  ),
                                ),
                              )),
                    ),
                  ),
                ),
              ),

              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: context.screenWidth - 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: btnColor,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        if (controller.isOtpSent.value == false) {
                          controller.isOtpSent.value = true;
                          await controller.sendOtp();
                        } else {
                          await controller.verifyOtp(context);
                        }
                      }
                    },
                    child: continueText.text.fontFamily(semibold).make(),
                  ),
                ),
              ),
              30.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
