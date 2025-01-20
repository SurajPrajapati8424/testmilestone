import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testmilestone/widgets/inputfield.dart';

import '../function/copy.dart';
import '../function/darkencolor.dart';
import '../function/share.dart';
import '../widgets/button.dart';

import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../widgets/text.dart';

// Live Quiz Screen (show QR code and share)
class LiveQuizz extends StatelessWidget {
  const LiveQuizz({super.key});

  @override
  Widget build(BuildContext context) {
    int totalParticipants = 0;
    const String code = '456840';
    const String logoUrl =
        'https://s3-alpha-sig.figma.com/img/c72a/9f77/73df9e5df367af5797872e025b89090d?Expires=1737936000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CzSiGfPBr2JIwRel-WK9N~DE~RxXgXVGP9M43rIMLDNCc~v-l9YWZBa7mSjJ1lr4klqaosd-rOTum097fS1NvT40KEe5Fcm6Ui0aQNyZAdfYhSTwY3W8ocAlG77WFON3KoqUe2Drd1oSt76v2tepWlxmQ6WcpdDdpSassZEFm80pk5uBWIYwYiR~WcWCSo3c4MGG9l8xgtBjhtBKK0SMfDl3GkrK8sT9xTrPOxuEsR67wKEVKtULQXrk2oeYdwB1j4yq3UKpHlgJvjpCbvnHQG6x3jyahu1xt4-gbk3uMh2wpvPeKYqxVhAxgdxYFsI1w02fon-8TiQf5U0cB2bi1Q__';
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Live Quiz 02',
              isBackButton: true,
              rightWidgets: [
                Icon(CupertinoIcons.ellipsis_circle, color: Colors.black)
              ],
            ),
            qrCodeSection(shareCode: code, logoUrl: logoUrl),

            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: buildActionButtons(context: context, code: code),
            ),

            // Participants Counter
            Expanded(
              child: Center(
                child: TextWidget(
                  text: getParticipantsText(totalParticipants),
                  fontSize: 20.w,
                  color: const Color(0xFF212121),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // Start Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.w),
              child: Button(
                width: MediaQuery.of(context).size.width,
                text: 'Start Quiz',
                textCenter: true,
                textColor: Colors.white,
                color: const Color(0xFF00C85C),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EmptyLive()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget qrCodeSection({required String shareCode, required String logoUrl}) {
    int number = int.parse(shareCode.trim());
    String formattedNumber = formatNumber(number);
    QrCode qrCode = QrCode.fromData(
        data: 'https://aq_quiz.com/join/$number',
        errorCorrectLevel: QrErrorCorrectLevel.H);
    QrImage qrImage = QrImage(qrCode);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // QR Code Container
        Container(
          height: 200.w,
          width: 200.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
              top: BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
              bottom: BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.w),
              bottomLeft: Radius.circular(20.w),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(18.w),
            child: PrettyQrView(
              qrImage: qrImage,
              decoration: PrettyQrDecoration(
                shape: const PrettyQrSmoothSymbol(color: Colors.black),
                image: PrettyQrDecorationImage(
                  image: NetworkImage(logoUrl),
                  fit: BoxFit.contain,
                  scale: 0.2,
                ),
              ),
            ),
          ),
        ),
        // Share Code Container
        Container(
          height: 200.w,
          width: 130.w,
          decoration: BoxDecoration(
            color: const Color(0xFF00C85C),
            border: Border(
              right: BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
              top: BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
              bottom: BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
            ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.w),
              bottomRight: Radius.circular(20.w),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget(
                text: formattedNumber,
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
              SizedBox(height: 10.w),
              Button(
                text: 'Share Code',
                textCenter: true,
                textColor: const Color(0xFF00C85C),
                color: Colors.white,
                fontSize: 15.w,
                fontWeight: FontWeight.w800,
                onTap: () {
                  ShareOption.shareTextOrUrl(
                      'https://aq_quiz.com/join/$number', 'Join Quiz');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildActionButtons(
      {required BuildContext context, required String code}) {
    return Column(
      children: [
        SizedBox(height: 30.w),
        Button(
          text: 'Get Host Code',
          width: MediaQuery.sizeOf(context).width,
          color: const Color(0xFFEEEEEE),
          textColor: Colors.grey.shade800,
          textCenter: true,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          onTap: () => showHostCode(context: context, code: code),
        ),
        SizedBox(height: 15.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Button(
              text: 'Share Link',
              width: 150.w,
              color: Colors.blue,
              textCenter: true,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              onTap: () {},
            ),
            Button(
              text: 'Setting',
              width: 150.w,
              color: Colors.orange,
              textCenter: true,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  String getParticipantsText(int totalParticipants) {
    return totalParticipants > 0
        ? '$totalParticipants Participants Joined'
        : 'No Participants Joined';
  }

  Future<dynamic> showHostCode(
      {required BuildContext context, required String code}) {
    final String formatedText = formatNumber(int.parse(code.trim()));
    return showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey.shade100,
      barrierColor: Colors.black.withOpacity(.4),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.w))),
      builder: (context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.w),
            // Top Drag Icon
            Container(
              height: 4.w,
              width: 40.w,
              margin: EdgeInsets.only(bottom: 16.w),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.w),
              ),
            ),
            // HOST CODE TITLE
            TextWidget(
              text: 'HOST CODE',
              fontSize: 26.w,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
            SizedBox(height: 25.w),
            // CODE BUTTON
            Button(
              text: formatedText,
              width: MediaQuery.sizeOf(context).width,
              textCenter: true,
              textColor: Colors.white,
              color: const Color(0xFF00C85C),
              fontSize: 20.w,
              fontWeight: FontWeight.w700,
              onTap: () {},
            ),
            SizedBox(height: 25.w),
            // LAST ROW
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 53.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(12.w),
                    border: Border(
                      bottom: BorderSide(
                          width: 5.w, color: darkenColor(Colors.blue)),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Button(
                        text: 'Share',
                        topIcon:
                            Icon(Icons.share, color: Colors.white, size: 18.w),
                        fontSize: 12.w,
                        fontWeight: FontWeight.w700,
                        color: Colors.transparent,
                        border: Border.all(width: 0, color: Colors.transparent),
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 5.w, bottom: 0),
                        onTap: () {
                          ShareOption.shareTextOrUrl(
                              'https://aq_quiz.com/join/$code', 'Join Quiz');
                        },
                      ),
                      SizedBox(width: 5.w),
                      Button(
                        text: 'Copy',
                        topIcon:
                            Icon(Icons.copy, color: Colors.white, size: 18.w),
                        fontSize: 12.w,
                        fontWeight: FontWeight.w700,
                        color: Colors.transparent,
                        border: Border.all(width: 0, color: Colors.transparent),
                        padding: EdgeInsets.only(
                            left: 10.w, right: 10.w, top: 5.w, bottom: 0),
                        onTap: () {
                          CopyText(contexts: context, text: code);
                        },
                      ),
                    ],
                  ),
                ),
                Button(
                  height: 53.w,
                  text: 'Regenerate Host Code',
                  textCenter: true,
                  textColor: Colors.white,
                  color: const Color(0xFFFF981F),
                  fontSize: 15.w,
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
            SizedBox(height: 10.w),
          ],
        ),
      ),
    );
  }

  String formatNumber(int number) {
    return number
        .toString()
        .splitMapJoin(RegExp(r'(\d{3})'), onMatch: (match) => '${match[0]} ');
  }
}

class EmptyLive extends StatelessWidget {
  const EmptyLive({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> list = [
      'Developer',
      'Designer',
      'Consultant',
      'Student',
    ];
    return Scaffold(
      body: Column(
        children: [
          // AppBar
          CustomAppBar(
            title: 'Live Quiz 02',
            isBackButton: true,
            rightWidgets: [
              Button(
                text: 'Save',
                textCenter: true,
                padding: EdgeInsets.symmetric(vertical: 5.w, horizontal: 12.w),
                fontSize: 15.w,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
                color: const Color(0xFF00C85C),
              )
            ],
            centerWidget: [
              Container(
                height: 45.w,
                width: 100.w,
                padding: EdgeInsets.only(left: 5.w, right: 5.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.w),
                    border: Border.all(width: 3.w, color: Colors.black)),
                child: CustomDropdown<String>(
                  hintText: 'Text',
                  items: list,
                  excludeSelected: false,
                  itemsListPadding: EdgeInsets.zero,
                  listItemPadding: EdgeInsets.all(5.w),
                  closedHeaderPadding: EdgeInsets.zero,
                  expandedHeaderPadding: EdgeInsets.zero,
                  decoration: CustomDropdownDecoration(
                    hintStyle: GoogleFonts.nunito(
                        fontSize: 14.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                    listItemStyle: GoogleFonts.nunito(
                        fontSize: 14.w,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                    closedSuffixIcon: Icon(Icons.keyboard_arrow_down,
                        color: Colors.black, size: 22.w),
                    expandedSuffixIcon: Icon(Icons.keyboard_arrow_up,
                        color: Colors.black, size: 22.w),
                  ),
                  onChanged: (value) {
                    debugPrint('value: $value');
                  },
                ),
              ),
            ],
            // textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.w),
          // Writting Box
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200.w,
                width: 200.w,
                alignment: Alignment.center,
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    left:
                        BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
                    top: BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
                    bottom:
                        BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.w),
                    bottomLeft: Radius.circular(20.w),
                  ),
                ),
                child: SingleChildScrollView(
                  child: AnswerInputWidget(
                    hintText: 'Write text here...',
                    textColor: const Color(0xFF757575),
                    fontSize: 18.w,
                    fontWeight: FontWeight.w700,
                    isCenter: true,
                    hasDivider: false,
                    onChanged: (tx) {
                      debugPrint(tx);
                    },
                  ),
                ),
              ),
              // Share Code Container
              Container(
                height: 200.w,
                width: 130.w,
                decoration: BoxDecoration(
                  border: Border(
                    right:
                        BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
                    top: BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
                    bottom:
                        BorderSide(width: 3.w, color: const Color(0xFF00C85C)),
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.w),
                    bottomRight: Radius.circular(20.w),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(17.8.w),
                    bottomRight: Radius.circular(17.8.w),
                  ),
                  child: Image.network(
                    'https://s3-alpha-sig.figma.com/img/bf47/fad0/ff38d616c5acc2d5f5f0631e2fe819ab?Expires=1737936000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Jkn4cYEv-DdtUDk5wqhQmowCvrW50E02BVr3tI4XnJ8NVCcRgGUTXI7g6XFUPE2badw7d3cDqfACl2Zz6wIswBUn6Hf3kmo24hP58~U-waCT0c5-3PwyRG25wmdVoLJm9Uw~dhZTH5JZSPaf6bfdB9O08osiSGHiZ3LI7N8cZNY40qva9KSs5bktf9VIPwLiehSsOSv3lZlleZHczvTxhqOSUT98HGD-Xitsr9RtoiJ5rkMALxx0LYj20fbx3r81i4-MlvRDMx4xIaMgsI4nUVEwy0oi7noyMEzNFzAsQ3jZPm1YHlkMzoZDG9MNhTy0iLG0sIByKNp1qgbCUCbRHw__',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30.w),
          // Delete Icon
          Row(
            children: [
              Expanded(child: Container()),
              IconButton(
                icon: Icon(CupertinoIcons.delete_simple,
                    color: Colors.black, size: 25.w),
                onPressed: () {},
              ),
              SizedBox(width: 20.w),
            ],
          ),
        ],
      ),
    );
  }
}

////////////////
class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData? icons;
  final bool isBackButton;
  final Function()? onLeftWidgetTap;
  final List<Widget>? leftWidgets;
  final List<Widget>? rightWidgets;
  final List<Widget>? centerWidget;
  final TextAlign? textAlign;
  final double? fontSize;
  const CustomAppBar({
    super.key,
    required this.title,
    this.icons,
    this.isBackButton = false,
    this.onLeftWidgetTap,
    this.leftWidgets,
    this.rightWidgets,
    this.textAlign,
    this.fontSize,
    this.centerWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          if (isBackButton)
            GestureDetector(
              onTap: () {
                debugPrint('back');
              },
              child: Padding(
                padding: EdgeInsets.only(left: 14.w),
                child: Icon(
                  icons ?? Icons.arrow_back,
                  color: const Color(0xFF2A2A2A),
                  size: 21.875.w,
                ),
              ),
            ),
          if (isBackButton == false && leftWidgets!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 14.w),
              child: GestureDetector(
                  onTap: onLeftWidgetTap, child: Row(children: leftWidgets!)),
            ),
          Expanded(
            child: centerWidget != null
                ? Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: centerWidget!),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: textAlign != null ? 0 : 13.125.w,
                        top: 13.125.w,
                        right: 14.875.w,
                        bottom: 13.125.w),
                    child: TextWidget(
                      text: title,
                      textOverflow: TextOverflow.ellipsis,
                      color: const Color(0xFF2A2A2A),
                      fontSize: fontSize ?? 17.5.w,
                      fontWeight: FontWeight.w800,
                      textAlign: textAlign ?? TextAlign.start,
                    ),
                  ),
          ),
          if (rightWidgets!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 3.w),
              child: Row(children: rightWidgets!),
            ),
        ],
      ),
    );
  }
}
