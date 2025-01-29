import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testmilestone/screens/profile.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

import '../widgets/inputfield.dart';
import '../widgets/text.dart';

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // Define controllers as instance variables
    final TextEditingController nameController =
        TextEditingController(text: 'Jon doe');
    final TextEditingController emailController =
        TextEditingController(text: 'jon.doe@gmail.com');
    final TextEditingController phoneController =
        TextEditingController(text: '9130055503');
    final TextEditingController ageController =
        TextEditingController(text: '31');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              const CustomAppBar(
                title: 'Personal Info',
                isBackButton: true,
                rightWidgets: [],
              ),
              SizedBox(height: 10.w),
              // https://i.pravatar.cc/150?img=2 | https://picsum.photos/200
              // User Profile
              userProfile(),
              SizedBox(height: 10.w),
              const DividerWidget(), // divider
              SizedBox(height: 10.w),
              // Form Fields

              _buildFormField('Full Name', 'Andrew Ainsley', nameController,
                  onTap: (val) {
                debugPrint(val);
              }),
              _buildFormField(
                  'Email', 'andrew.ainsley@yourdomain.com', emailController,
                  onTap: (v) {
                debugPrint(v);
              }),
              _buildFormField('Phone Number', '+91-2223334444', phoneController,
                  keyboardType: TextInputType.number,
                  maxLength: 10, onTap: (v) {
                debugPrint(v);
              }),
              _buildDateField('Date of Birth', '12/27/1995', onTap: (v) {
                DateTime parseDate = DateTime.parse(v);
                debugPrint(
                    '${parseDate.day}/${parseDate.month}/${parseDate.year}');
              }),
              _buildDropdownField('Country', 'Indian', onTap: (v) {
                debugPrint(v);
              }),
              _buildFormField('Age', '25', ageController,
                  keyboardType: TextInputType.number, maxLength: 2, onTap: (v) {
                debugPrint(v);
              }),
            ],
          ),
        ),
      )),
    );
  }

  Widget userProfile() {
    return GestureDetector(
      onTap: () => debugPrint('Profile Edit'),
      child: Stack(
        children: [
          Container(
            width: 110.w,
            height: 110.w,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 217, 216, 217)),
            child: ClipOval(
              child: Image.network(
                'https://picsum.photos/600',
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color.fromARGB(255, 217, 216, 217),
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 55.w,
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : const Center(
                          child: CircularProgressIndicator(
                              color: Color(0xFF00C85C)));
                },
              ),
            ),
          ),
          Positioned(
            bottom: 2.w,
            right: 2.5.w,
            child: Container(
              height: 22.w,
              width: 22.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.2.w),
                color: const Color(0xFF00C85C),
              ),
              child: Icon(
                Icons.edit,
                size: 18.w,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///////
  Widget _buildFormField(
      String label, String hint, TextEditingController controller,
      {TextInputType? keyboardType,
      int? maxLength,
      required Function(String) onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          fontSize: 16.w,
          fontWeight: FontWeight.w700,
        ),
        SizedBox(height: 5.w),
        AnswerInputWidget(
          controller: controller,
          hintText: hint,
          textColor: Colors.black,
          fontSize: 18.w,
          fontWeight: FontWeight.w700,
          isCenter: false,
          maxLines: 1,
          maxLength: maxLength,
          keyboardType: keyboardType ?? TextInputType.text,
          onChanged: (val) => onTap(val),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDateField(String label, String value,
      {required Function(String) onTap}) {
    DateTime dob = DateTime(2001, 1, 11);
    DateTime now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          fontSize: 16.w,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 8),
        TimePickerSpinnerPopUp(
          mode: CupertinoDatePickerMode.date,
          initTime: dob, // default value
          minTime: DateTime(now.year - 100, now.month, now.day),
          maxTime: DateTime.now(),
          cancelText: 'Cancel',
          confirmText: 'OK',
          enable: true,
          use24hFormat: false,
          radius: 10,
          pressType: PressType.singlePress,
          timeFormat: 'dd/MM/yyyy',
          // Customize your time widget
          textStyle: GoogleFonts.nunito(
            color: Colors.black,
            fontSize: 18.w,
            fontWeight: FontWeight.w700,
          ),
          barrierColor: Colors.transparent,
          timeWidgetBuilder: (dateTime) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextWidget(
                      text:
                          '${dateTime.day}/${dateTime.month}/${dateTime.year}',
                      fontSize: 16.w,
                      fontWeight: FontWeight.w700,
                      textAlign: TextAlign.start,
                    ),
                    Icon(Icons.calendar_month_rounded,
                        size: 22.w, color: const Color(0xFF00C85C))
                  ],
                ),
                SizedBox(height: 5.w),
                DividerWidget(
                  thickness: 2.w,
                  color: const Color(0xFF00C85C),
                  padding: EdgeInsets.zero,
                ),
              ],
            );
          },
          locale: const Locale('en'),
          onChange: (dateTime) => onTap(dateTime.toString()),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildDropdownField(String label, String value,
      {required Function(String) onTap}) {
    final list = [
      'Indian',
      'Middle Eastern',
      'Western',
      'Chinese',
      'United States',
      'Italian',
    ];
    final index = list.indexOf(value);
    TextStyle style = GoogleFonts.nunito(
      color: Colors.black,
      fontSize: 18.w,
      fontWeight: FontWeight.w700,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: label,
          fontSize: 16.w,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 8),
        CustomDropdown<String>.search(
          hintText: 'Select Country',
          items: list,
          initialItem: index != -1 ? list[list.indexOf(value)] : list[1],
          // overlayHeight: 342,
          decoration: CustomDropdownDecoration(
              closedFillColor: Colors.white,
              hintStyle: style,
              listItemStyle: style.copyWith(fontSize: 14.w),
              headerStyle: style,
              closedSuffixIcon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: const Color(0xFF00C85C), size: 24.w)),
          closedHeaderPadding: EdgeInsets.zero,
          onChanged: (value) => onTap(value!),
        ),
        DividerWidget(
          thickness: 2.w,
          color: const Color(0xFF00C85C),
          padding: EdgeInsets.zero,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
