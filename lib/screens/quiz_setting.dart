// Score Settings
// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import '../widgets/button.dart';
import '../widgets/divider.dart';
import '../widgets/inputfield.dart';
import '../widgets/text.dart';

Map<String, bool> settingsJSON = {
  'Show / Hide Answer Shuffle Questions Order Show Leaderboard': false,
  'Shuffle Questions Order': false,
  'Show Leaderboard': false,
  'Participant scoreboard': false,
  'App Only': false,
  'Maximum Submit Limit Show / Hide Answer Shuffle Questions Order Show Leaderboard Shuffle Questions Order':
      false,
  'Start Time / End Time': false
};
Map<String, dynamic> fieldsJSON = {
  'name': null,
  'isRequired': false,
  'number': null,
  'isMinMax': false,
  'min': null,
  'max': null,
  'description': null,
};
Map<String, String> timeJSON = {
  'start': '',
  'end': '',
};
Map<String, String> limitJSON = {
  'limit': '',
};

List<Map<String, dynamic>> itemsss = [
  {
    'headerValue': 'Test 1',
    'isExpanded': true,
    'bodyValue': 'Option 1',
  },
  {
    'headerValue': 'Test 2',
    'isExpanded': false,
    'bodyValue': 'Option 2',
  }
];
Future<String> fetchData() async {
  return Future.delayed(const Duration(seconds: 3), () => 'Data loaded');
}

class Quiz_Settings extends StatelessWidget {
  const Quiz_Settings({super.key});
  @override
  Widget build(BuildContext context) {
    List<String> settingsOption = [
      "Show / Hide Answer Shuffle Questions Order Show Leaderboard",
      "Shuffle Questions Order",
      "Show Leaderboard",
      "Participant scoreboard",
      "App Only",
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                    text: 'PRINT with DELAY OF 3 Sec.',
                    onTap: () async {
                      String data = await fetchData();
                      debugPrint(data);
                    }),
                ...List.generate(
                  settingsOption.length,
                  (int index) {
                    return ScoreItemWidget(
                        label: settingsOption[index],
                        onCheckboxChanged: (boo) {
                          // debugPrint('${settingsOption[index]}-> $boo');
                          //  This is reading value from 'settingsOption' as this is Single Option without Right-Widget
                          // settingsJSON[settingsOption[index]] = boo;
                          settingsJSON.update(
                              settingsOption[index], (value) => boo,
                              ifAbsent: () => boo);
                        });
                  },
                ),
                //
                ReusableExpansionPanelList(items: itemsss),
                //
                ScoreItemWidget(
                  label:
                      'Maximum Submit Limit Show / Hide Answer Shuffle Questions Order Show Leaderboard Shuffle Questions Order',
                  rightWidget: true,
                  onCheckboxChanged: (val) {
                    // debugPrint('maximum submit limit -> $val');
                    settingsJSON.update(
                      'Maximum Submit Limit Show / Hide Answer Shuffle Questions Order Show Leaderboard Shuffle Questions Order',
                      (value) => val,
                      ifAbsent: () => val,
                    );
                  },
                ),
                // Time
                TimeRangeSelector(
                  initialStartTime: "10th Jan, Wed, 2024 at 10:15am",
                  initialEndTime: "10th Jan, Wed, 2024 at 12:15pm",
                  onCheckboxChanged: (val) {
                    // debugPrint('time range -> $str');
                    settingsJSON.update(
                      'Start Time / End Time',
                      (value) => val,
                      ifAbsent: () => val,
                    );
                  },
                  onTimeRangeChanged: (start, end) {
                    // debugPrint('time range changed -> $start $end');
                    timeJSON['start'] = start;
                    timeJSON['end'] = end;
                  },
                ),
                // Fields
                const AddFields(count: 1),
                // Button
                SizedBox(height: 18.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Button(
                        text: 'Save',
                        padding: const EdgeInsets.all(5),
                        textCenter: true,
                        height: 53.375.h,
                        width: 160.125.w,
                        color: const Color(0xFF00C85C),
                        onTap: () {
                          // debugPrint('SAVE');
                          debugPrint('$settingsJSON');
                          debugPrint('$limitJSON');
                          debugPrint('$timeJSON');
                        }),
                    Button(
                      text: 'Add field',
                      textCenter: true,
                      height: 53.375.h,
                      width: 160.125.w,
                      color: const Color(0xFFF6F6F6),
                      textColor: const Color(0xFF939393),
                      onTap: () {
                        debugPrint('$fieldsJSON\n');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//////////////////////////////////////////

class ReusableExpansionPanelList extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  const ReusableExpansionPanelList({super.key, required this.items});

  @override
  State<ReusableExpansionPanelList> createState() =>
      _ReusableExpansionPanelListState();
}

class _ReusableExpansionPanelListState
    extends State<ReusableExpansionPanelList> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        debugPrint('expansionCallback :$isExpanded');
        setState(() {
          value = isExpanded;
        });
      },
      elevation: 2, // Panel elevation
      expandedHeaderPadding:
          const EdgeInsets.all(8.0), // Padding for expanded header
      dividerColor: Colors.grey, // Divider color between panels
      children: widget.items.asMap().entries.map<ExpansionPanel>((entry) {
        // int index = entry.key;
        Map<String, dynamic> item = entry.value;

        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item['headerValue'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['bodyValue']),
          ),
          isExpanded: value,
        );
      }).toList(),
    );
  }
}

