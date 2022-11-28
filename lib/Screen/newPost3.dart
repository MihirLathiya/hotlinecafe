import 'package:flutter/material.dart';
import 'package:get/get.dart';

class New_Post extends StatefulWidget {
  const New_Post({Key? key}) : super(key: key);

  @override
  State<New_Post> createState() => _New_PostState();
}

class _New_PostState extends State<New_Post> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
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
            'New Short',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: Colors.white24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Image.asset('images/Photo Square.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: TextField(
                      style: TextStyle(
                          color: Colors.white24,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                      maxLines: 3,
                      cursorColor: Colors.white24,
                      autofocus: false,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintText: "Write caption here...",
                          hintStyle: TextStyle(
                              color: Colors.white24,
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 20.0, left: 16, right: 16),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  child: ButtonTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                    buttonColor: Color(0xffE76944),
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Influencer()));
                      },
                      // textColor: Colors.white,
                      child: Text(
                        "Post",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
