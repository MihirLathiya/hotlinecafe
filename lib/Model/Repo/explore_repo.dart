import 'package:hotlinecafee/model/response_model/explore_res_model.dart';
import 'package:hotlinecafee/model/response_model/language_list_res_model.dart';
import 'package:hotlinecafee/model/response_model/region_res_model.dart';

import '../services/api_service.dart';
import '../services/base_service.dart';

class ExploreRepo extends BaseService {
  Future<ExploreResponseModel> exploreRepo({Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: explore, body: body, apitype: APIType.aPost);

    ExploreResponseModel exploreResponseModel =
        await ExploreResponseModel.fromJson(response);
    print('Explore $response');
    return exploreResponseModel;
  }

  Future<LanguageListResponseModel> languageListRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: languageList, body: body, apitype: APIType.aPost);

    LanguageListResponseModel languageListResponseModel =
        await LanguageListResponseModel.fromJson(response);
    return languageListResponseModel;
  }

  Future<RegionListResponseModel> regionListRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: regionList, body: body, apitype: APIType.aPost);

    RegionListResponseModel regionListResponseModel =
        await RegionListResponseModel.fromJson(response);
    return regionListResponseModel;
  }
}