//////////////////////////////////////////

class ScoreItemWidget extends StatefulWidget {
  final String label;
  final bool? rightWidget;
  final Function(bool) onCheckboxChanged;

  const ScoreItemWidget({
    super.key,
    required this.label,
    this.rightWidget = false,
    required this.onCheckboxChanged,
  });

  @override
  ScoreItemWidgetState createState() => ScoreItemWidgetState();
}

class ScoreItemWidgetState extends State<ScoreItemWidget> {
  bool _isChecked = false;
  FontWeight fontWeight = FontWeight.w600;

  void _toggleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
    widget.onCheckboxChanged(_isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
          // color: Color(0xFFE6F9EF),
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: _toggleCheckbox, // Toggle checkbox on tap
            child: CustomCheckboxWidget(
              size: 40,
              borderRadius: 10,
              isChecked: _isChecked,
              onSelect: (val) {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: _toggleCheckbox, // Toggle checkbox on text tap
              child: TextWidget(
                text: widget.label,
                fontSize: 20,
                textOverflow: TextOverflow.visible,
                // maxLines: 2,
                softWrap: true,
                fontWeight: _isChecked ? FontWeight.w800 : fontWeight,
                color: Colors.black87,
              ),
            ),
          ),
          if (widget.rightWidget == true)
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: _buildTextField(),
            ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return SizedBox(
      width: 55,
      child: AnswerInputWidget(
        hintText: '50',
        textColor: Colors.black,
        keyboardType: TextInputType.number,
        onChanged: (input) {
          // debugPrint(input);
          limitJSON['limit'] = input;
        },
      ),
    );
  }
}

// TimeRangeSelector

class TimeRangeSelector extends StatefulWidget {
  final String initialStartTime;
  final String initialEndTime;
  final Function(bool) onCheckboxChanged;
  final Function(String, String)? onTimeRangeChanged;

  const TimeRangeSelector({
    super.key,
    required this.initialStartTime,
    required this.initialEndTime,
    required this.onCheckboxChanged,
    this.onTimeRangeChanged,
  });

  @override
  TimeRangeSelectorState createState() => TimeRangeSelectorState();
}

class TimeRangeSelectorState extends State<TimeRangeSelector> {
  bool isExpanded = false;
  bool isChecked = false;
  late String startTime;
  late String endTime;

  @override
  void initState() {
    super.initState();
    startTime = widget.initialStartTime;
    endTime = widget.initialEndTime;
  }

