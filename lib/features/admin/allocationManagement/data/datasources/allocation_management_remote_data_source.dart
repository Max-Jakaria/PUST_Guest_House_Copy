import 'dart:convert';
import 'package:http/http.dart';
import 'package:pust_guest_house/core/error/exceptions.dart';
import 'package:pust_guest_house/core/secrets/app_secrets.dart';
import 'package:pust_guest_house/core/utils/show_snackbar.dart';
import 'package:pust_guest_house/core/common/entities/models/my_allocation_model.dart';

abstract interface class AllocationManagementRemoteDataSource {
  Future<MyAllocationListModel> getAllAllocations();

  Future<MyAllocationListModel> getAllocationByStatus({required String status});

  Future<bool> updateAllocation({
    required int allocation_id,
    required String key,
    required String value,
  });
}

class AllocationManagementRemoteDataSourceImpl
    implements AllocationManagementRemoteDataSource {
  @override
  Future<MyAllocationListModel> getAllAllocations() async {
    final token = await getToken();
    if (token == null) {
      return MyAllocationListModel();
    }

    Uri url = Uri.http(
      AppSecrets.hostUrl,
      '/api/v1/admin/allocation/all',
      {
        'limit': '100',
        'page': '1',
      },
    );
    print('-_-calling url is : ${url.toString()}');

    final response = await get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    try {
      return MyAllocationListModel.fromJson(
          json.decode(response.body)['data']['allocation']);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<MyAllocationListModel> getAllocationByStatus(
      {required String status}) async {
    final token = await getToken();
    if (token == null) {
      return MyAllocationListModel();
    }

    Uri url = Uri.http(
      AppSecrets.hostUrl,
      '/api/v1/admin/allocation/all',
      {
        'limit': '100',
        'page': '1',
        'status': (status == 'all') ? '' : status,
      },
    );
    print('-_-calling url is : ${url.toString()}');

    final response = await get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    print('---___-');
    print(json.decode(response.body)['data']['allocation']);
    print('---___-');
    try {
      return MyAllocationListModel.fromJson(
          json.decode(response.body)['data']['allocation']);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<bool> updateAllocation({
    required int allocation_id,
    required String key,
    required String value,
  }) async {
    final token = await getToken();
    if (token == null) {
      return false;
    }

    Uri url = Uri.http(AppSecrets.hostUrl, '/api/v1/public/allocation/update');
    print('-_-calling url is : ${url.toString()}');

    final response = await post(url,
        body: json.encode({'id': allocation_id, key: value}),
        headers: {'Authorization': 'Bearer $token'});

    print('---___-');
    print(json.decode(response.body)['data']['allocation']);
    print('---___-');
    try {
      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException(
            message:
                'Server exception with status code ${response.statusCode}');
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
