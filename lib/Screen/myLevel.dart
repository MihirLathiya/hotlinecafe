import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progresso/progresso.dart';

class My_level extends StatefulWidget {
  const My_level({Key? key}) : super(key: key);

  @override
  State<My_level> createState() => _My_levelState();
}

class _My_levelState extends State<My_level> {
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
            'My level',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                color: Color(0xff81818A),
                child: Container(
                  margin: EdgeInsets.fromLTRB(8, 10, 8, 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    decoration: ShapeDecoration(
                                        color: Color(0xffEB5757),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: const BorderSide(
                                                width: 1,
                                                color: Colors.transparent))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        children: [
                                          Image.asset('images/1040230 1.png'),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            'Lv 2',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    )),
                                Row(
                                  children: [
                                    Image.asset(
                                      'images/Coin.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      '3255',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('images/1959460 1.png'),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Image.asset('images/Coin.png',height: 20,width: 20,),

                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      '10,000',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black26),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Progresso(
                            progress: 0.35,
                            progressColor: Colors.blue,
                            backgroundColor: Color(0xff373743),
                            progressStrokeCap: StrokeCap.round,
                            backgroundStrokeCap: StrokeCap.round),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Top up 7,000 coins more to level up',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black26),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 5, 16, 10),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Color(0xff81818A),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                )),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        'Level Targets',
                        style: TextStyle(
                            color: Color(0XffF8AB17),
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      color: Color(0xff81818A),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Level',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Top-up/Target',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              decoration: ShapeDecoration(
                                  color: Color(0xff81818A),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          width: 1,
                                          color: Colors.transparent))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Image.asset('images/1040230 1.png'),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Lv 0',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              )),
                          Text(
                            '  0    ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xff81818A),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                decoration: ShapeDecoration(
                                    color: Color(0xffEB5757),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            width: 1,
                                            color: Colors.transparent))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Image.asset('images/1040230 1.png'),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'Lv 1',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                )),
                            Text(
                              '10,000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              decoration: ShapeDecoration(
                                  color: Color(0xffEB5757),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          width: 1,
                                          color: Colors.transparent))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Image.asset('images/1040230 1.png'),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Lv 2',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              )),
                          Text(
                            '30,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xff81818A),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                decoration: ShapeDecoration(
                                    color: Color(0xffEB5757),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            width: 1,
                                            color: Colors.transparent))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Image.asset('images/1040230 1.png'),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'Lv 3',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                )),
                            Text(
                              '10,000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              decoration: ShapeDecoration(
                                  color: Color(0xffEB5757),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          width: 1,
                                          color: Colors.transparent))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Image.asset('images/1040230 1.png'),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Lv 4',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              )),
                          Text(
                            '30,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xff81818A),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                decoration: ShapeDecoration(
                                    color: Color(0xffEB5757),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            width: 1,
                                            color: Colors.transparent))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Image.asset('images/1040230 1.png'),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'Lv 5',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                )),
                            Text(
                              '10,000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              decoration: ShapeDecoration(
                                  color: Color(0xffEB5757),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          width: 1,
                                          color: Colors.transparent))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Image.asset('images/1040230 1.png'),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Lv 6',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              )),
                          Text(
                            '30,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xff81818A),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                decoration: ShapeDecoration(
                                    color: Color(0xffEB5757),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            width: 1,
                                            color: Colors.transparent))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Image.asset('images/1040230 1.png'),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'Lv 7',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                )),
                            Text(
                              '10,000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              decoration: ShapeDecoration(
                                  color: Color(0xffEB5757),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          width: 1,
                                          color: Colors.transparent))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Image.asset('images/1040230 1.png'),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Lv 8',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              )),
                          Text(
                            '30,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Color(0xff81818A),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                decoration: ShapeDecoration(
                                    color: Color(0xffEB5757),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            width: 1,
                                            color: Colors.transparent))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                      Image.asset('images/1040230 1.png'),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        'Lv 9',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10),
                                      ),
                                    ],
                                  ),
                                )),
                            Text(
                              '10,000',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              decoration: ShapeDecoration(
                                  color: Color(0xffEB5757),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          width: 1,
                                          color: Colors.transparent))),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Image.asset('images/1040230 1.png'),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Lv 10',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                    ),
                                  ],
                                ),
                              )),
                          Text(
                            '10,000',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 25),
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      primary: Color(0xff494C54)),
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OtpScreen() ));
                  },
                  child: Text("Top Up"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
