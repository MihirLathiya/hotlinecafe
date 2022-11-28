import 'package:hotlinecafee/model/response_model/location_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class LocationRepo extends BaseService {
  Future<LocationResponseModel> locationRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: location, body: body, apitype: APIType.aPost);
    LocationResponseModel locationResponseModel =
        LocationResponseModel.fromJson(response);
    // log('LOCATION$response');
    return locationResponseModel;
  }
}
