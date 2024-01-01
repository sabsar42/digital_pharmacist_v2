import 'package:digi_pharma_app_test/ForgotPassword/NewPassword.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:digi_pharma_app_test/Registration/signUpScreen.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Verification", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () { Navigator.pop(context); }, icon: Icon(Icons.arrow_back), color: Colors.blue,
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            child: Text("Enter the OTP we sent to your Email", style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PinCodeTextField(appContext: context,
                length: 5,
              controller: controller,
              cursorHeight: 30,
              enableActiveFill: true,
              cursorColor: Colors.black12,

              mainAxisAlignment: MainAxisAlignment.center,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.circle,
                fieldWidth: 60,
                selectedFillColor: Colors.black12,
                inactiveColor:Colors.black12,
                inactiveFillColor: Colors.black12,
                activeColor: Colors.grey,
                activeFillColor: Colors.grey,
                selectedColor: Colors.grey,
                borderWidth: 100,
                borderRadius: BorderRadius.circular(5)
              ),

            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You didn't receive the code?"),
              TextButton(onPressed: (){}, child: Text("Resend"))
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return NewPassword();
                      }),
                    );
                  },
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10.0,
                    backgroundColor: Color.fromRGBO(19, 68, 130, 1.0),
                    fixedSize:
                    Size(350.0, 60.0),
                  ),
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}

