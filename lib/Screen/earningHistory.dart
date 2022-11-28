import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Earning_history extends StatefulWidget {
  const Earning_history({Key? key}) : super(key: key);

  @override
  State<Earning_history> createState() => _Earning_historyState();
}

class _Earning_historyState extends State<Earning_history> {
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
            'Earning History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) => GetHistory(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

GetHistory() {
  return Builder(
    builder: (context) {
      return GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Chat_Person()));
        },
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Call with @kierrasaris',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "20 May 2021, 2:20 AM",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0Xff9C9797),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "+250",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.green,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Image.asset('images/Vector 76.png'),
                    ],
                  )
                ],
              ),
              Divider(
                color: Colors.white54,
              ),
            ],
          ),
        ),
      );
    },
  );
}
