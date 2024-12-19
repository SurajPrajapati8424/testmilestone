import 'package:flutter/material.dart';
import 'package:choice/choice.dart';
import 'package:animated_checkmark/animated_checkmark.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:async/async.dart';

import '../widgets/text.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
    required this.label,
    required this.builder,
  });

  final String label;
  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: builder),
          );
        },
        child: Text(label),
      ),
    );
  }
}

class SamplePanel extends StatelessWidget {
  const SamplePanel({
    super.key,
    required this.title,
    required this.source,
    required this.child,
  });

  final String title;
  final String source;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(minHeight: 50),
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  tooltip: 'Code',
                  onPressed: () async {
                    const prefix =
                        'https://github.com/davigmacode/flutter_choice/blob/main/example/lib/';
                    final Uri url = Uri.parse(prefix + source);
                    print(url);
                  },
                  icon: const Icon(Icons.code),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(minHeight: 100),
            child: child,
          ),
        ],
      ),
    );
  }
}

class CustomChoiceItem extends StatelessWidget {
  final String label;
  final Color? color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final bool selected;
  final ValueChanged<bool> onSelect;

  const CustomChoiceItem({
    super.key,
    required this.label,
    this.color,
    this.width,
    this.height,
    this.margin,
    this.selected = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      width: width,
      height: height,
      margin: margin,
      duration: const Duration(milliseconds: 200),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: selected
            ? (color ?? Colors.green)
            : theme.unselectedWidgetColor.withOpacity(.12),
        borderRadius: BorderRadius.all(Radius.circular(selected ? 100 : 10)),
        border: Border.all(
          color: selected
              ? (color ?? Colors.green)
              : theme.colorScheme.onSurface.withOpacity(.38),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(selected ? 25 : 10)),
        onTap: () => onSelect(!selected),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: AnimatedCheckmark(
                active: selected,
                color: Colors.white,
                size: const Size.square(32),
                weight: 5,
                duration: const Duration(milliseconds: 200),
              ),
            ),
            Positioned(
              left: 9,
              right: 9,
              bottom: 10,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: selected ? Colors.white : theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceExample extends StatelessWidget {
  const ChoiceExample({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              MenuButton(
                  label: 'Inline',
                  builder: (t) {
                    return Container();
                  }),
              const SamplePanel(
                title: 'Wrapped List',
                source: 'inline/wrapped.dart',
                child: InlineWrapped(),
              ),
              const SamplePanel(
                title: 'Scrollable Horizontal',
                source: 'inline/scrollable_x.dart',
                child: InlineScrollableX(),
              ),
              const SamplePanel(
                title: 'Scrollable Vertical',
                source: 'inline/scrollable_y.dart',
                child: InlineScrollableY(),
              ),
              //
              const TextWidget(
                  text: "Prompted",
                  textAlign: TextAlign.center,
                  color: Colors.red),
              //
              const SamplePanel(
                title: 'Popup Dialog',
                source: 'prompt/popup_dialog.dart',
                child: PromptedPopupDialog(),
              ),
              const SamplePanel(
                title: 'Bottom Sheet',
                source: 'prompt/bottom_sheet.dart',
                child: PromptedBottomSheet(),
              ),
              const SamplePanel(
                title: 'New Page',
                source: 'prompt/new_page.dart',
                child: PromptedNewPage(),
              ),
              const SamplePanel(
                title: 'Modal Header, Footer, and Separator',
                source: 'prompt/modal_composition.dart',
                child: PromptedModal(),
              ),
              const SamplePanel(
                title: 'Confirmation',
                source: 'prompt/confirmation.dart',
                child: PromptedConfirmation(),
              ),
              const SamplePanel(
                title: 'Searchable and Highlighted Result',
                source: 'prompt/searchable.dart',
                child: PromptedSearchable(),
              ),
              const SamplePanel(
                title: 'Anchor/Trigger Widget',
                source: 'prompt/anchor.dart',
                child: PromptedAnchor(),
              ),
              //
              const TextWidget(
                  text: "Singal Inline",
                  textAlign: TextAlign.center,
                  color: Colors.red),
              //
              const SamplePanel(
                title: 'Inline Single Choice',
                source: 'single/inline.dart',
                child: SingleInline(),
              ),
              const SamplePanel(
                title: 'Prompted Single Choice',
                source: 'single/prompt.dart',
                child: SinglePrompted(),
              ),
              //
              const TextWidget(
                  text: "Multiple",
                  textAlign: TextAlign.center,
                  color: Colors.red),
              //
              const SamplePanel(
                title: 'Inline Multiple Choice',
                source: 'multiple/inline.dart',
                child: MultipleInline(),
              ),
              const SamplePanel(
                title: 'Prompted Multiple Choice',
                source: 'multiple/prompt.dart',
                child: MultiplePrompted(),
              ),
              //
              const TextWidget(
                  text: "Data Choice",
                  textAlign: TextAlign.center,
                  color: Colors.red),
              //
              const SamplePanel(
                title: 'String as Choice Value',
                source: 'data/string.dart',
                child: DataString(),
              ),
              const SamplePanel(
                title: 'Number as Choice Value',
                source: 'data/number.dart',
                child: DataNumber(),
              ),
              const SamplePanel(
                title: 'Object as Choice Value',
                source: 'data/object.dart',
                child: DataObject(),
              ),
              //
              const TextWidget(
                  text: "Future",
                  textAlign: TextAlign.center,
                  color: Colors.red),
              //
              const SamplePanel(
                title: 'Future Prompted Choice',
                source: 'future/prompt.dart',
                child: FuturePrompt(),
              ),
              const SamplePanel(
                title: 'Future Inline Choice',
                source: 'future/inline.dart',
                child: FutureInline(),
              ),
              //
              const TextWidget(
                  text: "Form and FormField",
                  textAlign: TextAlign.center,
                  color: Colors.red),
              //
              const SamplePanel(
                title: 'Inline Choice Form',
                source: 'form/inline.dart',
                child: FormInline(),
              ),
              const SamplePanel(
                title: 'Prompted Choice Form',
                source: 'form/prompt.dart',
                child: FormPrompt(),
              ),
              //
              const TextWidget(
                  text: "Choice Item",
                  textAlign: TextAlign.center,
                  color: Colors.red),
              //
              const SamplePanel(
                title: 'Chips Item',
                source: 'item/chip.dart',
                child: ItemChip(),
              ),
              const SamplePanel(
                title: 'Radios Item',
                source: 'item/radio.dart',
                child: ItemRadio(),
              ),
              const SamplePanel(
                title: 'Checkboxes Item',
                source: 'item/checkbox.dart',
                child: ItemCheckbox(),
              ),
              const SamplePanel(
                title: 'Switches Item',
                source: 'item/switch.dart',
                child: ItemSwitch(),
              ),
              const SamplePanel(
                title: 'Item Leading, Trailing, and Divider',
                source: 'item/composition.dart',
                child: ItemComposition(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InlineWrapped extends StatefulWidget {
  const InlineWrapped({super.key});

  @override
  State<InlineWrapped> createState() => _InlineWrappedState();
}

class _InlineWrappedState extends State<InlineWrapped> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> selectedValue = [];

  void setSelectedValue(List<String> value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>(
      multiple: true,
      clearable: true,
      value: selectedValue,
      onChanged: (val) {
        setSelectedValue(val);
        print('-> $val');
      },
      itemCount: choices.length,
      itemBuilder: (selection, i) {
        return ChoiceChip(
          selected: selection.selected(choices[i]),
          onSelected: selection.onSelected(choices[i]),
          label: Text(choices[i]),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}

class InlineScrollableX extends StatefulWidget {
  const InlineScrollableX({super.key});

  @override
  State<InlineScrollableX> createState() => _InlineScrollableXState();
}

class _InlineScrollableXState extends State<InlineScrollableX> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? selectedValue;

  void setSelectedValue(String? value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return Choice<String>.inline(
      clearable: true,
      value: ChoiceSingle.value(selectedValue),
      onChanged: ChoiceSingle.onChanged(setSelectedValue),
      itemCount: choices.length,
      itemBuilder: (state, i) {
        return ChoiceChip(
          selected: state.selected(choices[i]),
          onSelected: state.onSelected(choices[i]),
          label: Text(choices[i]),
        );
      },
      listBuilder: ChoiceList.createScrollable(
        spacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}

class InlineScrollableY extends StatefulWidget {
  const InlineScrollableY({super.key});

  @override
  State<InlineScrollableY> createState() => _InlineScrollableYState();
}

class _InlineScrollableYState extends State<InlineScrollableY> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? selectedValue;

  void setSelectedValue(String? value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Choice<String>.inline(
        clearable: true,
        value: ChoiceSingle.value(selectedValue),
        onChanged: ChoiceSingle.onChanged(setSelectedValue),
        itemCount: choices.length,
        itemBuilder: (state, i) {
          return CustomChoiceItem(
            label: choices[i],
            width: 100,
            height: 80,
            selected: state.selected(choices[i]),
            onSelect: state.onSelected(choices[i]),
          );
        },
        listBuilder: ChoiceList.createScrollable(
          direction: Axis.vertical,
          spacing: 10,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}

/// Prompt ///
class PromptedPopupDialog extends StatefulWidget {
  const PromptedPopupDialog({super.key});

  @override
  State<PromptedPopupDialog> createState() => _PromptedPopupDialogState();
}

class _PromptedPopupDialogState extends State<PromptedPopupDialog> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? singleSelected;

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: PromptedChoice<String>.single(
          title: 'Category',
          value: singleSelected,
          onChanged: setSingleSelected,
          itemCount: choices.length,
          itemBuilder: (state, i) {
            return Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              child: RadioListTile(
                value: choices[i],
                groupValue: state.single,
                onChanged: (value) {
                  state.select(choices[i]);
                },
                title: ChoiceText(
                  choices[i],
                  highlight: state.search?.value,
                ),
              ),
            );
          },
          promptDelegate: ChoicePrompt.delegatePopupDialog(
            maxHeightFactor: .5,
            constraints: const BoxConstraints(maxWidth: 300),
          ),
          anchorBuilder: ChoiceAnchor.create(inline: true),
        ),
      ),
    );
  }
}

// Singal
class SingleInline extends StatefulWidget {
  const SingleInline({super.key});

  @override
  State<SingleInline> createState() => _SingleInlineState();
}

class _SingleInlineState extends State<SingleInline> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? singleSelected;

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>.single(
      clearable: true,
      value: singleSelected,
      onChanged: setSingleSelected,
      itemCount: choices.length,
      itemBuilder: (selection, i) {
        return ChoiceChip(
          selected: selection.selected(choices[i]),
          onSelected: selection.onSelected(choices[i]),
          label: Text(choices[i]),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}

class SinglePrompted extends StatefulWidget {
  const SinglePrompted({super.key});

  @override
  State<SinglePrompted> createState() => _SinglePromptedState();
}

class _SinglePromptedState extends State<SinglePrompted> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? singleSelected;

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: PromptedChoice<String>.single(
          title: 'Category',
          value: singleSelected,
          onChanged: setSingleSelected,
          itemCount: choices.length,
          itemBuilder: (state, i) {
            return RadioListTile(
              value: choices[i],
              groupValue: state.single,
              onChanged: (value) {
                state.select(choices[i]);
              },
              title: ChoiceText(
                choices[i],
                highlight: state.search?.value,
              ),
            );
          },
          promptDelegate: ChoicePrompt.delegateBottomSheet(),
          anchorBuilder: ChoiceAnchor.create(inline: true),
        ),
      ),
    );
  }
}

class PromptedBottomSheet extends StatefulWidget {
  const PromptedBottomSheet({super.key});

  @override
  State<PromptedBottomSheet> createState() => _PromptedBottomSheetState();
}

class _PromptedBottomSheetState extends State<PromptedBottomSheet> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Choice<String>.prompt(
          title: 'Categories',
          multiple: true,
          value: multipleSelected,
          onChanged: setMultipleSelected,
          itemCount: choices.length,
          itemBuilder: (state, i) {
            return CheckboxListTile(
              value: state.selected(choices[i]),
              onChanged: state.onSelected(choices[i]),
              title: ChoiceText(
                choices[i],
                highlight: state.search?.value,
              ),
            );
          },
          modalHeaderBuilder: ChoiceModal.createHeader(
            automaticallyImplyLeading: false,
          ),
          promptDelegate: ChoicePrompt.delegateBottomSheet(),
        ),
      ),
    );
  }
}

class PromptedNewPage extends StatefulWidget {
  const PromptedNewPage({super.key});

  @override
  State<PromptedNewPage> createState() => _PromptedNewPageState();
}

class _PromptedNewPageState extends State<PromptedNewPage> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];
  String? singleSelected;
  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Choice<String>.prompt(
          title: 'Categories',
          multiple: true,
          confirmation: true,
          value: multipleSelected,
          onChanged: setMultipleSelected,
          itemCount: choices.length,
          itemBuilder: (state, i) {
            return CheckboxListTile(
              value: state.selected(choices[i]),
              onChanged: state.onSelected(choices[i]),
              title: ChoiceText(
                choices[i],
                highlight: state.search?.value,
              ),
            );
          },
          modalHeaderBuilder: ChoiceModal.createHeader(
            actionsBuilder: [
              ChoiceModal.createConfirmButton(),
              ChoiceModal.createSpacer(width: 20),
            ],
          ),
          promptDelegate: ChoicePrompt.delegateNewPage(),
        ),
      ),
    );
  }
}

