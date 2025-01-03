import 'dart:convert';

import 'package:http/http.dart';
import 'package:pust_guest_house/core/error/exceptions.dart';
import 'package:pust_guest_house/core/secrets/app_secrets.dart';
import 'package:pust_guest_house/core/utils/show_snackbar.dart';
import 'package:pust_guest_house/core/common/entities/models/my_allocation_model.dart';

abstract interface class AddAllocationRemoteDataSource {
  Future<bool> uploadNewAllocation(MyAllocationModel allocation);

  Future<MyAllocationListModel> getAllAllocations();

  Future<MyAllocationListModel> getAllocationByStatus({required String status});
}

class AddAllocationRemoteDataSourceImpl
    implements AddAllocationRemoteDataSource {
  @override
  Future<bool> uploadNewAllocation(MyAllocationModel allocation) async {
    final token = await getToken();
    if (token == null) {
      return false;
    }

    Uri url = Uri.http(AppSecrets.hostUrl, '/api/v1/public/allocation/new');
    print('-_-calling url is : ${url.toString()}');

    final response = await post(
      url,
      body: json.encode(allocation.get()),
      headers: {'Authorization': 'Bearer $token'},
    );
    try {
      print('-_-_- status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        final res = json.decode(response.body);
        print('-_- body $res');
        print('-_- token : ${res['data']['token']}');
        if (res['status'] == 'error') {
          throw ServerException(message: res['message']);
        }
        return true;
      } else {
        throw ServerException(
            message:
                'error occure to login user with code ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

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
    // Uri url = Uri.http(
    //   AppSecrets.hostUrl,
    //   '/api/v1/public/allocation/all',
    //   {
    //     'limit': '1000',
    //     'page': '1',
    //   },
    // );
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
      '/api/v1/public/allocation/all',  
      {
        'limit': '100',
        'page': '1',
        'status': (status == 'all') ? '' : status,
      },
    );
    // Uri url = Uri.http(
    //   AppSecrets.hostUrl,
    //   '/api/v1/public/allocation/all',
    //   {
    //     'limit': '1000',
    //     'page': '1',
    //   },
    // );
    print('-_-calling url is : ${url.toString()}');

    final response = await get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    print('---___-');
    // print(json.decode(response.body));
    print(json.decode(response.body)['data']['allocation']);
    print('---___-');
    try {
      return MyAllocationListModel.fromJson(
          json.decode(response.body)['data']['allocation']);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
