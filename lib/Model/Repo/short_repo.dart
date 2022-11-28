import 'package:hotlinecafee/model/response_model/short_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class ShortRepo extends BaseService {
  Future<ShortResponseModel> shortRepo({Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: short, body: body, apitype: APIType.aPost);

    ShortResponseModel shortResponseModel =
        await ShortResponseModel.fromJson(response);
    print('SHORTRESPONSE $response');
    return shortResponseModel;
  }
}