class PromptedModal extends StatefulWidget {
  const PromptedModal({super.key});

  @override
  State<PromptedModal> createState() => _PromptedModalState();
}

class _PromptedModalState extends State<PromptedModal> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Choice<String>.prompt(
          title: 'Categories',
          multiple: true,
          confirmation: true,
          clearable: true,
          value: multipleSelected,
          onChanged: setMultipleSelected,
          itemCount: choices.length,
          itemBuilder: (state, i) {
            return CheckboxListTile(
              value: state.selected(choices[i]),
              onChanged: state.onSelected(choices[i]),
              title: ChoiceText(
                choices[i],
                highlight: state.search?.value,
              ),
            );
          },
          modalHeaderBuilder: ChoiceModal.createHeader(
            automaticallyImplyLeading: false,
            actionsBuilder: [
              ChoiceModal.createConfirmButton(),
              ChoiceModal.createSpacer(width: 20),
            ],
          ),
          modalSeparatorBuilder: ChoiceModal.createSeparator(),
          modalFooterBuilder: (state) {
            return CheckboxListTile(
              value: state.selectedMany(choices),
              onChanged: state.onSelectedMany(choices),
              tristate: true,
              title: const Text('Select All'),
            );
          },
          listBuilder: ChoiceList.createGrid(childAspectRatio: 1 / .25),
          promptDelegate: ChoicePrompt.delegateBottomSheet(),
          anchorBuilder: ChoiceAnchor.create(),
        ),
      ),
    );
  }
}

