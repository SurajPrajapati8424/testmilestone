import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class DropdownExample extends StatefulWidget {
  const DropdownExample({super.key});

  @override
  State<DropdownExample> createState() => _DropdownExampleState();
}

class _DropdownExampleState extends State<DropdownExample> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            'Custom Dropdown Example',
            style: TextStyle(color: Colors.white),
          ),
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontSize: 18),
            unselectedLabelStyle: TextStyle(fontSize: 18),
            padding: EdgeInsets.all(2),
            tabs: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Single selection',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text('Multi selection'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const SimpleDropdown(),
                const SizedBox(height: 16),
                const SearchDropdown(),
                const SizedBox(height: 16),
                const SearchRequestDropdown(),
                const SizedBox(height: 16),
                const DecoratedDropdown(),
                const SizedBox(height: 16),
                ValidationDropdown(),
                const SizedBox(height: 16),
                const ControllerValidationDropdown(),
              ],
            ),
            ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const MultiSelectDropdown(),
                const SizedBox(height: 16),
                const MultiSelectSearchDropdown(),
                const SizedBox(height: 16),
                const MultiSelectSearchRequestDropdown(),
                const SizedBox(height: 16),
                const MultiSelectDecoratedDropdown(),
                const SizedBox(height: 16),
                MultiSelectValidationDropdown(),
                const SizedBox(height: 16),
                const MultiSelectControllerDropdown()
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//// SimpleDropdown ////
class SimpleDropdown extends StatelessWidget {
  const SimpleDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> list = [
      'Developer',
      'Designer',
      'Consultant',
      'Student',
    ];
    return CustomDropdown<String>(
      hintText: 'Select job role',
      items: list,
      initialItem: list[0],
      excludeSelected: false,
      onChanged: (value) {
        debugPrint('SimpleDropdown onChanged value: $value');
      },
    );
  }
}

//// SearchDropdown ////
final list = [
  'Pakistani',
  'Indian',
  'Middle Eastern',
  'Western',
  'Chinese',
  'Italian',
];

class SearchDropdown extends StatefulWidget {
  const SearchDropdown({super.key});

  @override
  State<SearchDropdown> createState() => _SearchDropdownState();
}

class _SearchDropdownState extends State<SearchDropdown> {
  String? selectedItem = list[2];

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>.search(
      hintText: 'Select cuisines',
      items: list,
      initialItem: selectedItem,
      overlayHeight: 342,
      onChanged: (value) {
        debugPrint('SearchDropdown onChanged value: $value');
        setState(() {
          selectedItem = value;
        });
      },
    );
  }
}

class MultiSelectSearchDropdown extends StatelessWidget {
  const MultiSelectSearchDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>.multiSelectSearch(
      hintText: 'Select cuisines',
      items: list,
      onListChanged: (value) {
        debugPrint('MultiSelectSearchDropdown onChanged value: $value');
      },
    );
  }
}

//// SearchRequestDropdown ////
const List<Job> jobItems = [
  Job('Developer', Icons.developer_mode),
  Job('Designer', Icons.design_services),
  Job('Consultant', Icons.account_balance),
  Job('Student', Icons.school),
];

class Job with CustomDropdownListFilter {
  final String name;
  final IconData icon;

  const Job(this.name, this.icon);

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}

