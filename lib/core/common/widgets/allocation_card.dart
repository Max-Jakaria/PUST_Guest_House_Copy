import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/common/constant/app_const.dart';
import 'package:pust_guest_house/core/common/entities/my_allocation.dart';
import 'package:pust_guest_house/core/common/widgets/small_title.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';
import 'package:pust_guest_house/core/utils/get_background_image.dart';
import 'package:pust_guest_house/features/client/presentation/pages/allocation_details_page.dart';

class AllocationCard extends StatelessWidget {
  final MyAllocation allocation;
  final bool? isAdminSize;
  const AllocationCard({super.key, required this.allocation, this.isAdminSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('${allocation.id} id clicked.');
        // if (allocation.is_user_seen == 0) {
        //   updateSeenStatus(allocation.id ?? -1);
        //   setState(() {
        //     allocation.is_user_seen = 1;
        //   });
        // }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AllocationDetailsPage(allocation: allocation)),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        decoration: BoxDecoration(
          color: _getColorByStatus(
              '${allocation.status}',
              (isAdminSize == null || isAdminSize == false)
                  ? allocation.is_user_seen ?? 0
                  : allocation.is_admin_seen ?? 0),
          border: Border.all(width: 1.0, color: AppPallete.primaryDeep),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: (isAdminSize == null || isAdminSize == false)
              ? CircleAvatar(
                  child: Text('${allocation.id}'),
                  backgroundColor: AppPallete.white,
                )
              : CircleAvatar(
                  foregroundImage: getBackgroundImage(allocation.user_profile),
                  backgroundImage: AssetImage('images/man.png'),
                  backgroundColor: AppPallete.white,
                ),
          title: (isAdminSize == null || isAdminSize == false)
              ? SmallTitle(
                  title:
                      AppConst.guestHouses[(allocation.guest_house_id! - 2)] ??
                          '${allocation.guest_house_id} Guest House')
              : SmallTitle(title: allocation.user_name!),
          // title: Text(
          //     "${type_of_guest_house_list[allocation.guest_house_id ?? 0].title}"),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.date_range),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${allocation.boarding_date!.substring(0, 16)} to"),
                      Text(allocation.departure_date!.substring(0, 16)),
                    ],
                  ),
                ],
              ),
              (isAdminSize == null || isAdminSize == false)
                  ? Container()
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${AppConst.guestHouses[(allocation.guest_house_id! - 2)]}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text('ID:  ${allocation.id}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
            ],
          ),
          trailing: Text('${allocation.status}'),
        ),
      ),
    );
  }

  Color _getColorByStatus(String status, int seen) {
    if (seen == 1) {
      if (status == 'pending') {
        return AppPallete.seenPendingColor;
      } else if (status == 'approved') {
        return AppPallete.seenApprovedColor;
      } else {
        return AppPallete.seenRejectedColor;
      }
    } else {
      if (status == 'pending') {
        return AppPallete.unSeenPendingColor;
      } else if (status == 'approved') {
        return AppPallete.unSeenApprovedColor;
      } else {
        return AppPallete.unSeenRejectedColor;
      }
    }
  }
}
