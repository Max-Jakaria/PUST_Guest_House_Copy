import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/custom_appbar.dart';
import 'package:pust_guest_house/core/common/widgets/bg_home.dart';

class HelpUser extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const HelpUser(),
      );
  const HelpUser({super.key});

  @override
  Widget build(BuildContext context) {
    return home_background(
      child: Scaffold(
        appBar: const MyAppBar(),
        body: Container(
          margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * 0.015,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const Center(
                  child: Text(
                    'Get Help',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                _head("কিভাবে বুকিং দিবো?"),
                _paragraph(
                    'হোম পেজে নিচের ডান পাশে যোগ চিহ্নে ক্লিক করলে শর্তাবলী আসবে। শর্তাবলী স্ক্রল করলে একদম নিচে Accept বাটন পাওয়া যাবে। Accept বাটনে ক্লিক করলে বুকিং ফর্ম আসবে। ফরমের সকল তথ্য পুরন করে Send Request বাটনে ক্লিক করলে আবেদন হয়ে যাবে। আবেদন প্রথম সবস্থায় pending এ থাকবে। এডমিন অনুমোদন দিলে Email এবং SMS এর মাধ্যমে জানানো হবে, অথবা অ্যাপ এ এসেও দেখা যাবে।'),
                _head("কিভাবে বুকিং বাতিল করবো?"),
                _paragraph(
                    'বুকিং সুধু মাত্র pending অথবা appproved অবস্থায় বাতিল করা যাবে। হোমপেজ থেকে বুকিং এর উপর ক্লিক করলে বিস্তারিত দেখা যাবে। এই পেজের একদম নিচে "Cancel Request" option পাওয়া যাবে। \n বিদ্রঃ বুকিং বাতিল করলে প্রস্থান কাল এর কোন পরিবর্তন হবে না।'),
                _head("How to view profile?"),
                _paragraph(
                    'From the home screen on the top right corner click on the three dots menu option. Click on the view Profile option, profile page will opened.'),
                _head('How to Edit User Name?'),
                _paragraph(
                    'On user profile page, where username is showing. Longtime press on to the user name then an update dialog will open. Change the name and click on the update button.'),
                _head('How to Edit User designation?'),
                _paragraph(
                    'On user profile page, where user designation is showing. Longtime press on to the user designation then an update dialog will open. Change the designation and click on the update button.'),
                _head('How to upload profile picture?'),
                _paragraph(
                    'On user profile page, where profile picture is showing. Click on the picture then a dialog showing two option \n    (1)Take a picture\n    (2)Select from gallery\nTo show the updated profile picture you need to refresh the app.'),
                _head('How to Refresh the app?'),
                _paragraph(
                    'On the home page top right corner showing three dots, click on the three dots. A menu will be opened. The third option will show the Refresh, click on it.'),
                _head('How to Edit Phone number?'),
                _paragraph(
                    'On user profile page, where phone number is showing. Longtime press on to the phone number then an update dialog will open. Change the phone number and click on the update button.'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _head(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }

  Widget _paragraph(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 30),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
    );
  }
}