  void _toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onCheckboxChanged(isChecked);
  }

  Future<void> _selectDateTime(BuildContext context, bool isStartTime) async {
    final now = DateTime.now();
    final selectedDateTime = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (selectedDateTime != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(now),
      );

      if (selectedTime != null) {
        final newDateTime = DateTime(
          selectedDateTime.year,
          selectedDateTime.month,
          selectedDateTime.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        setState(() {
          if (isStartTime) {
            startTime = _formatDateTime(newDateTime);
          } else {
            endTime = _formatDateTime(newDateTime);
          }
        });
        widget.onTimeRangeChanged!(startTime, endTime);
      }
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return "${dateTime.day} ${_getMonthName(dateTime.month)}, ${_getWeekdayName(dateTime.weekday)}, ${dateTime.year} at ${TimeOfDay.fromDateTime(dateTime).format(context)}";
  }

  String _getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }

  String _getWeekdayName(int weekday) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return weekdays[weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffF6F6F6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Checkbox and Label
              Row(
                children: [
                  GestureDetector(
                    onTap: _toggleCheckbox,
                    child: CustomCheckboxWidget(
                      size: 40,
                      borderRadius: 10,
                      isChecked: isChecked,
                      onSelect: (val) {},
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _toggleCheckbox,
                    child: TextWidget(
                      text: "Start Time / End Time",
                      fontWeight: isChecked ? FontWeight.w800 : FontWeight.w600,
                      fontSize: 20,
                      textOverflow: TextOverflow.visible,
                      // maxLines: 1,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _toggleExpansion,
                    child: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.black,
                      size: 25,
                    ),
                  )
                ],
              ),
              // Expandable Content
              if (isExpanded) ...[
                const SizedBox(height: 10),
                const TextWidget(
                  text: "Start Time",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                GestureDetector(
                  onTap: () => _selectDateTime(context, true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.green, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(text: startTime, fontSize: 16),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const TextWidget(
                  text: "End Time",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                GestureDetector(
                  onTap: () => _selectDateTime(context, false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.green, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(text: endTime, fontSize: 16),
                        const Icon(Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

// Fields
class AddFields extends StatefulWidget {
  final int count;
  const AddFields({super.key, required this.count});

  @override
  AddFieldsState createState() => AddFieldsState();
}

class AddFieldsState extends State<AddFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xffF6F6F6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                text: 'Fields-',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              Row(
                children: [
                  Expanded(
                    child: AnswerInputWidget(
                      hintText: '${widget.count}. enter your field name',
                      textColor: const Color(0xFF818181),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      isCenter: false,
                      rightIcon: const Icon(CupertinoIcons.trash,
                          color: Color(0xFF00C85C), size: 25),
                      onChanged: (val) {
                        // debugPrint(val);
                        fieldsJSON['name'] = val;
                      },
                    ),
                  ),
                ],
              ),
              // option
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ScoreItemWidget(
                      label: 'Required',
                      onCheckboxChanged: (val) {
                        fieldsJSON['isRequired'] = val;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Dropdown(
                      items: const ["1", "2", "3", "4"],
                      hintText: 'Number',
                      dropdownBackgroundColor: const Color(0XFFF6F6F6),
                      onChanged: (number) {
                        // debugPrint('${widget.count} required $number');
                        fieldsJSON['number'] = number;
                      },
                    ),
                  ),
                ],
              ),
              // Min & Max
              const SizedBox(height: 10),
              Row(
                children: [
                  CustomCheckbox(
                    size: 40,
                    borderRadius: 10,
                    onSelect: (minMax) {
                      // debugPrint('min & max $minMax');
                      fieldsJSON['isMinMax'] = minMax;
                    },
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: AnswerInputWidget(
                      hintText: 'Min-',
                      isCenter: false,
                      textColor: Colors.black,
                      keyboardType: TextInputType.number,
                      onChanged: (minVal) {
                        // debugPrint('min $min');
                        fieldsJSON['min'] = minVal;
                      },
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 2,
                    child: AnswerInputWidget(
                      hintText: 'Max-',
                      isCenter: false,
                      keyboardType: TextInputType.number,
                      textColor: Colors.black,
                      onChanged: (maxVal) {
                        // debugPrint('min $max');
                        fieldsJSON['max'] = maxVal;
                      },
                    ),
                  ),
                ],
              ),
              AnswerInputWidget(
                hintText: 'write soething to test the field',
                textColor: const Color(0xFF818181),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                isCenter: false,
                onChanged: (textfield) {
                  // debugPrint(textfield);
                  fieldsJSON['description'] = textfield;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// CheckBox

class CustomCheckbox extends StatefulWidget {
  final double size;
  final bool initialCheckedState;
  final Color checkedColor;
  final Color uncheckedColor;
  final Color checkColor;
  final double borderRadius;
  final ValueChanged<bool> onSelect;
  final IconData? icon;
  const CustomCheckbox({
    super.key,
    this.size = 24,
    this.initialCheckedState = false,
    this.checkedColor = const Color(0XFF00C85C),
    this.uncheckedColor = const Color.fromARGB(255, 128, 227, 173),
    this.checkColor = Colors.white,
    this.borderRadius = 15,
    required this.onSelect,
    this.icon,
  });

  @override
  CustomCheckboxState createState() => CustomCheckboxState();
}

class CustomCheckboxState extends State<CustomCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialCheckedState;
  }

  void _toggleCheckbox() {
    setState(() {
      isChecked = !isChecked;
    });
    widget.onSelect(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCheckbox, // Tapping toggles the checkbox
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            color: isChecked ? widget.checkedColor : widget.uncheckedColor,
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: isChecked
              ? Icon(
                  widget.icon ?? Icons.check_rounded,
                  color: widget.checkColor,
                  size: widget.size * 0.75,
                )
              : null,
        ),
      ),
    );
  }
}
// CheckBox

class CustomCheckboxWidget extends StatelessWidget {
  final double size;
  final Color checkedColor;
  final bool isChecked;
  final Color uncheckedColor;
  final Color checkColor;
  final double borderRadius;
  final ValueChanged<bool> onSelect;
  const CustomCheckboxWidget({
    super.key,
    required this.isChecked,
    this.size = 24,
    this.checkedColor = const Color(0XFF00C85C),
    this.uncheckedColor = const Color.fromARGB(255, 128, 227, 173),
    this.checkColor = Colors.white,
    this.borderRadius = 15,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isChecked ? checkedColor : uncheckedColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: isChecked
            ? Icon(
                Icons.check_rounded,
                color: checkColor,
                size: size * 0.75,
              )
            : null,
      ),
    );
  }
}

///// DROPDOWN

class Dropdown extends StatelessWidget {
  final List<String> items;
  final dynamic Function(String?)? onChanged;
  // final int initialIndex;
  final String hintText;
  final double fontSize;
  final Color hintTextColor;
  final Color headerTextColor;
  final Color listItemTextColor;
  final Color dropdownBackgroundColor;
  final Color iconColor;
  final bool? hasDivider;
  final Color? dividerColor;
  final double? dividerThickness;
  final FontWeight? fontWeight;
  final double? borderRadius;
  const Dropdown({
    super.key,
    required this.items,
    required this.onChanged,
    // this.initialIndex = 0,
    this.hintText = 'Hint Text!',
    this.fontSize = 16,
    this.hintTextColor = Colors.black,
    this.headerTextColor = Colors.black,
    this.listItemTextColor = Colors.black,
    this.iconColor = Colors.black,
    this.dropdownBackgroundColor = Colors.transparent,
    this.hasDivider = true,
    this.dividerColor,
    this.dividerThickness,
    this.fontWeight,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle commonTextStyle = GoogleFonts.nunito(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? 0),
          child: CustomDropdown<String>(
            hintText: hintText,
            items: items,
            // initialItem: items[initialIndex],
            excludeSelected: false,
            onChanged: onChanged,
            closedHeaderPadding: EdgeInsets.zero,
            // final EdgeInsets? closedHeaderPadding;
            // final EdgeInsets? expandedHeaderPadding;
            // final EdgeInsets? itemsListPadding;
            // final EdgeInsets? listItemPadding;
            // overlayHeight: 40,
            itemsListPadding: EdgeInsets.zero,
            decoration: CustomDropdownDecoration(
              closedFillColor: dropdownBackgroundColor,
              expandedFillColor: dropdownBackgroundColor,
              hintStyle: commonTextStyle.copyWith(color: hintTextColor),
              headerStyle: commonTextStyle.copyWith(color: headerTextColor),
              listItemStyle: commonTextStyle.copyWith(color: listItemTextColor),
              closedSuffixIcon:
                  Icon(Icons.keyboard_arrow_down, color: iconColor),
              expandedSuffixIcon:
                  Icon(Icons.keyboard_arrow_down, color: iconColor),
            ),
          ),
        ),
        if (hasDivider!)
          DividerWidget(
            thickness: dividerThickness ?? 2,
            color: dividerColor ?? Colors.green,
            padding: EdgeInsets.zero,
          )
      ],
    );
  }
}