Future<List<Job>> getFakeRequestData(String query) async {
  return await Future.delayed(const Duration(seconds: 1), () {
    return jobItems.where((e) {
      return e.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  });
}

class SearchRequestDropdown extends StatelessWidget {
  const SearchRequestDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Job>.searchRequest(
      futureRequest: getFakeRequestData,
      hintText: 'Search job role',
      onChanged: (value) {
        debugPrint('SearchRequestDropdown onChanged value: $value');
      },
      searchRequestLoadingIndicator: const Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class MultiSelectSearchRequestDropdown extends StatelessWidget {
  const MultiSelectSearchRequestDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Job>.multiSelectSearchRequest(
      futureRequest: getFakeRequestData,
      hintText: 'Search job role',
      onListChanged: (value) {
        debugPrint('MultiSelectSearchDropdown onChanged value: $value');
      },
    );
  }
}

//// DecoratedDropdown ////
class DecoratedDropdown extends StatelessWidget {
  const DecoratedDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Job>.search(
      items: jobItems,
      initialItem: jobItems[2],
      hintText: 'Select job role',
      searchHintText: 'Search job role',
      excludeSelected: false,
      hideSelectedFieldWhenExpanded: true,
      closedHeaderPadding: const EdgeInsets.all(20),
      onChanged: (value) {
        debugPrint('DecoratedDropdown onChanged value: $value');
      },
      headerBuilder: (context, selectedItem, enabled) {
        return Text(
          selectedItem.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        );
      },
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Text(
          item.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 16),
        );
      },
      noResultFoundBuilder: (context, text) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      },
      decoration: CustomDropdownDecoration(
        closedFillColor: Colors.black,
        expandedFillColor: Colors.black,
        closedSuffixIcon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.white,
        ),
        expandedSuffixIcon: const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.grey,
        ),
        closedShadow: [
          const BoxShadow(
            offset: Offset(0, 4),
            color: Colors.blue,
            blurRadius: 8,
          ),
        ],
        searchFieldDecoration: SearchFieldDecoration(
          fillColor: Colors.grey[700],
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          hintStyle: TextStyle(color: Colors.grey[400]),
          textStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          suffixIcon: (onClear) {
            return GestureDetector(
              onTap: onClear,
              child: Icon(Icons.close, color: Colors.grey[400]),
            );
          },
        ),
        listItemDecoration: ListItemDecoration(
          selectedColor: Colors.grey[900],
          highlightColor: Colors.grey[800],
        ),
      ),
    );
  }
}

class MultiSelectDecoratedDropdown extends StatelessWidget {
  const MultiSelectDecoratedDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Job>.multiSelectSearch(
      items: jobItems,
      hintText: 'Select job role',
      searchHintText: 'Search job role',
      closedHeaderPadding: const EdgeInsets.all(20),
      onListChanged: (value) {
        debugPrint('MultiSelectDecoratedDropdown onChanged value: $value');
      },
      maxlines: 2,
      listItemBuilder: (context, item, isSelected, onItemSelect) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            CupertinoCheckbox(
              value: isSelected,
              onChanged: (_) => onItemSelect(),
            ),
          ],
        );
      },
      decoration: CustomDropdownDecoration(
        closedFillColor: Colors.black,
        expandedFillColor: Colors.black,
        hintStyle: TextStyle(
          color: Colors.yellow[200],
          fontSize: 16,
        ),
        headerStyle: const TextStyle(
          color: Colors.yellow,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        noResultFoundStyle: const TextStyle(
          color: Colors.yellow,
          fontSize: 16,
        ),
        prefixIcon: const Icon(Icons.person, color: Colors.yellow),
        closedSuffixIcon: const Icon(
          Icons.keyboard_arrow_down,
          color: Colors.yellow,
        ),
        expandedSuffixIcon: const Icon(
          Icons.keyboard_arrow_up,
          color: Colors.yellow,
        ),
        closedShadow: [
          const BoxShadow(
            offset: Offset(0, 4),
            color: Colors.blue,
            blurRadius: 8,
          ),
        ],
        searchFieldDecoration: SearchFieldDecoration(
          fillColor: Colors.grey[700],
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          hintStyle: TextStyle(color: Colors.grey[400]),
          textStyle: const TextStyle(color: Colors.white),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          suffixIcon: (onClear) {
            return GestureDetector(
              onTap: onClear,
              child: Icon(Icons.close, color: Colors.grey[400]),
            );
          },
        ),
        listItemDecoration: ListItemDecoration(
          selectedColor: Colors.grey[900],
          highlightColor: Colors.grey[800],
        ),
      ),
    );
  }
}

