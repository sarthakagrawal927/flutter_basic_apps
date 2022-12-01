import 'package:flutter/material.dart';

import './dummy_data.dart';
import './category_item.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('DeliMeals')),
        body: GridView(
            padding: const EdgeInsets.all(25),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              // takes care of structuring the grid
              maxCrossAxisExtent: 200, // width of tile
              childAspectRatio: 3 / 2, // 300 width, 200 height
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            children: DUMMY_CATEGORIES
                .map((catData) =>
                    CategoryItem(catData.id, catData.title, catData.color))
                .toList()));
  }
}
