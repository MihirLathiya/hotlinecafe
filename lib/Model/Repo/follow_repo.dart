import 'package:hotlinecafee/model/response_model/follow_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class FollowRepo extends BaseService {
  Future<FollowResponseModel> followRepo({Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: follow, body: body, apitype: APIType.aPost);

    FollowResponseModel followResponseModel =
        await FollowResponseModel.fromJson(response);
    print('RESPONSE $response');
    return followResponseModel;
  }
}
