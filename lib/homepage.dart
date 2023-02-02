import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool canShow = false;
  var temp;

  @override
  void dispose() {
    phoneNumber.dispose();
    otp.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Phone Auth"),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextField("PhNo", phoneNumber, Icons.phone, context),
            canShow
                ? buildTextField("OTP", otp, Icons.timer, context)
                : const SizedBox(),
            !canShow ? buildSendOTPBtn("Send OTP") : buildSubmitBtn("Submit"),
          ],
        ),
      ),
    );
  }

  Widget buildSendOTPBtn(String text) => ElevatedButton(
    onPressed: () async {
      setState(() {
        canShow = !canShow;
      });
      temp = await FirebaseAuthentication().sendOTP(phoneNumber.text);
    },
    child: Text(text),
  );

  Widget buildSubmitBtn(String text) => ElevatedButton(
    onPressed: () {
      FirebaseAuthentication().authenticateMe(temp, otp.text);
    },
    child: Text(text),
  );

  Widget buildTextField(
      String labelText,
      TextEditingController textEditingController,
      IconData prefixIcons,
      BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(10.00),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextFormField(
            obscureText: labelText == "OTP" ? true : false,
            controller: textEditingController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(5.5),
              ),
              prefixIcon: Icon(prefixIcons, color: Colors.blue),
              hintText: labelText,
              hintStyle: const TextStyle(color: Colors.blue),
              filled: true,
              fillColor: Colors.blue[50],
            ),
          ),
        ),
      );
}

class FirebaseAuthentication {
  String phoneNumber = "";

  sendOTP(String phoneNumber) async {
    this.phoneNumber = phoneNumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      '+91$phoneNumber',
    );
    printMessage("OTP Sent to +91 $phoneNumber");
    return confirmationResult;
  }

  authenticateMe(ConfirmationResult confirmationResult, String otp) async {
    UserCredential userCredential = await confirmationResult.confirm(otp);
    userCredential.additionalUserInfo!.isNewUser
        ? printMessage("Successful Authentication")
        : printMessage("User already exists");
  }

  printMessage(String msg) {
    debugPrint(msg);
  }
}