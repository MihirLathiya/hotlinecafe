import '../services/api_service.dart';
import '../services/base_service.dart';

class RazorPayPaymentRepo extends BaseService {
  /// Social login repo
  Future razorPayPaymentRepo({Map<String, dynamic>? body}) async {
    var response = await APIService()
        .getResponse(url: buy_coin, body: body, apitype: APIType.aPost);
    return response;
  }
}
