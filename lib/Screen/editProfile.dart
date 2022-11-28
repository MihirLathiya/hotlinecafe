import 'dart:developer';
import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hotlinecafee/Preference/preference.dart';
import 'package:hotlinecafee/ViewModel/update_profile_view_model.dart';
import 'package:hotlinecafee/common/chat_commons.dart';
import 'package:hotlinecafee/common/snackbar.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/request_model/update_profile_req_model.dart';
import 'package:hotlinecafee/model/response_model/update_profile_res_model.dart';
import 'package:hotlinecafee/model/services/chat_room_service.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../ViewModel/view_profile_view_model.dart';
import 'changeMobile.dart';

class Edit_profile extends StatefulWidget {
  final name;
  final region;
  final userName;
  final bio;
  final emailId;
  final number;
  final language;
  final gender;
  final userImages;
  final dob;
  const Edit_profile(
      {Key? key,
      this.name,
      this.userName,
      this.bio,
      this.emailId,
      this.number,
      this.language,
      this.gender,
      this.dob,
      this.userImages,
      this.region})
      : super(key: key);

  @override
  State<Edit_profile> createState() => _Edit_profileState();
}

class _Edit_profileState extends State<Edit_profile> {
  UpdateProfileViewModel updateProfileViewModel =
      Get.put(UpdateProfileViewModel());
  UpdateProfileRequestModel updateProfileRequest = UpdateProfileRequestModel();

  /// View Profile
  // ViewProfileRequestModel viewProfileRequest = ViewProfileRequestModel();
  ViewProfileViewModel viewProfileViewModel = Get.put(ViewProfileViewModel());

  // Initial Selected Value
  String dropdownvalue = 'Male';
  // List of items in our dropdown menu
  var items = [
    'Male',
    'Female',
  ];

  TextEditingController name = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController region = TextEditingController();
  String number = '123-456-78-90';
  String lang = 'Hindi';
  String? images;

