import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Change_mobile extends StatefulWidget {
  final number;
  const Change_mobile({Key? key, this.number}) : super(key: key);

  @override
  State<Change_mobile> createState() => _Change_mobileState();
}

class _Change_mobileState extends State<Change_mobile> {
  TextEditingController mobile = TextEditingController();

  @override
  void initState() {
    mobile.text = widget.number;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 70.h,
          centerTitle: true,
          backgroundColor: Colors.black,
          leading: IconButton(
            splashRadius: 20,
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            'Change mobile',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'We will send an OTP on your mobile number for verification purpose.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0Xff81818A)),
              ),
              SizedBox(
                height: 24.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Mobile number',
                  style: TextStyle(color: Color(0Xff81818A)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15, top: 5),
                height: 48,
                child: TextField(
                  controller: mobile,
                  obscureText: false,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81818A)),
                        borderRadius: BorderRadius.circular(30)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff81818A)),
                        borderRadius: BorderRadius.circular(30)),
                    hintStyle: TextStyle(color: Color(0xff81818A)),
                    prefixIcon: Icon(
                      Icons.call,
                      color: Color(0xff81818A),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10, top: 10),
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      primary: Color(0xffEE6D41)),
                  onPressed: () {
                    Get.back();
                    // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OtpScreen() ));
                  },
                  child: Text("Verify"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
