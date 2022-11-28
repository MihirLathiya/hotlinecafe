import 'package:get/get.dart';
import 'package:hotlinecafee/model/apis/api_response.dart';
import 'package:hotlinecafee/model/repo/explore_repo.dart';
import 'package:hotlinecafee/model/response_model/explore_res_model.dart';
import 'package:hotlinecafee/model/response_model/language_list_res_model.dart';
import 'package:hotlinecafee/model/response_model/region_res_model.dart';

class ExploreViewModel extends GetxController {
  ApiResponse _apiResponse = ApiResponse.initial(message: 'Initialization');

  ApiResponse get apiResponse => _apiResponse;

  Future<void> exploreViewModel({Map<String, dynamic>? model}) async {
    _apiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      ExploreResponseModel response =
          await ExploreRepo().exploreRepo(body: model);
      print("ExploreResponseModel=response==>$response");

      _apiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("ExploreResponseModel=e==>$e");
      _apiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// LANGUAGE LIST

  ApiResponse _languageListApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get languageListApiResponse => _languageListApiResponse;

  Future<void> languageListViewModel({Map<String, dynamic>? model}) async {
    _languageListApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      LanguageListResponseModel response =
          await ExploreRepo().languageListRepo(body: model);
      print("ExploreResponseModel=response==>$response");

      _languageListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("ExploreResponseModel=e==>$e");
      _languageListApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }

  /// LANGUAGE LIST

  ApiResponse _regionListApiResponse =
      ApiResponse.initial(message: 'Initialization');

  ApiResponse get regionListApiResponse => _regionListApiResponse;

  Future<void> regionListViewModel({Map<String, dynamic>? model}) async {
    _regionListApiResponse = ApiResponse.loading(message: 'Loading');
    update();
    try {
      RegionListResponseModel response =
          await ExploreRepo().regionListRepo(body: model);
      print("ExploreResponseModel=response==>$response");

      _regionListApiResponse = ApiResponse.complete(response);
    } catch (e) {
      print("ExploreResponseModel=e==>$e");
      _regionListApiResponse = ApiResponse.error(message: 'error');
    }
    update();
  }
}

class FilterController extends GetxController {
  var selectCountry = 100.obs;
  var selectLanguage = 100.obs;
  var languages = ''.obs;
  var country = ''.obs;

  selectedCountry(int index) {
    selectCountry.value = index;
  }

  selectedFilterCountry(value) {
    country.value = value;
  }

  selectedLanguage(int index) {
    selectLanguage.value = index;
  }

  selectedFilterLanguage(value) {
    languages.value = value;
  }
}
