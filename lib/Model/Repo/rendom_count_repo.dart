import 'package:hotlinecafee/Model/Response_model/random_count_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class RandomCountRepo extends BaseService {
  Future<RandomCountResponseModel> randomCountRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: random_count, body: body, apitype: APIType.aPost);
    RandomCountResponseModel randomCountResponseModel =
        RandomCountResponseModel.fromJson(response);
    return randomCountResponseModel;
  }
}
