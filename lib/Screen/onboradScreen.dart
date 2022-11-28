import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/auth/log_in.dart';

import '../common/Style.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 5.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      height: 500.0,
                      child: PageView(
                        physics: ClampingScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 30.0),
                                Text(
                                  'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit.',
                                  style: kSubtitleStyle,
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed cras potenti nibh ut at tristique tempus. Hendrerit amet habitant proin faucibus mattis.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(
                                      0xff81818A,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 30.0),
                                Text(
                                  'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit.',
                                  style: kSubtitleStyle,
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed cras potenti nibh ut at tristique tempus. Hendrerit amet habitant proin faucibus mattis.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff81818A))),
                                SizedBox(
                                  height: 70,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 30.0),
                                Text(
                                  'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit.',
                                  style: kSubtitleStyle,
                                ),
                                SizedBox(height: 15.0),
                                Text(
                                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed cras potenti nibh ut at tristique tempus. Hendrerit amet habitant proin faucibus mattis.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xff81818A))),
                                SizedBox(
                                  height: 70,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicator(),
                    ),
                    _currentPage != _numPages - 1
                        ? Expanded(
                            child: Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          LogInScreen()));
                                        },
                                        child: Text(
                                          "Skip",
                                          style: TextStyle(
                                              color: Color(0xff81818A)),
                                        )),
                                    Container(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            backgroundColor: Color(0xffEE6D41)),
                                        onPressed: () {
                                          _pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Next"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: _currentPage == _numPages - 1
              ? Container(
                  color: Colors.black,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Color(0xffEE6D41)),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => LogInScreen(),
                          ),
                        );
                      },
                      child: Text("Get Started"),
                    ),
                  ),
                )
              : Text(''),
        );
      }),
    );
  }
}
