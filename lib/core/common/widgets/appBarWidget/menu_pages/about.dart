import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/custom_appbar.dart';
import 'package:pust_guest_house/core/common/widgets/bg_home.dart';

class AboutPage extends StatelessWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AboutPage(),
      );
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('in about page -------------');
    return home_background(
      child: Scaffold(
        appBar: MyAppBar(),
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
                    'About',
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const Text(
                  '''Welcome to PUST Guesthouse Application, the ultimate solution for seamless guesthouse management. \nStreamline your guesthouse operations with our intuitive mobile application designed to simplify request handling, enhance communication, and offer a delightful experience for both guests and guesthouse administrators. \n\n\nThis application is developed by \nSharif Hasan (CSE 11 batch) \nand \nBayazid Hossain (CSE 11 batch) \n\nUnder the supervision of \nDr. Md. Abdur Rahim \nDirector, ICT Cell \nPabna University of Science and Technology.''',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                // Center(child: Text('Pust Guest House :: V 1.0.0'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
