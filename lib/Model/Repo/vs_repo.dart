import 'package:hotlinecafee/Model/Response_model/add_vs_res_model.dart';
import 'package:hotlinecafee/Model/Response_model/remove_vs_res_model.dart';
import 'package:hotlinecafee/Model/services/api_service.dart';
import 'package:hotlinecafee/Model/services/base_service.dart';

class VSRepo extends BaseService {
  Future<AddVsLiveResponseModel> addVSRepo({Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: add_vs, body: body, apitype: APIType.aPost);
    AddVsLiveResponseModel addVsLiveResponseModel =
        AddVsLiveResponseModel.fromJson(response);
    return addVsLiveResponseModel;
  }

  Future<RemoveVsLiveResponseModel> removeVSRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: end_vs, body: body, apitype: APIType.aPost);
    RemoveVsLiveResponseModel removeVsLiveResponseModel =
        RemoveVsLiveResponseModel.fromJson(response);
    return removeVsLiveResponseModel;
  }
}
