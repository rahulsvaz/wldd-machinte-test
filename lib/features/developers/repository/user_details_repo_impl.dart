


import 'dart:developer';

import 'package:wldd/core/api_support.dart';
import 'package:wldd/core/dio_api_client.dart';
import 'package:wldd/features/developers/model/user_details_model.dart';
import 'package:wldd/features/developers/repository/user_details_repo.dart';

import 'package:dio/dio.dart';


class UserDetailsRepoImpl extends UserDetailsRepo {
  @override
  Future<UserDetailsModel> getUserDetails(String url) async {
    final DioApiClient dioApiClient = DioApiClient();

    try {
      final response = await dioApiClient.get("${ApiSupport.baseUrl}users/$url");
      if (response.statusCode == 200 && response.data != null) {
        log(response.data.toString());

        return UserDetailsModel.fromJson(response.data);

      } else {
        throw Exception("Failed to fetch user details. Status code: ${response.statusCode}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        throw Exception("Dio error: ${e.message}");
      }
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
