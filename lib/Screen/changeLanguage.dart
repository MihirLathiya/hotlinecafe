import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Change_language extends StatefulWidget {
  final lang;
  const Change_language({Key? key, this.lang}) : super(key: key);

  @override
  State<Change_language> createState() => _Change_languageState();
}

class _Change_languageState extends State<Change_language> {
  String language = '';
  List lang = [
    "English",
    "Hindi",
    "Urdu",
    "Arabic",
    "Spanish",
    "French",
    "Rassian"
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
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
            '$language',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 5, 16, 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(
                              width: 1, color: Color(0xff373743)))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Your language',
                            style: TextStyle(color: Color(0Xff81818A)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${widget.lang}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Select language',
                  style: TextStyle(color: Color(0Xff81818A)),
                ),
                SizedBox(
                  height: 5,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: lang.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: gettxt("${lang[index]}"),
                    );
                  },
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 10),
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
      ),
    );
  }
}

gettxt(String lag) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          lag,
          style: TextStyle(color: Colors.white),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Divider(
          color: Color(0xff373743),
        ),
      )
    ],
  );
}