  File? userImage;
  final picker = ImagePicker();
  pickImage() async {
    var pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        userImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    name.text = widget.name;
    userName.text = widget.userName;
    bio.text = widget.bio;
    emailId.text = widget.emailId ?? "abc@gmail.com";
    number = widget.number;
    language.text = widget.language;
    region.text = widget.region;
    dropdownvalue = widget.gender;
    dob.text = widget.dob.toString().split(" ")[0];
    images = widget.userImages;
    super.initState();
  }

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
            'Edit profile',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 25),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            height: 100.h,
                            width: 100.h,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: userImage == null
                                ? Image.network(
                                    images == null || images == ''
                                        ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png'
                                        : '${images}',
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    userImage!,
                                    height: 100.h,
                                    width: 100.h,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Baseline(
                            baseline: 9,
                            baselineType: TextBaseline.alphabetic,
                            child: GestureDetector(
                              onTap: () {
                                pickImage();
                              },
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: ShapeDecoration(
                                  color: Color(0xffEB5757),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0),
                                    side: const BorderSide(
                                      width: 1,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 23,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Name',
                      style: TextStyle(color: Color(0Xff81818A)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    height: 48,
                    child: TextField(
                      obscureText: false,
                      controller: name,
                      keyboardType: TextInputType.name,
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
                          Icons.person_pin,
                          color: Color(0xff81818A),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Username',
                      style: TextStyle(color: Color(0Xff81818A)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    height: 48,
                    child: TextField(
                      obscureText: false,
                      controller: userName,
                      keyboardType: TextInputType.text,
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
                          Icons.person,
                          color: Color(0xff81818A),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Bio',
                      style: TextStyle(color: Color(0Xff81818A)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    child: TextField(
                      maxLines: 5,
                      obscureText: false,
                      controller: bio,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(30)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xff81818A)),
                            borderRadius: BorderRadius.circular(30)),
                        hintStyle: TextStyle(color: Color(0xff81818A)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Email ID',
                      style: TextStyle(color: Color(0Xff81818A)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    height: 48,
                    child: TextField(
                      obscureText: false,
                      controller: emailId,
                      keyboardType: TextInputType.emailAddress,
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
                          Icons.email,
                          color: Color(0xff81818A),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Mobile number',
                      style: TextStyle(color: Color(0Xff81818A)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    height: 48,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0Xff81818A),
                        ),
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.call,
                            color: Color(0xff81818A),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "${number}",
                            style: TextStyle(
                              color: Color(0xffffffff),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Get.to(() => Change_mobile(
                                    number: number,
                                  ));
                            },
                            child: Icon(
                              Icons.navigate_next,
                              color: Color(0xff81818A),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Language',
                      style: TextStyle(color: Color(0Xff81818A)),
                    ),
                  ),
                  // Container(
                  //     margin: EdgeInsets.only(bottom: 15, top: 5),
                  //     height: 48,
                  //     decoration: BoxDecoration(
                  //         border: Border.all(
                  //           color: Color(0Xff81818A),
                  //         ),
                  //         borderRadius: BorderRadius.circular(100)),
                  //     child: Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 15.w),
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.translate,
                  //             color: Color(0xff81818A),
                  //           ),
                  //           SizedBox(
                  //             width: 5.w,
                  //           ),
                  //           Text(
                  //             "${lang}",
                  //             style: TextStyle(
                  //               color: Color(0xffffffff),
                  //             ),
                  //           ),
                  //           Spacer(),
                  //           InkWell(
                  //             borderRadius: BorderRadius.circular(20),
                  //             onTap: () {
                  //               Get.to(() => Change_language(
                  //                     lang: lang,
                  //                   ));
                  //             },
                  //             child: Icon(
                  //               Icons.navigate_next,
                  //               color: Color(0xff81818A),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     )),

                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    height: 48,
                    child: TextField(
                      obscureText: false,
                      controller: language,
                      keyboardType: TextInputType.emailAddress,
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
                          Icons.translate,
                          color: Color(0xff81818A),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Region',
                      style: TextStyle(color: Color(0Xff81818A)),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    height: 48,
                    child: TextField(
                      onTap: () {
                        showCountryPicker(
                          context: context,

                          showPhoneCode:
                              false, // optional. Shows phone code before the country name.
                          onSelect: (Country country) {
                            setState(() {
                              region.text = country.displayName
                                  .split(' ')
                                  .first
                                  .toString();
                            });
                            print('Select country: ${region.text}');
                          },
                        );
                      },
                      obscureText: false,
                      controller: region,
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
                          Icons.south_america,
                          color: Color(0xff81818A),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Gender',
                      style: TextStyle(color: Color(0Xff81818A)),
                    ),
                  ),
                  Container(
                    height: 55,
                    margin: EdgeInsets.only(bottom: 15, top: 5),
                    child: Center(
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.black,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff81818A), width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff81818A),
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xff81818A), width: 1),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.white12,
                        ),
                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Date of birth',
                      style: TextStyle(color: Color(0Xff81818A)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 25, top: 5),
                    height: 48,
                    child: TextField(
                      controller: dob,
                      obscureText: false,
                      keyboardType: TextInputType.text,
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
                          Icons.cake,
                          color: Color(0xff81818A),
                        ),
                        suffixIcon: Icon(
                          Icons.navigate_next,
                          color: Color(0xff81818A),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          primary: Color(0xffEE6D41)),
                      onPressed: () {
                        updateProfileData();
                        // Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OtpScreen() ));
                      },
                      child: Text("Update"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateProfileData() async {
    if (userImage != null) {
      var request = http.MultipartRequest('POST',
          Uri.parse('https://irisinformatics.net/dating/wb/update_profile'));
      request.fields.addAll({
        'user_id': PreferenceManager.getUserId(),
        'name': name.text,
        'username': userName.text,
        'bio': bio.text,
        'email': emailId.text,
        'language': language.text,
        'dob': dob.text,
        'region': region.text
      });
      request.files.add(await http.MultipartFile.fromPath(
          'profile_pic', '${userImage!.path}'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());

        await viewProfileViewModel.viewProfileViewModel(model: {
          "user_id": PreferenceManager.getUserId(),
          "profile_id": PreferenceManager.getUserId()
        });
        Get.back();
        CommonSnackBar.commonSnackBar(message: 'Profile update successfully');

        // ViewProfileResponseModel viewProfileResponseModel =
        //     viewProfileViewModel.apiResponse.data;
        String? ImageUrl = await uploadFile(
            file: userImage, filename: '${PreferenceManager.getUserId()}.png');
        log('ImageUrl ${ImageUrl}');
        PreferenceManager.setName(name.text);
        PreferenceManager.setUserName(userName.text);
        PreferenceManager.setUserImage(widget.userImages);
        firebaseFirestore
            .collection('user')
            .doc(PreferenceManager.getUserId())
            .update({
          'username': userName.text,
          'userEmail': emailId.text,
          'userImage': ImageUrl!.trim()
        });
      } else {
        print(response.reasonPhrase);
        CommonSnackBar.commonSnackBar(
            message: viewProfileViewModel.apiResponse.message);
      }
    } else {
      if (emailId.text.isNotEmpty && language.text.isNotEmpty) {
        updateProfileRequest.userId = PreferenceManager.getUserId();
        updateProfileRequest.name = name.text.trim();
        updateProfileRequest.profilePic = "${widget.userImages}";
        updateProfileRequest.language = language.text.trim();
        updateProfileRequest.dob = dob.text.trim();
        updateProfileRequest.email = emailId.text.trim();
        updateProfileRequest.username = userName.text.trim();
        updateProfileRequest.bio = bio.text.trim();
        updateProfileRequest.region = region.text.trim();

        await updateProfileViewModel.updateProfileViewModel(
            model: updateProfileRequest.toJson());
        if (updateProfileViewModel.apiResponse.status == Status.COMPLETE) {
          UpdateProfileResponseModel resp =
              updateProfileViewModel.apiResponse.data;

          await viewProfileViewModel.viewProfileViewModel(model: {
            "user_id": PreferenceManager.getUserId(),
            "profile_id": PreferenceManager.getUserId()
          });
          Get.back();
          CommonSnackBar.commonSnackBar(message: '${resp.message}');
          // ViewProfileResponseModel viewProfileResponseModel =
          //     viewProfileViewModel.apiResponse.data;

          PreferenceManager.setName(name.text);
          PreferenceManager.setUserName(userName.text);
          PreferenceManager.setUserImage(widget.userImages);
          firebaseFirestore
              .collection('user')
              .doc(PreferenceManager.getUserId())
              .update({'username': userName.text, 'userEmail': emailId.text});
        } else if (updateProfileViewModel.apiResponse.status == Status.ERROR) {
          CommonSnackBar.commonSnackBar(message: 'Something went wrong');
          // log();
        }
      } else {
        return CommonSnackBar.commonSnackBar(message: 'Enter Email & Language');
      }
    }
  }
}
