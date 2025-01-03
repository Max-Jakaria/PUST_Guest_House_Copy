import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pust_guest_house/core/common/constant/app_const.dart';
import 'package:pust_guest_house/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:pust_guest_house/core/common/widgets/bg_home.dart';
import 'package:pust_guest_house/core/common/widgets/appBarWidget/custom_appbar.dart';
import 'package:pust_guest_house/core/common/widgets/custom_button.dart';
import 'package:pust_guest_house/core/common/widgets/custom_text_field.dart';
import 'package:pust_guest_house/core/common/widgets/error_text.dart';
import 'package:pust_guest_house/core/common/widgets/page_title.dart';
import 'package:pust_guest_house/core/common/widgets/separator.dart';
import 'package:pust_guest_house/core/common/widgets/small_title.dart';
import 'package:pust_guest_house/core/utils/show_snackbar.dart';
import 'package:pust_guest_house/features/client/presentation/bloc/add_allocation_bloc.dart';
import 'package:pust_guest_house/features/client/presentation/pages/client_home.dart';
import 'package:pust_guest_house/features/client/presentation/widgets/date_and_time_picker.dart';
import 'package:pust_guest_house/features/client/presentation/widgets/radio_button.dart';
import 'package:pust_guest_house/features/client/presentation/widgets/utils/constants.dart';
import 'package:pust_guest_house/features/client/presentation/widgets/utils/number_controller.dart';

class AddAllocationRequestPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => const AddAllocationRequestPage(),
      );

  const AddAllocationRequestPage({super.key});

  @override
  State<AddAllocationRequestPage> createState() =>
      _AddAllocationRequestPageState();
}

class _AddAllocationRequestPageState extends State<AddAllocationRequestPage> {
  final guestHouseIdController = NumberController();
  final bookingTypeIdController = NumberController();
  final roomTypeIdController = NumberController();
  final nightStayIdController = NumberController();
  final guestTypeIdController = NumberController();
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();
  final numberOfGuestController = TextEditingController();
  final guestsAreIdController = NumberController();
  final onBehalfController = TextEditingController();

  bool _behalfTextFieldShow = false;

  final _formKey = GlobalKey();

  String _errorText = '';