class PromptedConfirmation extends StatefulWidget {
  const PromptedConfirmation({super.key});

  @override
  State<PromptedConfirmation> createState() => _PromptedConfirmationState();
}

class _PromptedConfirmationState extends State<PromptedConfirmation> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? singleSelected;

  List<String> multipleSelected = [];

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.single(
                title: 'Category',
                confirmation: true,
                value: singleSelected,
                onChanged: setSingleSelected,
                itemCount: choices.length,
                itemBuilder: (state, i) {
                  return RadioListTile(
                    value: choices[i],
                    groupValue: state.single,
                    onChanged: (value) {
                      state.select(choices[i]);
                    },
                    title: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                modalFooterBuilder: ChoiceModalFooter.create(
                  mainAxisAlignment: MainAxisAlignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 7.0,
                  ),
                  children: [
                    (state) {
                      return TextButton(
                        onPressed: () => state.closeModal(confirmed: false),
                        child: const Text('Cancel'),
                      );
                    },
                    (state) {
                      return TextButton(
                        onPressed: () => state.closeModal(confirmed: true),
                        child: const Text('Submit'),
                      );
                    },
                  ],
                ),
                promptDelegate: ChoicePrompt.delegatePopupDialog(
                  maxHeightFactor: .5,
                  constraints: const BoxConstraints(maxWidth: 300),
                ),
                anchorBuilder: ChoiceAnchor.create(inline: true),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.multiple(
                title: 'Category',
                clearable: true,
                confirmation: true,
                value: multipleSelected,
                onChanged: setMultipleSelected,
                itemCount: choices.length,
                itemBuilder: (state, i) {
                  return ChoiceChip(
                    selected: state.selected(choices[i]),
                    onSelected: state.onSelected(choices[i]),
                    label: Text(choices[i]),
                  );
                },
                listBuilder: ChoiceList.createWrapped(
                  padding: const EdgeInsets.all(20),
                  spacing: 10,
                  runSpacing: 10,
                ),
                modalHeaderBuilder: ChoiceModal.createHeader(
                  automaticallyImplyLeading: false,
                  actionsBuilder: [
                    ChoiceModal.createConfirmButton(),
                    ChoiceModal.createSpacer(width: 10),
                  ],
                ),
                promptDelegate: ChoicePrompt.delegatePopupDialog(
                  constraints: const BoxConstraints(maxWidth: 400),
                ),
                anchorBuilder: ChoiceAnchor.create(valueTruncate: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromptedSearchable extends StatefulWidget {
  const PromptedSearchable({super.key});

  @override
  State<PromptedSearchable> createState() => _PromptedSearchableState();
}

class _PromptedSearchableState extends State<PromptedSearchable> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? singleSelected;

  List<String> multipleSelected = [];

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.single(
                title: 'Category',
                searchable: true,
                confirmation: true,
                value: singleSelected,
                onChanged: setSingleSelected,
                itemCount: choices.length,
                itemSkip: (state, i) =>
                    !ChoiceSearch.match(choices[i], state.search?.value),
                itemBuilder: (state, i) {
                  return RadioListTile(
                    value: choices[i],
                    groupValue: state.single,
                    onChanged: (value) {
                      state.select(choices[i]);
                    },
                    title: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                modalHeaderBuilder: ChoiceModal.createHeader(
                  automaticallyImplyLeading: false,
                  actionsBuilder: [
                    ChoiceModal.createSpacer(width: 5),
                  ],
                ),
                modalFooterBuilder: ChoiceModal.createFooter(
                  mainAxisAlignment: MainAxisAlignment.center,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 7.0,
                  ),
                  children: [
                    (state) {
                      return TextButton(
                        onPressed: () => state.closeModal(confirmed: false),
                        child: const Text('Cancel'),
                      );
                    },
                    (state) {
                      return TextButton(
                        onPressed: () => state.closeModal(confirmed: true),
                        child: const Text('Submit'),
                      );
                    },
                  ],
                ),
                promptDelegate: ChoicePrompt.delegatePopupDialog(
                  maxHeightFactor: .7,
                  constraints: const BoxConstraints(maxWidth: 300),
                ),
                anchorBuilder: ChoiceAnchor.create(inline: true),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.multiple(
                title: 'Category',
                clearable: true,
                confirmation: true,
                searchable: true,
                value: multipleSelected,
                onChanged: setMultipleSelected,
                itemCount: choices.length,
                itemSkip: (state, i) =>
                    !ChoiceSearch.match(choices[i], state.search?.value),
                itemBuilder: (state, i) {
                  return ChoiceChip(
                    selected: state.selected(choices[i]),
                    onSelected: state.onSelected(choices[i]),
                    label: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                listBuilder: ChoiceList.createWrapped(
                  padding: const EdgeInsets.all(20),
                  spacing: 10,
                  runSpacing: 10,
                ),
                modalHeaderBuilder: ChoiceModal.createHeader(
                  automaticallyImplyLeading: false,
                  actionsBuilder: [
                    ChoiceModal.createConfirmButton(),
                    ChoiceModal.createSpacer(width: 10),
                  ],
                ),
                promptDelegate: ChoicePrompt.delegatePopupDialog(
                  constraints: const BoxConstraints(maxWidth: 400),
                ),
                anchorBuilder: ChoiceAnchor.create(valueTruncate: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromptedAnchor extends StatefulWidget {
  const PromptedAnchor({super.key});

  @override
  State<PromptedAnchor> createState() => _PromptedAnchorState();
}

class _PromptedAnchorState extends State<PromptedAnchor> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? singleSelected;

  List<String> multipleSelected = [];

  void setSingleSelected(String? value) {
    setState(() => singleSelected = value);
  }

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25),
      child: Column(
        children: [
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.single(
                title: 'Category',
                value: singleSelected,
                onChanged: setSingleSelected,
                itemCount: choices.length,
                itemBuilder: (state, i) {
                  return RadioListTile(
                    value: choices[i],
                    groupValue: state.single,
                    onChanged: (value) {
                      state.select(choices[i]);
                    },
                    title: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                anchorBuilder: ChoiceAnchor.create(inline: true),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.multiple(
                title: 'Category',
                clearable: true,
                value: multipleSelected,
                onChanged: setMultipleSelected,
                itemCount: choices.length,
                itemBuilder: (state, i) {
                  return CheckboxListTile(
                    value: state.selected(choices[i]),
                    onChanged: state.onSelected(choices[i]),
                    title: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                anchorBuilder: ChoiceAnchor.create(
                  valueTruncate: 1,
                  placeholder: 'Choose one or more',
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 300,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: PromptedChoice<String>.multiple(
                title: 'Category',
                clearable: true,
                value: multipleSelected,
                onChanged: setMultipleSelected,
                itemCount: choices.length,
                itemBuilder: (state, i) {
                  return CheckboxListTile(
                    value: state.selected(choices[i]),
                    onChanged: state.onSelected(choices[i]),
                    title: ChoiceText(
                      choices[i],
                      highlight: state.search?.value,
                    ),
                  );
                },
                anchorBuilder: ChoiceAnchor.createUntitled(
                  valueTruncate: 2,
                  trailing: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          PromptedChoice<String>.multiple(
            title: 'Category',
            clearable: true,
            value: multipleSelected,
            onChanged: setMultipleSelected,
            itemCount: choices.length,
            itemBuilder: (state, i) {
              return CheckboxListTile(
                value: state.selected(choices[i]),
                onChanged: state.onSelected(choices[i]),
                title: ChoiceText(
                  choices[i],
                  highlight: state.search?.value,
                ),
              );
            },
            anchorBuilder: (state, openModal) {
              return ListTileTheme(
                data: const ListTileThemeData(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: 10,
                  ),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  titleTextStyle: TextStyle(
                    color: Colors.blue,
                  ),
                  subtitleTextStyle: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.lightBlue,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ChoiceAnchor.create(
                    valueTruncate: 2,
                    trailing: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    ),
                  )(state, openModal),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Multiple
class MultipleInline extends StatefulWidget {
  const MultipleInline({super.key});

  @override
  State<MultipleInline> createState() => _MultipleInlineState();
}

class _MultipleInlineState extends State<MultipleInline> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];
  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>(
      multiple: true,
      clearable: true,
      value: multipleSelected,
      onChanged: setMultipleSelected,
      itemCount: choices.length,
      itemBuilder: (selection, i) {
        return ChoiceChip(
          selected: selection.selected(choices[i]),
          onSelected: selection.onSelected(choices[i]),
          label: Text(choices[i]),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}

class MultiplePrompted extends StatefulWidget {
  const MultiplePrompted({super.key});

  @override
  State<MultiplePrompted> createState() => _MultiplePromptedState();
}

class _MultiplePromptedState extends State<MultiplePrompted> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: .7,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 20),
        child: Choice<String>.prompt(
          title: 'Categories',
          multiple: true,
          confirmation: true,
          value: multipleSelected,
          onChanged: setMultipleSelected,
          itemCount: choices.length,
          itemSkip: (state, i) =>
              !ChoiceSearch.match(choices[i], state.search?.value),
          itemBuilder: (state, i) {
            return CheckboxListTile(
              value: state.selected(choices[i]),
              onChanged: state.onSelected(choices[i]),
              title: ChoiceText(
                choices[i],
                highlight: state.search?.value,
              ),
            );
          },
          modalHeaderBuilder: ChoiceModal.createHeader(
            automaticallyImplyLeading: false,
            actionsBuilder: [
              ChoiceModal.createConfirmButton(),
              ChoiceModal.createSpacer(width: 10),
            ],
          ),
          modalFooterBuilder: (state) {
            return CheckboxListTile(
              value: state.selectedMany(choices),
              onChanged: state.onSelectedMany(choices),
              tristate: true,
              title: const Text('Select All'),
            );
          },
          promptDelegate: ChoicePrompt.delegateBottomSheet(),
        ),
      ),
    );
  }
}

// Data
class DataString extends StatefulWidget {
  const DataString({super.key});

  @override
  State<DataString> createState() => _DataStringState();
}

class _DataStringState extends State<DataString> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? selectedValue;

  void setSelectedValue(String? value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>.single(
      clearable: true,
      value: selectedValue,
      onChanged: setSelectedValue,
      itemCount: choices.length,
      itemBuilder: (state, i) {
        return ChoiceChip(
          selected: state.selected(choices[i]),
          onSelected: state.onSelected(choices[i]),
          label: Text(choices[i]),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}

class DataNumber extends StatefulWidget {
  const DataNumber({super.key});

  @override
  State<DataNumber> createState() => _DataNumberState();
}

class _DataNumberState extends State<DataNumber> {
  List<int> choices = Iterable<int>.generate(10).toList();
  int? selectedValue;

  void setSelectedValue(int? value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<int>.single(
      clearable: true,
      value: selectedValue,
      onChanged: setSelectedValue,
      itemCount: choices.length,
      itemBuilder: (state, i) {
        return ChoiceChip(
          selected: state.selected(choices[i]),
          onSelected: state.onSelected(choices[i]),
          label: Text(choices[i].toString()),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}

class DataObject extends StatefulWidget {
  const DataObject({super.key});

  @override
  State<DataObject> createState() => _DataObjectState();
}

class _DataObjectState extends State<DataObject> {
  List<ChoiceData<String>> choicesValue = [];
  final choicesMemoizer = AsyncMemoizer<List<ChoiceData<String>>>();

  void setChoicesValue(List<ChoiceData<String>> value) {
    setState(() => choicesValue = value);
  }

  Future<List<ChoiceData<String>>> getChoices() async {
    try {
      const url =
          "https://randomuser.me/api/?inc=name,picture,email&results=25";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['results'] as List;
        return Future.value(data.asChoiceData(
          value: (i, e) => e['email'],
          title: (i, e) => e['name']['first'] + ' ' + e['name']['last'],
          subtitle: (i, e) => e['email'],
          image: (i, e) => e['picture']['thumbnail'],
        ));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChoiceData<String>>>(
      initialData: const [],
      future: choicesMemoizer.runOnce(getChoices),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            padding: const EdgeInsets.all(25),
            constraints: const BoxConstraints(maxHeight: 200),
            child: Text(
              snapshot.error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        return SizedBox(
          width: 300,
          child: Card(
            child: PromptedChoice<ChoiceData<String>>.multiple(
              title: 'Users',
              clearable: true,
              loading: snapshot.connectionState == ConnectionState.waiting,
              value: choicesValue,
              onChanged: setChoicesValue,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (state, i) {
                final choice = snapshot.data?.elementAt(i);
                return CheckboxListTile(
                  value: state.selected(choice!),
                  onChanged: state.onSelected(choice),
                  title: Text(choice.title),
                  subtitle: choice.subtitle != null
                      ? Text(
                          choice.subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  secondary: choice.image != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(choice.image!),
                        )
                      : null,
                );
              },
              modalHeaderBuilder: ChoiceModal.createHeader(
                title: const Text('Select Users'),
                actionsBuilder: [
                  (state) {
                    final values = snapshot.data!;
                    return Checkbox(
                      value: state.selectedMany(values),
                      onChanged: state.onSelectedMany(values),
                      tristate: true,
                    );
                  },
                  ChoiceModal.createSpacer(width: 25),
                ],
              ),
              promptDelegate: ChoicePrompt.delegateBottomSheet(),
              anchorBuilder: ChoiceAnchor.create(valueTruncate: 1),
            ),
          ),
        );
      },
    );
  }
}

// Future
class FuturePrompt extends StatefulWidget {
  const FuturePrompt({super.key});

  @override
  State<FuturePrompt> createState() => _FuturePromptState();
}

class _FuturePromptState extends State<FuturePrompt> {
  List<ChoiceData<String>> choicesValue = [];
  final choicesMemoizer = AsyncMemoizer<List<ChoiceData<String>>>();

  void setChoicesValue(List<ChoiceData<String>> value) {
    setState(() => choicesValue = value);
  }

  Future<List<ChoiceData<String>>> getChoices() async {
    try {
      const url =
          "https://randomuser.me/api/?inc=name,picture,email&results=25";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['results'] as List;
        return Future.value(data.asChoiceData(
          value: (i, e) => e['email'],
          title: (i, e) => e['name']['first'] + ' ' + e['name']['last'],
          image: (i, e) => e['picture']['thumbnail'],
        ));
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ChoiceData<String>>>(
      initialData: const [],
      future: choicesMemoizer.runOnce(getChoices),
      builder: (context, snapshot) {
        return SizedBox(
          width: 300,
          child: Card(
            child: PromptedChoice<ChoiceData<String>>.multiple(
              title: 'Users',
              clearable: true,
              error: snapshot.hasError,
              errorBuilder: ChoiceListError.create(
                message: snapshot.error.toString(),
              ),
              loading: snapshot.connectionState == ConnectionState.waiting,
              value: choicesValue,
              onChanged: setChoicesValue,
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (state, i) {
                final choice = snapshot.data?.elementAt(i);
                return CheckboxListTile(
                  value: state.selected(choice!),
                  onChanged: state.onSelected(choice),
                  title: Text(choice.title),
                  subtitle: choice.subtitle != null
                      ? Text(
                          choice.subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  secondary: choice.image != null
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(choice.image!),
                        )
                      : null,
                );
              },
              modalHeaderBuilder: ChoiceModal.createHeader(
                title: const Text('Select Users'),
                actionsBuilder: [
                  (state) {
                    final values = snapshot.data!;
                    return Checkbox(
                      value: state.selectedMany(values),
                      onChanged: state.onSelectedMany(values),
                      tristate: true,
                    );
                  },
                  ChoiceModal.createSpacer(width: 25),
                ],
              ),
              promptDelegate: ChoicePrompt.delegateBottomSheet(),
              anchorBuilder: ChoiceAnchor.create(valueTruncate: 1),
            ),
          ),
        );
      },
    );
  }
}

class FutureInline extends StatefulWidget {
  const FutureInline({super.key});

  @override
  State<FutureInline> createState() => _FutureInlineState();
}

class _FutureInlineState extends State<FutureInline> {
  List<String> choicesValue = [];
  final choicesMemoizer = AsyncMemoizer<List<dynamic>>();

  void setChoicesValue(List<String> value) {
    setState(() => choicesValue = value);
  }

  Future<List<dynamic>> getChoices() async {
    try {
      const url = "https://randomuser.me/api/?inc=name,picture,email&results=5";
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body)['results'] as List;
      return Future.value(data);
    } catch (e) {
      throw ErrorDescription(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      initialData: const [],
      future: choicesMemoizer.runOnce(getChoices),
      builder: (context, snapshot) {
        final choices = snapshot.data ?? [];
        return InlineChoice<String>(
          clearable: true,
          loading: snapshot.connectionState == ConnectionState.waiting,
          value: choicesValue,
          onChanged: setChoicesValue,
          itemCount: choices.length,
          itemBuilder: (selection, i) {
            final choice = choices.elementAt(i);
            final value = choice['email'];
            final label =
                choice['name']['first'] + ' ' + choice['name']['last'];
            final avatar = choice['picture']['thumbnail'];
            return ChoiceChip(
              selected: selection.selected(value),
              onSelected: selection.onSelected(value),
              checkmarkColor: Colors.white,
              avatar: CircleAvatar(
                backgroundImage: NetworkImage(avatar),
              ),
              label: Text(label),
            );
          },
          listBuilder: ChoiceList.createScrollable(
            spacing: 10,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),
          ),
        );
      },
    );
  }
}

// Form
class FormInline extends StatefulWidget {
  const FormInline({super.key});

  @override
  State<FormInline> createState() => _FormInlineState();
}

class _FormInlineState extends State<FormInline> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();

  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> selectedValue = [];

  void setSelectedValue(List<String>? value) {
    setState(() => selectedValue = value ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormField<List<String>>(
            autovalidateMode: AutovalidateMode.always,
            initialValue: selectedValue,
            onSaved: setSelectedValue,
            validator: (value) {
              if (value?.isEmpty ?? value == null) {
                return 'Please select some categories';
              }
              if (value!.length > 5) {
                return "Can't select more than 5 categories";
              }
              return null;
            },
            builder: (formState) {
              return Column(
                children: [
                  InlineChoice<String>(
                    multiple: true,
                    clearable: true,
                    value: formState.value ?? [],
                    onChanged: (val) => formState.didChange(val),
                    itemCount: choices.length,
                    itemBuilder: (selection, i) {
                      return ChoiceChip(
                        selected: selection.selected(choices[i]),
                        onSelected: selection.onSelected(choices[i]),
                        label: Text(choices[i]),
                      );
                    },
                    listBuilder: ChoiceList.createWrapped(
                      spacing: 10,
                      runSpacing: 10,
                      padding: const EdgeInsets.fromLTRB(20, 25, 20, 10),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      formState.errorText ??
                          '${formState.value!.length}/5 selected',
                      style: TextStyle(
                        color: formState.hasError
                            ? Colors.redAccent
                            : Colors.green,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Submitted Value:'),
                      const SizedBox(height: 5),
                      Text(selectedValue.toString())
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (formKey.currentState!.validate()) {
                      // If the form is valid, save the value.
                      formKey.currentState!.save();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FormPrompt extends StatefulWidget {
  const FormPrompt({super.key});

  @override
  State<FormPrompt> createState() => _FormPromptState();
}

class _FormPromptState extends State<FormPrompt> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final formKey = GlobalKey<FormState>();

  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  String? selectedValue;

  void setSelectedValue(String? value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormField<String>(
            autovalidateMode: AutovalidateMode.always,
            initialValue: selectedValue,
            onSaved: setSelectedValue,
            validator: (value) {
              if (value?.isEmpty ?? value == null) {
                return 'Please select a category';
              }
              return null;
            },
            builder: (formState) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 5),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: PromptedChoice<String>.single(
                        title: 'Category',
                        value: formState.value,
                        onChanged: (val) => formState.didChange(val),
                        itemCount: choices.length,
                        itemBuilder: (state, i) {
                          return RadioListTile(
                            value: choices[i],
                            groupValue: state.single,
                            onChanged: (value) {
                              state.select(choices[i]);
                            },
                            title: ChoiceText(
                              choices[i],
                              highlight: state.search?.value,
                            ),
                          );
                        },
                        promptDelegate: ChoicePrompt.delegatePopupDialog(
                          maxHeightFactor: .5,
                          constraints: const BoxConstraints(maxWidth: 300),
                        ),
                        anchorBuilder: ChoiceAnchor.create(
                          inline: true,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      formState.errorText ?? '${formState.value} selected',
                      style: TextStyle(
                        color: formState.hasError
                            ? Colors.redAccent
                            : Colors.green,
                      ),
                    ),
                  )
                ],
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Submitted Value:'),
                      const SizedBox(height: 5),
                      Text(selectedValue.toString())
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (formKey.currentState!.validate()) {
                      // If the form is valid, save the value.
                      formKey.currentState!.save();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Choice Item

class ItemChip extends StatefulWidget {
  const ItemChip({super.key});

  @override
  State<ItemChip> createState() => _ItemChipState();
}

class _ItemChipState extends State<ItemChip> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>(
      multiple: true,
      clearable: true,
      value: multipleSelected,
      onChanged: setMultipleSelected,
      itemCount: choices.length,
      itemBuilder: (state, i) {
        return ChoiceChip(
          selected: state.selected(choices[i]),
          onSelected: state.onSelected(choices[i]),
          label: Text(choices[i]),
        );
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}

class ItemRadio extends StatefulWidget {
  const ItemRadio({super.key});

  @override
  State<ItemRadio> createState() => _ItemRadioState();
}

class _ItemRadioState extends State<ItemRadio> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InlineChoice<String>(
        value: multipleSelected,
        onChanged: setMultipleSelected,
        itemCount: choices.length,
        itemBuilder: (state, i) {
          return RadioListTile(
            value: choices[i],
            groupValue: state.single,
            onChanged: (value) {
              state.select(choices[i]);
            },
            title: Text(choices[i]),
          );
        },
        listBuilder: ChoiceList.createVirtualized(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}

class ItemCheckbox extends StatefulWidget {
  const ItemCheckbox({super.key});

  @override
  State<ItemCheckbox> createState() => _ItemCheckboxState();
}

class _ItemCheckboxState extends State<ItemCheckbox> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> selectedValue = [];

  void setSelectedValue(List<String> value) {
    setState(() => selectedValue = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InlineChoice<String>(
        value: selectedValue,
        onChanged: setSelectedValue,
        itemCount: choices.length,
        itemBuilder: (state, i) {
          return CheckboxListTile(
            value: state.selected(choices[i]),
            onChanged: state.onSelected(choices[i]),
            title: Text(choices[i]),
          );
        },
        listBuilder: ChoiceList.createVirtualized(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}

class ItemSwitch extends StatefulWidget {
  const ItemSwitch({super.key});

  @override
  State<ItemSwitch> createState() => _ItemSwitchState();
}

class _ItemSwitchState extends State<ItemSwitch> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: InlineChoice<String>(
        multiple: true,
        clearable: true,
        value: multipleSelected,
        onChanged: setMultipleSelected,
        itemCount: choices.length,
        itemBuilder: (state, i) {
          return SwitchListTile(
            value: state.selected(choices[i]),
            onChanged: state.onSelected(choices[i]),
            title: Text(choices[i]),
          );
        },
        listBuilder: ChoiceList.createVirtualized(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 25,
          ),
        ),
      ),
    );
  }
}

class ItemComposition extends StatefulWidget {
  const ItemComposition({super.key});

  @override
  State<ItemComposition> createState() => _ItemCompositionState();
}

class _ItemCompositionState extends State<ItemComposition> {
  List<String> choices = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
    'Arts'
  ];

  List<String> multipleSelected = [];

  void setMultipleSelected(List<String> value) {
    setState(() => multipleSelected = value);
  }

  @override
  Widget build(BuildContext context) {
    return InlineChoice<String>(
      multiple: true,
      clearable: true,
      value: multipleSelected,
      onChanged: setMultipleSelected,
      itemCount: choices.length,
      itemBuilder: (state, i) {
        return ChoiceChip(
          selected: state.selected(choices[i]),
          onSelected: state.onSelected(choices[i]),
          label: Text(choices[i]),
        );
      },
      leadingBuilder: (state) {
        return ChoiceChip(
          selected: state.selectedMany(choices) ?? false,
          onSelected: state.onSelectedMany(choices),
          label: const Text('All'),
        );
      },
      trailingBuilder: (state) {
        return IconButton(
          tooltip: 'Add Choice',
          icon: const Icon(Icons.add_circle_outline),
          onPressed: () => setState(
            () => choices.add('Opt #${choices.length + 1}'),
          ),
        );
      },
      dividerBuilder: (state) {
        return const Text('-');
      },
      listBuilder: ChoiceList.createWrapped(
        spacing: 10,
        runSpacing: 10,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
      ),
    );
  }
}
