import 'package:hotlinecafee/model/response_model/random_match_on_off_res_model.dart';
import 'package:hotlinecafee/model/response_model/random_match_res_model.dart';
import 'package:hotlinecafee/model/response_model/random_off_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class RandomMatchRepo extends BaseService {
  Future<RandomMatchResponseModel> randomMatchRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: randomMatch, body: body, apitype: APIType.aPost);

    RandomMatchResponseModel randomMatchResponseModel =
        await RandomMatchResponseModel.fromJson(response);
    print('RandomMatchResponseModel $response');
    return randomMatchResponseModel;
  }

  Future<RandomMatchOnOffResponseModel> randomMatchOnOffRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: randomMatchOnOff, body: body, apitype: APIType.aPost);

    RandomMatchOnOffResponseModel randomOnOff =
        await RandomMatchOnOffResponseModel.fromJson(response);
    print('RandomMatchOnOffResponseModel 1111===> $response');
    return randomOnOff;
  }

  Future<RandomMatchOffResponseModel> randomMatchOffRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: randomMatchOnOff, body: body, apitype: APIType.aPost);

    RandomMatchOffResponseModel randomOff =
        await RandomMatchOffResponseModel.fromJson(response);
    print('RandomMatchOnOffResponseModel 1111===> $response');
    return randomOff;
  }
}
