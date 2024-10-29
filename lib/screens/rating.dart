import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:in_app_review/in_app_review.dart';

import '../function/darkencolor.dart';
import '../widgets/button.dart';
import '../widgets/inputfield.dart';
import '../widgets/text.dart';

class RatingPage extends StatelessWidget {
  const RatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Button(
          text: 'Rate US here',
          color: Colors.deepPurple.shade100,
          textColor: Colors.black45,
          onTap: () => openAppStoreReview(context),
        ),
      ),
    );
  }
}

void openAppStoreReview(BuildContext context) async {
  // final Uri url = Uri.parse('https://apps.apple.com/us/app/your-app-name/id');
  final InAppReview inAppReview = InAppReview.instance;
  if (await inAppReview.isAvailable()) {
    debugPrint('requestReview');
    inAppReview.requestReview();
    // Open the store review page
    // inAppReview.openStoreListing();
  } else {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => RatingDialog(
        onSubmit: (rating, feedback) {
          debugPrint('Rating: $rating Feedback: $feedback');
        },
      ),
    );
  }
}

class RatingDialog extends StatefulWidget {
  final Function(int, String?) onSubmit;
  const RatingDialog({super.key, required this.onSubmit});

  @override
  RatingDialogState createState() => RatingDialogState();
}

class RatingDialogState extends State<RatingDialog> {
  int selectedRating = 0;
  bool submitted = false;
  bool showFeedback = false;
  String? feedback = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (submitted) {
      return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
        title: Center(
          child: TextWidget(
            text: 'Thanks for\nsubmitting a review!',
            fontSize: 18.w,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100.w,
              height: 100.w,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoMjTej17jyKAPjSPj9WUba4nxOaXh5_rIz-aoWffQ1aPO_REI',
                ),
              ),
            ),
            SizedBox(height: 8.w),
            Row(
              children: [
                Expanded(
                  child: Button(
                    text: 'Undo',
                    textCenter: true,
                    textColor: Colors.black,
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(
                          width: 1, color: darkenColor(Colors.white)),
                      right: BorderSide(
                          width: 1, color: darkenColor(Colors.white)),
                      top: BorderSide(
                          width: 1, color: darkenColor(Colors.white)),
                      bottom: BorderSide(
                          width: 5, color: darkenColor(Colors.white)),
                    ),
                    onTap: () {
                      setState(() {
                        submitted = false;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Button(
                      text: 'Submit',
                      textCenter: true,
                      textColor: Colors.white,
                      color: Colors.amber,
                      border: Border(
                        left: BorderSide(
                            width: 1, color: darkenColor(Colors.amber)),
                        right: BorderSide(
                            width: 1, color: darkenColor(Colors.amber)),
                        top: BorderSide(
                            width: 1, color: darkenColor(Colors.amber)),
                        bottom: BorderSide(
                            width: 5, color: darkenColor(Colors.amber)),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
      title: TextWidget(
        text: 'Rate your experience',
        fontSize: 18.w,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showFeedback)
            AnswerInputWidget(
                controller: controller,
                hintText: 'Public review',
                fontSize: 18.w,
                textColor: Colors.black,
                fontWeight: FontWeight.w600,
                isCenter: false,
                maxLength: 250,
                onChanged: (val) {
                  feedback = val;
                }),
          if (!showFeedback)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => IconButton(
                  icon: Icon(
                    Icons.star,
                    color: selectedRating > index
                        ? Colors.amber
                        : darkenColor(Colors.grey.shade200),
                    size: 30.w,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedRating = index + 1;
                      if (selectedRating > 0 && selectedRating <= 3) {
                        showFeedback = true;
                      }
                    });
                  },
                ),
              ),
            ),
        ],
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: Button(
                text: 'Cancel',
                textCenter: true,
                textColor: Colors.black,
                color: Colors.white,
                border: Border(
                  left: BorderSide(width: 1, color: darkenColor(Colors.white)),
                  right: BorderSide(width: 1, color: darkenColor(Colors.white)),
                  top: BorderSide(width: 1, color: darkenColor(Colors.white)),
                  bottom:
                      BorderSide(width: 5, color: darkenColor(Colors.white)),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Button(
                text: 'Submit',
                textCenter: true,
                textColor: Colors.white,
                color: Colors.amber,
                border: Border(
                  left: BorderSide(width: 1, color: darkenColor(Colors.amber)),
                  right: BorderSide(width: 1, color: darkenColor(Colors.amber)),
                  top: BorderSide(width: 1, color: darkenColor(Colors.amber)),
                  bottom:
                      BorderSide(width: 5, color: darkenColor(Colors.amber)),
                ),
                onTap: selectedRating == 0
                    ? null
                    : () {
                        // sending the rating
                        widget.onSubmit(selectedRating, feedback);
                        setState(() {
                          submitted = true;
                        });
                      },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
