import 'dart:developer';
import 'package:wldd/core/api_support.dart';
import 'package:wldd/core/dio_api_client.dart';
import 'package:wldd/features/developers/model/user_model.dart';
import 'package:wldd/features/developers/repository/user_repository.dart';

class UserRepositoryImplements extends UserRepository {
  final DioApiClient dioApiClient = DioApiClient();

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await dioApiClient.get(ApiSupport.users);
      log('GET: ${ApiSupport.users}');
      log('Response ← [${response.statusCode}] users');

      if (response.statusCode == 200) {
        final List data = response.data;

        final users = data.map((e) => UserModel.fromJson(e)).toList();

        log('Users fetched: ${users.length}');
        return users;
      }
    } catch (e) {
      log('Error: $e');
    }
    return [];
  }
}
