import 'dart:developer';

import 'package:hotlinecafee/model/response_model/update_profile_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class UpdateProfileRepo extends BaseService {
  Future<UpdateProfileResponseModel> updateProfileRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: updateProfile, body: body, apitype: APIType.aPost);
    log('USERDATA ${body}');
    log('response ${response}');
    UpdateProfileResponseModel updateProfileResponseModel =
        UpdateProfileResponseModel.fromJson(response);
    return updateProfileResponseModel;
  }
}
