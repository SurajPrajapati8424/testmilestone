import 'package:flutter/material.dart';
import 'package:auto_animated_list/auto_animated_list.dart';
import 'package:fuzzy/fuzzy.dart';

class AutolistAnimatedExample extends StatefulWidget {
  const AutolistAnimatedExample({super.key});

  @override
  State<AutolistAnimatedExample> createState() =>
      _AutolistAnimatedExampleState();
}

class _AutolistAnimatedExampleState extends State<AutolistAnimatedExample> {
  static const _limit = 10;
  String _query = '';

  List<String> get _displayedFruits {
    final fuzzy = Fuzzy<String>(
      Fruits.list,
      options: FuzzyOptions(
        threshold: 0.5,
        keys: [
          WeightedKey(name: 'name', getter: (fruit) => fruit, weight: 1),
        ],
      ),
    );
    final results = fuzzy.search(_query);
    return results
        .getRange(0, results.length > _limit ? _limit : results.length)
        .map((result) => result.item)
        .toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Auto Animated List Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchInputField(
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AutoAnimatedList<String>(
                items: _displayedFruits,
                itemBuilder: (context, fruit, index, animation) {
                  return SizeFadeTransition(
                    animation: animation,
                    child: ListTile(
                      leading: Text('${index + 1}'),
                      title: Text(fruit),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchInputField extends StatelessWidget {
  const SearchInputField({
    super.key,
    required this.onChanged,
  });

  final ValueSetter<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: 'Search',
        focusedBorder: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(),
      ),
    );
  }
}

class Fruits {
  static const List<String> list = [
    'Apple',
    'Apricot',
    'Banana',
    'Blueberry',
    'Carambola',
    'Cherry',
    'Cherimoya',
    'Durian',
    'Feijoa',
    'Fig',
    'Grape',
    'Grapefruit',
    'Grilled',
    'Guava',
    'Honeydew',
    'Kiwifruit',
    'Lemon',
    'Lime',
    'Longan',
    'Lychee',
    'Mandarin',
    'Mango',
    'Mangosteen',
    'Melon',
    'Nashi',
    'Nectarine',
    'Orange',
    'Passion fruit',
    'Papaya',
    'Peach',
    'Pear',
    'Persimmon',
    'Pineapple',
    'Plum',
    'Pomegranate',
    'Pomelo',
    'Rambutan',
    'Raspberry',
    'Rhubarb',
    'Strawberry',
    'Tangelo',
    'Watermelon',
  ];
}
