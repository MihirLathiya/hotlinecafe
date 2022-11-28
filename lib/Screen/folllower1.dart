import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'viewProfile.dart';

class Followers extends StatefulWidget {
  const Followers({Key? key}) : super(key: key);

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> with TickerProviderStateMixin {
  bool _hasBeenPressed = false;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return MaterialApp(
      home: Builder(
        builder: (context) {
          return Scaffold(
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
                  'kierrasaris564',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                )),
            body: Column(
              children: [
                TabBar(
                  indicatorColor: Color(0xffE76944),
                  unselectedLabelColor: Colors.grey,
                  controller: _tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        'Followings',
                        style: TextStyle(
                            color: Color(0Xff9A9892),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Followers',
                        style: TextStyle(
                            color: Color(0Xff9A9892),
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.all(5),
                        itemCount: 10,
                        itemBuilder: (context, index) => GetFollowers(),
                      ),
                      ListView.builder(
                        padding: EdgeInsets.all(5),
                        itemCount: 15,
                        itemBuilder: (context, index) => GetFollowers(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

GetFollowers() {
  return Builder(
    builder: (context) {
      return GestureDetector(
        onTap: () {
          Get.to(() => View_profile(profileId: '60'));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 25,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Justin Arcand',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      Text(
                        "@cassierandolph43",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0Xff9C9797),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  buttonColor: Color(0xffE76944),
                  child: ElevatedButton(
                    onPressed: () => {},
                    // textColor: Colors.white,
                    // color: _hasBeenPressed ? Colors.blue : Colors.black,
                    child: Text(
                      "Follow",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
