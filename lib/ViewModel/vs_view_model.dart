import 'package:get/get.dart';
import 'package:hotlinecafee/Model/Repo/vs_repo.dart';
import 'package:hotlinecafee/Model/Response_model/add_vs_res_model.dart';
import 'package:hotlinecafee/Model/Response_model/remove_vs_res_model.dart';
import 'package:hotlinecafee/Model/apis/api_response.dart';

class VSLiveViewModel extends GetxController {
  /// ADD VS MODEL

  ApiResponse _addVsApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get addVsApiResponse => _addVsApiResponse;

  Future<void> addVSViewModel({Map<String, dynamic>? model}) async {
    _addVsApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      AddVsLiveResponseModel updateProfileResponse =
          await VSRepo().addVSRepo(body: model);
      print("AddVsLiveResponseModel=response==>$updateProfileResponse");

      _addVsApiResponse = ApiResponse.complete(updateProfileResponse);
    } catch (e) {
      print("AddVsLiveResponseModel=e==>$e");
      _addVsApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// REMOVE VS MODEL

  ApiResponse _removeVsApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get removeVsApiResponse => _removeVsApiResponse;

  Future<void> removeVSViewModel({Map<String, dynamic>? model}) async {
    _removeVsApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      RemoveVsLiveResponseModel updateProfileResponse =
          await VSRepo().removeVSRepo(body: model);
      print("AddVsLiveResponseModel=response==>$updateProfileResponse");

      _removeVsApiResponse = ApiResponse.complete(updateProfileResponse);
    } catch (e) {
      print("AddVsLiveResponseModel=e==>$e");
      _removeVsApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}
