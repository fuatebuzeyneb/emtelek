import 'package:emtelek/core/api/api_consumer.dart';
import 'package:emtelek/core/api/end_points.dart';
import 'package:emtelek/shared/models/auth-and-profile-models/clients_response_model.dart';
import 'package:emtelek/shared/services/cache_hekper.dart';
import 'package:emtelek/shared/services/service_locator.dart';

// تعريف الواجهة (Interface)
abstract class ProfileRepository {
  Future<ClientsResponseModel> getAccountSettings();
}

// تنفيذ الواجهة (Implementation)
class ProfileRepositoryImpl implements ProfileRepository {
  final ApiConsumer api;

  ProfileRepositoryImpl({required this.api});

  @override
  Future<ClientsResponseModel> getAccountSettings() async {
    String token = getIt<CacheHelper>().getDataString(key: 'token')!;
    int clientId = getIt<CacheHelper>().getData(key: 'clientId');

    print(
        "Token: $token, ClientId: $clientId"); // تأكد من أن القيم موجودة وصحيحة

    try {
      final response = await api.post(
        '${EndPoints.baseUrl}${EndPoints.clientsGet}',
        isFormData: true,
        data: {
          "Token": getIt<CacheHelper>().getDataString(key: 'token'),
          "ClientId": getIt<CacheHelper>().getData(key: 'clientId'),
        },
      );

      // ✅ Ensure response.data is correctly parsed
      return ClientsResponseModel.fromJson(response);
    } catch (e) {
      throw Exception("Failed to load account settings: ${e.toString()}");
    }
  }
}
