import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:pust_guest_house/core/common/widgets/small_title.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';

class MyDateTimePicker extends StatefulWidget {
  final TextEditingController fromDateController;
  final TextEditingController toDateController;
  final String title;

  const MyDateTimePicker({
    super.key,
    required this.fromDateController,
    required this.toDateController,
    required this.title,
  });

  @override
  State<MyDateTimePicker> createState() => _MyDateTimePickerState();
}

class _MyDateTimePickerState extends State<MyDateTimePicker> {
  DateTime? selectedDate;
  DateTime first = DateTime.now();
  DateTime last = DateTime.now();
  // Time selectedTime = Time(hour: 9, minute: 45);
  bool _isDateTimeSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallTitle(title: widget.title),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: (_isDateTimeSelected) ? Colors.grey : Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5)),
          child: ListTile(
            title: (_isDateTimeSelected)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'From : ${widget.fromDateController.text.substring(0, 16)}'),
                      Text('To : ${widget.toDateController.text.substring(0,16)}'),
                    ],
                  )
                : Text(
                    'Select date time',
                  ),
            trailing: const Icon(Icons.calendar_today),
            onTap: () async {
              _selectDateTimeRange(context);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _selectDateTimeRange(BuildContext context) async {
    // Pick Date Range
    final DateTimeRange? pickedDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      helpText: 'Select Date Range',
      saveText: 'Next->',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.blue, // Header background color
              onPrimary: AppPallete.black, // Header text color
              onSurface: AppPallete.black, // Body text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDateRange != null) {
      // Pick Start Time
      final TimeOfDay pickedStartTime = await _selectTime(
        text: 'Arrival Time Confirm',
      );

      // Pick End Time
      final TimeOfDay pickedEndTime = await _selectTime(
        text: 'Departure Time Confirm',
      );
      // _selectedDateRange = pickedDateRange;
      // _startTime = pickedStartTime;
      // _endTime = pickedEndTime;
      setState(() {
        widget.fromDateController.text =
            '${pickedDateRange.start.toString().substring(0, 10)}' +
                ' ${(pickedStartTime.hour < 10) ? '0' : ''}' +
                '${(pickedStartTime.hour)}:${(pickedStartTime.minute < 10) ? '0' : ''}' +
                '${pickedStartTime.minute}:00.000';
        widget.toDateController.text =
            '${pickedDateRange.end.toString().substring(0, 10)}' +
                ' ${(pickedEndTime.hour < 10) ? '0' : ''}${(pickedEndTime.hour)}:' +
                '${(pickedEndTime.minute < 10) ? '0' : ''}' +
                '${pickedEndTime.minute}:00.000';

        _isDateTimeSelected = true;
      });
    }
  }

  Future<Time> _selectTime({required String text}) async {
    Time _selectedTime = Time(hour: 9, minute: 0);
    await Navigator.of(context).push(
      showPicker(
        context: context,
        value: _selectedTime,
        sunrise: TimeOfDay(hour: 6, minute: 0), // optional
        sunset: TimeOfDay(hour: 18, minute: 0), // optional
        duskSpanInMinutes: 120, // optional
        cancelText: '',
        okText: text,
        onChange: (Time newTime) {
          setState(() {
            _selectedTime = newTime;
          });
        },
      ),
    );
    return _selectedTime;
  }
}
