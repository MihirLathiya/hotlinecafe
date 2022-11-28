import 'package:hotlinecafee/model/response_model/short_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class ShortsRepo extends BaseService {
  Future<ShortResponseModel> shortsRepo({Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: short, body: body, apitype: APIType.aPost);

    ShortResponseModel shortResponseModel =
        await ShortResponseModel.fromJson(response);
    print('RESPONSE $response');
    return shortResponseModel;
  }
}
