import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:wldd/core/api_support.dart';
import 'package:wldd/core/dio_api_client.dart';
import 'package:wldd/features/developers/model/user_repo_model.dart';
import 'package:wldd/features/developers/repository/repository_repo.dart';

class RepositoryRepoImpl extends RepoRepository {
  @override
  Future<List<UserRepoModel>> getUserRepository(String url) async {
    final DioApiClient dioApiClient = DioApiClient();

    try {
      final response = await dioApiClient.get("${ApiSupport.baseUrl}users/$url/repos");

      if (response.statusCode == 200 && response.data != null) {

        final List<dynamic> data = response.data;
        final repoList =  data.map((e)=> UserRepoModel.fromJson(e)).toList();
        log(repoList.length.toString());

        return repoList;

      } else {

        throw Exception("Failed to fetch user repositories. Status code: ${response.statusCode}");
      }

    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        throw Exception("Dio error: ${e.message}");
      }

    } catch (e) {
      log(e.toString(),name: "eee");
      throw Exception("Unexpected error: $e");
    }
  }
}
