import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:labfinal/Authentication/login.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../Component/Loading.dart';
import 'firebaseAuthentication.dart';

class OTPVerification extends StatefulWidget {
OTPVerification({required this.pakAcedemy,required this.email,required this.password,required this.phone});
final String pakAcedemy;
final String email;
final String password;
final String phone;
bool isloading=false;

  @override
  _OTPVerificationState createState() => _OTPVerificationState();
}

class _OTPVerificationState extends State<OTPVerification> {
  EmailAuth emailAuth =  new EmailAuth(sessionName: "Fee Management App");
  OtpFieldController _otpFieldController=OtpFieldController();
  bool isloading=false;
  void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: widget.email, otpLength: 5
    );
  }
  bool verify() {
    bool result =emailAuth.validateOtp(
        recipientMail: widget.email,
        userOtp: _otpFieldController.toString());
    return result;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify email"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body:  isloading?Center(child: saveloading,):Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Enter Code Here",style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple
            ),),
            SizedBox(
              height: 20,
            ),
            OTPTextField(
              otpFieldStyle: OtpFieldStyle(
                borderColor: Colors.deepPurple,
                focusBorderColor: Colors.deepPurple,
                enabledBorderColor: Colors.deepPurple,
              ),
              controller: _otpFieldController,
              length: 5,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 60,
              style: TextStyle(
                  fontSize: 17
              ),
              textFieldAlignment: MainAxisAlignment.spaceEvenly,
              fieldStyle: FieldStyle.box,
              onChanged: (value){

              },
              onCompleted: (value){
                var result=verify();
                if(result==true){
                  setState(() {
                    isloading=true;

                  });
                  createAccount(widget.pakAcedemy, widget.email, widget.password).then((user){
                    if(user!=null){
                      FirebaseFirestore.instance.collection("Acedemy").doc(user.uid).collection("user").add({
                        'acedemy':widget.pakAcedemy,
                        'phone':widget.phone,
                      });
                      setState(() {
                        isloading=false;
                        const snackBar = SnackBar(
                          content: Text('Create Account Successfully'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      });

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                    }
                    else{
                      setState(() {
                        isloading=false;
                      });
                      const snackBar = SnackBar(
                        content: Text('Failed to create Account'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    }
                  });
                }
                else{
                  const snackBar = SnackBar(
                    content: Text('Invalid Code'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

              },

            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  sendOtp();
                }, child: Text("Resend"),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple
                ),),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
