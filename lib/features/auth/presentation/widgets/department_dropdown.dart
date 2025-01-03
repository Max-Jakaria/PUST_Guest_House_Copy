import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pust_guest_house/core/theme/app_pallete.dart';
import 'package:pust_guest_house/core/common/widgets/separator.dart';
import 'package:pust_guest_house/core/common/widgets/custom_text_field.dart';

class DepartmentDropdown extends StatefulWidget {
  final TextEditingController controller;
  const DepartmentDropdown({super.key, required this.controller});

  @override
  State<DepartmentDropdown> createState() => _DepartmentDropdownState();
}

class _DepartmentDropdownState extends State<DepartmentDropdown> {
  bool _isDepartmentChose = false;
  bool _isOther = false;
  String _department = "Chose your Department";
  List<String> departmentList = [
    "Chose your Department",
    "01 - Computer Science and Engineering(CSE)",
    "02 - Electrical and Electronic Engineering(EEE)",
    "03 - Mathematics(MATH)",
    "04 - Business Administration(DBA)",
    "05 - Electrical, Electronic and Communication Engineering(EECE)",
    "06 - Information and Communication Engineering(ICE)",
    "07 - Physics",
    "08 - Economics",
    "09 - Geography and Environment(GE)",
    "10 - Bangla",
    "11 - Civil Engineering",
    "12 - Architecture",
    "13 - Pharmacy",
    "14 - Chemistry",
    "15 - Social Work(SW)",
    "16 - Statistics(STAT)",
    "17 - Urban and Regional Planning(URP)",
    "18 - English",
    "19 - Public Administration",
    "20 - History(HBS)",
    "21 - Tourism and Hospitality Management(THM)",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                color:
                    _isDepartmentChose ? Colors.grey : AppPallete.dangerColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(2)),
          child: DropdownButton(
            value: _department,
            isExpanded: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            items: departmentList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                _department = value!;
                if (value == departmentList.first) {
                  _isDepartmentChose = false;
                  _isOther = false;
                  widget.controller.text = '';
                } else if (value == departmentList.last) {
                  _isDepartmentChose = true;
                  _isOther = true;
                  widget.controller.text = '';
                } else {
                  _isDepartmentChose = true;
                  widget.controller.text = value;
                  _isOther = false;
                }
              });
            },
          ),
        ),
        _isOther ? Separator.textField() : Container(),
        _isOther
            ? MyTextField(
                hintText: 'Enter your office Position',
                labelText: 'Office',
                controller: widget.controller,
              )
            : Container(),
      ],
    );
  }
}
