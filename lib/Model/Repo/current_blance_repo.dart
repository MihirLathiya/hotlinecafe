import 'package:hotlinecafee/Model/Response_model/current_blance_res_model.dart';
import 'package:hotlinecafee/Model/Services/api_service.dart';
import 'package:hotlinecafee/Model/Services/base_service.dart';
import 'package:hotlinecafee/Preference/preference.dart';

class CurrentBalanceRepo extends BaseService {
  Future<CurrentBalanceResponseModel> currentBalanceRepo(
      {Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: current_balance, body: body, apitype: APIType.aPost);

    CurrentBalanceResponseModel res =
        await CurrentBalanceResponseModel.fromJson(response);
    await PreferenceManager.setCurrentBalance('${res.data!.balance}');
    return res;
  }
}
