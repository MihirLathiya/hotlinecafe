import 'dart:developer';

import 'package:hotlinecafee/model/response_model/home_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class HomeRepo extends BaseService {
  Future<HomeResponseModel> homeRepo({Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: home, body: body, apitype: APIType.aPost);

    HomeResponseModel homeResponseModel = HomeResponseModel.fromJson(response);
    return homeResponseModel;
  }
}
