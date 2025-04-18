import 'package:flutter/material.dart';
import 'package:string_contains/string_contains.dart';

// ignore: must_be_immutable
class StringcontainsScreen extends StatelessWidget {
  final String? stringContainsBadWords = 'I am CEO, Bitch';

  final stringContainsUrl = 'Please visit our website : https://betterx.io/.';

  final stringContainsMultipleUrls =
      'Please visit our website : https://betterx.io/ and you can search for any thing on google : google.com, I love Dart : https://dart.dev/, you can practice on : https://dartpad.dev/. Flutter uses Dart, you can create your own app with Flutter : https://flutter.dev/, this is a good example of Flutter : https://flutter.dev/docs/get-started/.';

  final stringContainsEmail =
      "BetterX.io : Let's build something Better, User-centered & beautiful together\n for more info contact us at : info@betterx.io. My Personal Email : ravikumar2710999@gmail.com.\n A fake email : gedoye9446@roxoas.com.";

  final stringContainsPhoneNumber =
      '''My Phone Number : +91-9000000001 and some of other eg. of phone numbers ->

  /// 0. 9000000769
  /// 1. (123) 456-7890
  /// 2. (123)456-7890
  /// 3. 123-456-7890
  /// 4. 123.456.7890
  /// 5. 1234567890
  /// 6. +31636363634
  /// 7. 075-63546725
  ''';

  final normalString = 'I love Dart and Flutter';

  final stringContainsHashtags =
      'I love #dart and #flutter. @flutter is #awesome. #dart are #amazing.';

  String? stringOfBadWords = 'I am ceo bitch';

  StringcontainsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('String Contains'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // String Contains Bad Words
                Text(
                  '$stringContainsBadWords contains bad-word/profane-word : ${stringContainsBadWords.containsBadWord() == true ? 'Yes' : 'No'}\n clean bad words: ${stringContainsBadWords.cleanBadWords()}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const Divider(thickness: 2),
                // String Contains Url
                Text(
                  '$stringContainsUrl contains url : ${stringContainsUrl.containsUrl() == true ? 'Yes' : 'No'}\n get all urls: ${stringContainsUrl.getUrls()}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const Divider(thickness: 2),
                // String Contains Multiple Urls
                Text(
                  '$stringContainsMultipleUrls contain urls : ${stringContainsMultipleUrls.containsUrl() == true ? 'Yes' : 'No'}\n get all urls:\n${stringContainsMultipleUrls.getUrls().join('\n')}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const Divider(thickness: 2),
                // String Contains Email
                Text(
                  '$stringContainsEmail contains email : ${stringContainsEmail.containsEmail() == true ? 'Yes' : 'No'}\n get all emails:\n${stringContainsEmail.getEmails().join('\n')}\n',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const Divider(thickness: 2),
                // hide email
                Text(
                  stringContainsEmail.hideEmails(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const Divider(thickness: 2),
                Text(
                  stringOfBadWords.cleanBadWords(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const Divider(thickness: 2),
                // String Contains Phone Number
                Text(
                  '$stringContainsPhoneNumber contains phone number : ${stringContainsPhoneNumber.containsPhoneNumber() == true ? 'Yes' : 'No'}\n get all phone numbers:\n${stringContainsPhoneNumber.getPhoneNumbers().join('\n')}\n hide phone numbers: ${stringContainsPhoneNumber.hidePhoneNumbers(
                    obscuringCharacter: '\*',
                  )}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const Divider(thickness: 2),
                // String Contains Normal String
                Text(
                  '$normalString contains dart, flutter : ${normalString.containsWords([
                            'flutter',
                            'dart'
                          ]) == true ? 'Yes' : 'No'}, ${normalString.cleanWords(
                    ['flutter', 'dart'],
                  )}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const Divider(thickness: 2),
                // String Contains Hashtags
                Text(
                  '$stringContainsHashtags contains hashtags : ${stringContainsHashtags.containsHashtag() == true ? 'Yes' : 'No'}\n get all hashtags:\n${stringContainsHashtags.getHashtags().join('\n')}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const Divider(thickness: 2),
                // String Contains maintains
                Text(
                  '$stringContainsHashtags maintains hashtags : ${stringContainsHashtags.containsMention() == true ? 'Yes' : 'No'}\n get all maintains:\n${stringContainsHashtags.getMentions().join('\n')}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                ),
                const Divider(thickness: 2),
                Text(
                  '$stringContainsBadWords\n$stringContainsUrl\n$stringContainsMultipleUrls\n$stringContainsEmail\n$stringContainsPhoneNumber\n$normalString\n\n',
                ),
                const Divider(thickness: 2),
                CleanWidget(
                  isSelecatable: true,
                  source:
                      '$stringContainsBadWords\n$stringContainsUrl\n$stringContainsMultipleUrls\n$stringContainsEmail\n$stringContainsPhoneNumber\n$normalString\n\n',
                ),
                const Divider(thickness: 2),
                Text(
                  '$stringContainsBadWords\n$stringContainsUrl\n$stringContainsMultipleUrls\n$stringContainsEmail\n$stringContainsPhoneNumber\n$normalString\n$stringContainsHashtags',
                ),
                const Divider(thickness: 2),
                StringContainsWidget(
                  isSelecatable: true,
                  source:
                      '$stringContainsBadWords\n$stringContainsUrl\n$stringContainsMultipleUrls\n$stringContainsEmail\n$stringContainsPhoneNumber\n$normalString\n$stringContainsHashtags',
                  onTap: (element) {
                    debugPrint(
                        'element is a ${element.value} and type of ${element.type}');
                    if (element.type == StringContainsElementType.words) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${element.value} is awesome!!',
                          ),
                          duration: const Duration(seconds: 2),
                          dismissDirection: DismissDirection.horizontal,
                        ),
                      );
                    } else if (element.type ==
                        StringContainsElementType.hashtag) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${element.value} is a hashtag!!',
                          ),
                          duration: const Duration(seconds: 2),
                          dismissDirection: DismissDirection.horizontal,
                        ),
                      );
                    } else if (element.type ==
                        StringContainsElementType.mention) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${element.value} is a mention!!',
                          ),
                          duration: const Duration(seconds: 2),
                          dismissDirection: DismissDirection.horizontal,
                        ),
                      );
                    } else if (element.type ==
                        StringContainsElementType.email) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${element.value} is an email!!',
                          ),
                          duration: const Duration(seconds: 2),
                          dismissDirection: DismissDirection.horizontal,
                        ),
                      );
                    } else if (element.type == StringContainsElementType.url) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${element.value} is a url!!',
                          ),
                          duration: const Duration(seconds: 2),
                          dismissDirection: DismissDirection.horizontal,
                        ),
                      );
                    } else if (element.type ==
                        StringContainsElementType.phoneNumber) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            '${element.value} is a phone number!!',
                          ),
                          duration: const Duration(seconds: 2),
                          dismissDirection: DismissDirection.horizontal,
                        ),
                      );
                    }
                  },
                  highLightWords: const [
                    'Flutter',
                    'Dart',
                  ],
                  caseSensitive: false,
                  highlightWordsStyle: const TextStyle(
                    color: Colors.red,
                  ),
                  types: const <StringContainsElementType>[
                    StringContainsElementType.email,
                    StringContainsElementType.url,
                    StringContainsElementType.phoneNumber,
                    StringContainsElementType.hashtag,
                    StringContainsElementType.mention,
                    StringContainsElementType.words,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