//// ValidationDropdown ////
class ValidationDropdown extends StatelessWidget {
  ValidationDropdown({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown<Job>(
            hintText: 'Select job role',
            items: jobItems,
            excludeSelected: false,
            onChanged: (value) {
              debugPrint('ValidationDropdown onChanged value: $value');
            },
            validator: (value) {
              if (value == null) {
                return "Must not be null";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiSelectValidationDropdown extends StatelessWidget {
  MultiSelectValidationDropdown({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown<Job>.multiSelect(
            hintText: 'Select job role',
            items: jobItems,
            onListChanged: (value) {
              debugPrint(
                  'MultiSelectValidationDropdown onChanged value: $value');
            },
            listValidator: (value) {
              if (value.isEmpty) {
                return "Must not be null";
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//// ControllerValidationDropdown ////
class ControllerValidationDropdown extends StatefulWidget {
  const ControllerValidationDropdown({super.key});

  @override
  State<ControllerValidationDropdown> createState() =>
      ControllerValidationDropdownState();
}

class ControllerValidationDropdownState
    extends State<ControllerValidationDropdown> {
  final formKey = GlobalKey<FormState>();
  final controller = SingleSelectController<Job>(jobItems[0]);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomDropdown<Job>(
            controller: controller,
            hintText: 'Select job role',
            items: jobItems,
            onChanged: (value) {
              debugPrint(
                  'ControllerValidationDropdown onChanged value: $value');
            },
            validator: (value) {
              if (value == null) {
                return "Must not be null";
              }
              return null;
            },
            decoration: CustomDropdownDecoration(
              closedSuffixIcon: InkWell(
                onTap: () {
                  debugPrint('Clearing ControllerValidationDropdown');
                  controller.clear();
                },
                child: const Icon(Icons.close),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }
              },
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/////////////////////////////////////

/// MultiSelectDropdown ///
class MultiSelectDropdown extends StatelessWidget {
  const MultiSelectDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<Job>.multiSelect(
      items: jobItems,
      initialItems: jobItems.take(2).toList(),
      onListChanged: (value) {
        debugPrint('MultiSelectDropdown onChanged value: $value');
      },
    );
  }
}

/// MultiSelectSearchDropdown ///

/// MultiSelectSearchRequestDropdown ///

/// MultiSelectDecoratedDropdown ///

/// MultiSelectValidationDropdown ///

/// MultiSelectControllerDropdown ///
class MultiSelectControllerDropdown extends StatefulWidget {
  const MultiSelectControllerDropdown({super.key});

  @override
  State<MultiSelectControllerDropdown> createState() =>
      _MultiSelectControllerDropdownState();
}

class _MultiSelectControllerDropdownState
    extends State<MultiSelectControllerDropdown> {
  final controller = MultiSelectController<Job>([]);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdown<Job>.multiSelect(
          multiSelectController: controller,
          hintText: 'Select job role',
          items: jobItems,
          decoration: CustomDropdownDecoration(
            closedSuffixIcon: InkWell(
              onTap: () {
                debugPrint('Clearing MultiSelectControllerDropdown');
                controller.clear();
              },
              child: const Icon(Icons.close),
            ),
            expandedSuffixIcon: InkWell(
              onTap: () {
                debugPrint('Clearing MultiSelectControllerDropdown');
                controller.clear();
              },
              child: const Icon(Icons.close),
            ),
          ),
          onListChanged: (value) {
            debugPrint('MultiSelectControllerDropdown onChanged value: $value');
          },
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              controller.clear();
            },
            child: const Text(
              'Clear',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (controller.value.contains(jobItems[0])) {
                controller.remove(jobItems[0]);
              } else {
                controller.add(jobItems[0]);
              }
            },
            child: const Text(
              'Toggle first item selection',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
