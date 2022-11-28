import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Response_model/daat.dart';
import 'package:hotlinecafee/model/repo/home_repo.dart';
import 'package:hotlinecafee/model/response_model/home_res_model.dart';
import 'package:hotlinecafee/model/response_model/live_streaming_res_model.dart';
import 'package:hotlinecafee/model/response_model/stop_live_stream_res_model.dart';

import '../model/apis/api_response.dart';
import '../model/repo/agora_token_repo.dart';

class HomeViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  List<Following>? forYou;
  List<Following>? following;

  ApiResponse get apiResponse => _apiResponse;

  Future<void> homeViewModel({Map<String, dynamic>? model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    // update();
    try {
      HomeResponseModel homeResponse = await HomeRepo().homeRepo(body: model);
      print("HomeResponseModel=response==>$homeResponse");

      _apiResponse = ApiResponse.complete(homeResponse);

      following = homeResponse.data!.following;
      forYou = homeResponse.data!.forYou;
    } catch (e) {
      print("HomeResponseModel=e==>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// AGORA TOKEN
  ///
  ApiResponse _apiResponse1 = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse1 => _apiResponse1;
  Future<void> agoraTokenViewModel({Map<String, dynamic>? model}) async {
    _apiResponse1 = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AgoraTokenResponseModel response =
          await AgoraTokenRepo().agoraTokenRepo(body: model);
      print("AgoraTokenResponseModel=response==>$response");

      _apiResponse1 = ApiResponse.complete(response);
    } catch (e) {
      print("AgoraTokenResponseModel=e==>$e");
      _apiResponse1 = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// Live Streaming
  ///
  ApiResponse _liveStreamApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get liveStreamApiResponse => _liveStreamApiResponse;
  Future<void> liveStreamViewModel({Map<String, dynamic>? model}) async {
    _liveStreamApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      LiveStreamingResponseModel response =
          await AgoraTokenRepo().liveStreamingTokenRepo(body: model);
      print("LiveStreamingResponseModel=response==>$response");

      _liveStreamApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("LiveStreamingResponseModel=e==>$e");
      _liveStreamApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// Stop Live Streaming
  ///
  ApiResponse _stopLiveStreamApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get stopLiveStreamApiResponse => _stopLiveStreamApiResponse;
  Future<void> stopLiveStreamViewModel({Map<String, dynamic>? model}) async {
    _stopLiveStreamApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      StopLiveStreamingResponseModel response =
          await AgoraTokenRepo().stopLiveStreamingTokenRepo(body: model);
      print("StopLiveStreamingResponseModel=response==>$response");

      _stopLiveStreamApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("StopLiveStreamingResponseModel=e==>$e");
      _stopLiveStreamApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
