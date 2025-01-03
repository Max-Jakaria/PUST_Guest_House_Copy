import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pust_guest_house/core/common/constant/app_const.dart';
import 'package:pust_guest_house/core/models/admin/guestHouseModel.dart';
import 'package:pust_guest_house/core/secrets/app_secrets.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';
import 'package:pust_guest_house/core/utils/show_snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class GuesthouseLocatorWidget extends StatefulWidget {
  final int guestHouseId;
  const GuesthouseLocatorWidget({
    super.key,
    required this.guestHouseId,
  });

  @override
  State<GuesthouseLocatorWidget> createState() =>
      _GuesthouseLocatorWidgetState();
}

class _GuesthouseLocatorWidgetState extends State<GuesthouseLocatorWidget> {
  GuestHouseModel? guestHouseModel;

  @override
  void initState() {
    getGuestHouseModel(widget.guestHouseId);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border.all(width: 2, color: AppPallete.primary),
          borderRadius: BorderRadius.circular(6),
          color: AppPallete.primaryExtraLight),
      child: (guestHouseModel == null)
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListTile(
              onTap: () {
                // _launchInBrowserView(guest_house_lat[id]!, guest_house_log[id]!);
              },
              // leading: CircleAvatar(child: Text('${id}')),
              title: Text(
                AppConst.guestHouses[(widget.guestHouseId - 2)] ??
                    '${widget.guestHouseId} Guest House',
              ),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text('address : ${guest_house_address[id]}'),
                  ]),
              trailing: CircleAvatar(
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                ),
              ),
            ),
    );
  }

  Future<void> _launchInBrowserView(double lat, double long) async {
    Uri url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${lat},${long}');
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  void getGuestHouseModel(int guestHouseId) async {
    // house_list = api.loadHouses();
    // house_list!.then((value) {
    //   print("house list size ${value!.houses!.length}");
    // });

    var url = Uri.https(AppSecrets.hostUrl, '/api/v1/common/guest-house-list');
    print("$url");

    final response =
        await get(url, headers: {'Authorization': 'Bearer ${getToken()}'});

    if (response.statusCode == 200) {
      print(response.body);
      final houseList =
          GuestHouseList.fromJson(json.decode(response.body)['data']['list'])
              .houses;
      for (int i = 0; i < houseList!.length; i++) {
        if (houseList[i].id == guestHouseId) {
          setState(() {
            guestHouseModel = houseList[i];
          });
        }
      }
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
