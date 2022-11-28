import 'package:hotlinecafee/model/response_model/forgot_password_res_model.dart';
import 'package:hotlinecafee/model/response_model/gender_selection_res_model.dart';
import 'package:hotlinecafee/model/response_model/reset_password_res_model.dart';
import 'package:hotlinecafee/model/response_model/send_forgot_otp_res_model.dart';
import 'package:hotlinecafee/model/response_model/social_login_res_model.dart';
import 'package:hotlinecafee/model/response_model/username_res_model.dart';
import 'package:hotlinecafee/model/response_model/verify_forgot_otp_res_model.dart';
import 'package:hotlinecafee/model/response_model/verify_sign_up_otp_res_model.dart';

import '../response_model/login_res_model.dart';
import '../response_model/sign_up_res_model.dart';
import '../services/api_service.dart';
import '../services/base_service.dart';

class AuthRepo extends BaseService {
  /// Social login repo
  Future<SocialloginResponseModel> socialLoginRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: socialLogin, body: body, apitype: APIType.aPost);
    SocialloginResponseModel socialLoginResponseModel =
        SocialloginResponseModel.fromJson(response);
    return socialLoginResponseModel;
  }

  /// signUp
  Future<SignUpResponseModel> signUpRepo({Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: signUpUrl, body: body, apitype: APIType.aPost);
    SignUpResponseModel signUpResponseModel =
        SignUpResponseModel.fromJson(response);
    return signUpResponseModel;
  }

  /// signUp verify Otp
  Future<VerifySignUpOtpResponseModel> otpRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: otpUrl, body: body, apitype: APIType.aPost);

    VerifySignUpOtpResponseModel otpResponseModel =
        await VerifySignUpOtpResponseModel.fromJson(response);
    print('RESPONSE $response');
    return otpResponseModel;
  }

  /// UserName
  Future<UserNameResponseModel> userNameRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: userName, body: body, apitype: APIType.aPost);

    UserNameResponseModel userNameResponseModel =
        await UserNameResponseModel.fromJson(response);
    print('RESPONSE $response');
    return userNameResponseModel;
  }

  /// login
  Future<LoginResponseModel> loginRepo({Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: login, body: body, apitype: APIType.aPost);
    LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(response);
    return loginResponseModel;
  }

  /// Select Gender
  Future<GenderSelectionResponseModel> genderSelectionRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: genderSelection, body: body, apitype: APIType.aPost);
    GenderSelectionResponseModel genderSelectionResponseModel =
        GenderSelectionResponseModel.fromJson(response);
    return genderSelectionResponseModel;
  }

  /// Forgot password
  Future<ForgotPasswordResponseModel> forgotPasswordRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: forgotPassword, body: body, apitype: APIType.aPost);
    ForgotPasswordResponseModel forgotPasswordResponseModel =
        ForgotPasswordResponseModel.fromJson(response);
    return forgotPasswordResponseModel;
  }

  /// Send Forgot Otp
  Future<SendForgotOtpResponseModel> sendForgotOtpRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: resendForgotOTP, body: body, apitype: APIType.aPost);
    SendForgotOtpResponseModel sendForgotOtpResponseModel =
        SendForgotOtpResponseModel.fromJson(response);
    return sendForgotOtpResponseModel;
  }

  /// VERIFY fORGOT PASSWORD

  Future<VerifyForgotOtpResponseModel> verifyForgotOtpRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: verifyForgotOTP, body: body, apitype: APIType.aPost);
    VerifyForgotOtpResponseModel verifyForgotOtpResModel =
        VerifyForgotOtpResponseModel.fromJson(response);
    return verifyForgotOtpResModel;
  }

  /// Reset Password
  Future<ResetPasswordResModel> resetPasswordRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: resetPassword, body: body, apitype: APIType.aPost);
    ResetPasswordResModel resetPasswordResModel =
        ResetPasswordResModel.fromJson(response);
    return resetPasswordResModel;
  }
}
