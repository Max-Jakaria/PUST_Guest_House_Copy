import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/common/constant/app_const.dart';
import 'package:pust_guest_house/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:pust_guest_house/core/common/entities/my_allocation.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/custom_appbar.dart';
import 'package:pust_guest_house/core/common/widgets/bg_home.dart';
import 'package:pust_guest_house/core/common/widgets/custom_row.dart';
import 'package:pust_guest_house/core/common/widgets/guesthouse_locator_widget.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';
import 'package:pust_guest_house/core/utils/date_time_formater.dart';

class AllocationDetailsPage extends StatelessWidget {
  final MyAllocation allocation;
  const AllocationDetailsPage({super.key, required this.allocation});
  @override
  Widget build(BuildContext context) {
    final myUser = (context.read<AppUserCubit>().state as AppUserSignedIn).user;
    return home_background(
      child: Scaffold(
        appBar: const MyAppBar(),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),

                Text(
                  AppConst.guestHouses[(allocation.guest_house_id! - 2)] ??
                      '${allocation.guest_house_id} Guest House',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Pabna University of Science and Technology',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Booking Information'),
                SizedBox(
                  height: 40,
                ),
                headingText('Personal Information'),
                SizedBox(
                  height: 10,
                ),
                MyRow(heading: "Name : ", value: "${myUser.name}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(heading: "Designation : ", value: "${myUser.title}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "Department or Office : ",
                    value: "${myUser.department}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(heading: "Phone : ", value: "${myUser.phone}"),
                SizedBox(
                  height: 30,
                ),
                headingText('Booking Information'),
                SizedBox(
                  height: 10,
                ),
                MyRow(heading: "Id : ", value: "${allocation.id}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "App. Date : ",
                    value:
                        "${allocation.created_at.toString().substring(0, 10)} At : ${allocation.created_at.toString().substring(11, 16)}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "Booking Type : ",
                    value: "${allocation.booking_type}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "Room Type : ", value: "${allocation.room_type}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "Guest Type : ",
                    value:
                        "${allocation.boarder_type!.substring(0, 1).toUpperCase()}${allocation.boarder_type!.substring(1)}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "Booking for : ",
                    value: "${allocation.allocation_purpose}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "Arrival date : ",
                    value: DateTimeFormater.get(allocation.boarding_date!)),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "Departure date : ",
                    value: DateTimeFormater.get(allocation.departure_date!)),
                (allocation.status == 'approved')
                    ? Container(
                        margin: EdgeInsets.only(top: 10),
                        child: MyRow(
                            heading: 'Day Count : ',
                            value: '${allocation.dayCount}'),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "No. of Guest : ",
                    value: "${allocation.guest_count}"),
                SizedBox(
                  height: 10,
                ),
                MyRow(
                    heading: "On Behalf Of : ",
                    value: "${allocation.behalf_of}"),
                // Approved beds
                (allocation.status == 'approved')
                    ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Approved Beds : ',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Column(
                                  children: allocation.assigned_rooms!.rooms!
                                      .map((e) {
                                    return Container(
                                        margin: EdgeInsets.all(5.0),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 10.0),
                                        decoration: BoxDecoration(
                                            color: AppPallete.primaryExtraLight,
                                            border: Border.all(
                                                width: 1.3,
                                                color: AppPallete.primary),
                                            borderRadius:
                                                BorderRadius.circular(3.0)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Number : ${e.number}'),
                                            Text('${e.room_type}'),
                                          ],
                                        ));
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                (allocation.status == 'rejected')
                    ? Container(
                        child: MyRow(
                            heading: 'Reje. Reason :',
                            value: '${allocation.rejection_reason}'),
                      )
                    : Container(),
                SizedBox(
                  height: 30,
                ),
                GuesthouseLocatorWidget(
                    guestHouseId: allocation.guest_house_id!),
                SizedBox(
                  height: 50,
                ),
                // download pdf button
                (allocation.status == 'approved')
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppPallete.primary),
                          onPressed: () async {
                            print('pdf download');
                            // downloadAndSavePdf(context, allocation!.report_link!,
                            //     allocation!.id!);
                            // _launchInBrowserViewPDF(
                            //     context, allocation!.report_link);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.download),
                              SizedBox(
                                width: 6,
                              ),
                              Text("Download as PDF"),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                // Cancel Request btn
                (allocation.status == 'approved' ||
                        allocation.status == 'pending')
                    ? Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppPallete.dangerColor),
                              onPressed: () async {
                                // requestCancel(context, allocation!.id ?? 0);
                                _showRequestCancleConfirmationDialog(
                                    context, allocation.id!);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.cancel_outlined),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text("Cancel Request."),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            child: Text(
                              'Cancel will not change your the deperature date. To update deperature date you need to talk with admin.',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  headingText(String text) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  getDayDifference(String from, String to) {
    DateTime fromDate = DateTime.parse(from);
    DateTime toDate = DateTime.parse(to);

    return '${toDate.difference(fromDate).inDays} days';
  }

  // requestCancel(BuildContext context, int id) {
  //   BookingNetwork api =
  //       BookingNetwork(url: '/api/v1/public/allocation/update');
  //   final response = api.cancelRequest(id);
  //   response.then((value) {
  //     if (value) {
  //       showToast(context, 'Cancel success', dangerColor);
  //       Navigator.popUntil(context, (route) => false);
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => const UserHome()),
  //       );
  //     } else {
  //       showToast(context, 'Cancel denied', dangerColor);
  //     }
  //   });
  // }

  // Future<void> _launchInBrowserViewPDF(
  //     BuildContext context, String? surl) async {
  //   if (surl == null) {
  //     showToast(
  //         context, 'PDF is not availdable for that allocation.', dangerColor);
  //     return;
  //   }
  //   print('Report Url is : $surl');
  //   Uri url = Uri.parse('$surl');
  //   if (!await launchUrl(url, mode: LaunchMode.inAppBrowserView)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  void _showRequestCancleConfirmationDialog(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Confirm'),
          content: Text('Are you sure to cancel this request.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // Navigator.of(context).pop();
                // _scrollController.animateTo(
                //   _scrollController.position.maxScrollExtent,
                //   duration: Duration(milliseconds: 2000),
                //   curve: Curves.easeInOut,
                // );
                // requestCancel(context, id);
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