  @override
  void dispose() {
    guestHouseIdController.number = 0;
    bookingTypeIdController.number = 0;
    roomTypeIdController.number = 0;
    nightStayIdController.number = 0;
    guestTypeIdController.number = 0;
    fromDateController.dispose();
    toDateController.dispose();
    numberOfGuestController.dispose();
    guestsAreIdController.number = 0;
    _behalfTextFieldShow = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return home_background(
      child: Scaffold(
        appBar: const MyAppBar(),
        body: BlocConsumer<AddAllocationBloc, AddAllocationState>(
          listener: (context, state) {
            if (state is AddAllocationFailure) {
              showSnackBar(context, state.error);
            } else if (state is AddAllocationUploadSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                ClientHomePage.route(),
                (route) => false,
              );
            }
          },
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Separator.percentage(context: context, p: 8),
                      PageTitle(text: 'Booking Form'),
                      Separator.percentage(context: context, p: 5),
                      MyRadoButton(
                        title: 'For',
                        options: AppConst.guestHouses,
                        controller: guestHouseIdController,
                        isColumn: true,
                      ),
                      Separator.textField(),
                      MyRadoButton(
                        title: 'Type of Booking',
                        options: bookingTypes,
                        controller: bookingTypeIdController,
                      ),
                      Separator.textField(),
                      MyRadoButton(
                        title: 'Type of Room',
                        options: roomTypes,
                        controller: roomTypeIdController,
                      ),
                      Separator.textField(),
                      MyRadoButton(
                        title: 'For Night Stay',
                        options: yesNo,
                        controller: nightStayIdController,
                      ),
                      Separator.textField(),
                      MyRadoButton(
                        title: 'Guest Type',
                        options: guestTypes,
                        controller: guestTypeIdController,
                      ),
                      Separator.textField(),
                      MyDateTimePicker(
                        fromDateController: fromDateController,
                        toDateController: toDateController,
                        title: 'Date and Time of Stay',
                      ),
                      Separator.textField(),
                      MyTextField(
                        hintText: 'Write number of guest',
                        labelText: 'Number of Guest',
                        controller: numberOfGuestController,
                      ),
                      Separator.textField(),
                      MyRadoButton(
                        title: 'Guests Are',
                        options: guestsAre,
                        controller: guestsAreIdController,
                        callback: () {
                          if (guestsAreIdController.number == 2) {
                            setState(() {
                              _behalfTextFieldShow = true;
                            });
                          } else if (guestsAreIdController.number == 1) {
                            setState(() {
                              _behalfTextFieldShow = false;
                            });
                          }
                        },
                      ),
                      _behalfTextFieldShow
                          ? Column(
                              children: [
                                Separator.textField(),
                                const SmallTitle(
                                    title:
                                        'Please mention their names and relations, separating them by commas(,) :'),
                                Separator.textField(),
                                MyTextField(
                                  hintText:
                                      'Example: name 1, father\nname 2, mother\nname 3,wife/husband',
                                  labelText: 'Name & Relation',
                                  controller: onBehalfController,
                                  maxLines: 3,
                                ),
                              ],
                            )
                          : Container(),
                      Separator.textField(),
                      ErrorText(text: '$_errorText'),
                      Separator.textField(),
                      Separator.percentage(context: context, p: 6),
                      MyButton(
                          text: 'Send Request',
                          onPressed: () async {
                            _uploadNewAllocationRequest();
                          }),
                      Separator.percentage(context: context, p: 30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _uploadNewAllocationRequest() {
    if (_validated()) {
      final userId =
          (context.read<AppUserCubit>().state as AppUserSignedIn).user.id;
      if (userId == null) {
        setState(() {
          _errorText =
              'Something would be wrong. please re-signin and try again.';
        });
        return;
      }
      context.read<AddAllocationBloc>().add(AddNewAllocationEvent(
            user_id: userId,
            guest_house_id: guestHouseIdController.number,
            booking_type: bookingTypes[bookingTypeIdController.number]!,
            room_type: roomTypes[roomTypeIdController.number]!,
            allocation_purpose: (nightStayIdController.number == 1)
                ? 'Night Stay'
                : 'Day Stay Only',
            boarding_date: fromDateController.text,
            departure_date: toDateController.text,
            guest_count: int.parse(numberOfGuestController.text.trim()),
            created_at: DateTime.now().toString(),
            updated_at: DateTime.now().toString(),
            boarder_type: guestTypes[guestTypeIdController.number]!,
            behalf_of: (guestsAreIdController.number == 1)
                ? 'Self'
                : onBehalfController.text,
          ));
    }
  }

  bool _validated() {
    if (guestHouseIdController.number == 0) {
      return _setState(text: 'Guest House is not chosen.');
    }
    if (bookingTypeIdController.number == 0) {
      return _setState(text: 'Booking type is not chosen');
    }
    if (roomTypeIdController.number == 0) {
      return _setState(text: 'Room type is not chosen');
    }
    if (nightStayIdController.number == 0) {
      return _setState(text: 'Stay type is not chosen');
    }
    if (guestTypeIdController.number == 0) {
      return _setState(text: 'Guest type is not chosen');
    }
    if (fromDateController.text == '') {
      return _setState(text: 'From date is not seted');
    }
    if (toDateController.text == '') {
      return _setState(text: 'To date is not seted');
    }
    if (numberOfGuestController.text == '') {
      return _setState(text: 'Number of guest not mentioned');
    }
    if (guestsAreIdController.number == 0) {
      return _setState(text: 'Who will the guest is not chosen');
    }
    if (_behalfTextFieldShow == true && onBehalfController.text == '') {
      return _setState(text: 'Behalf name & relation not mentioned');
    }

    return true;
  }

  bool _setState({required String text}) {
    setState(() {
      _errorText = text;
    });
    return false;
  }
}
