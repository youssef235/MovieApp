import 'dart:js';
import 'package:flutter/material.dart';

import 'category_box.dart';

class CategoryWidget {
  Widget buildCategory(
    BuildContext context,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CatBox().catbox(context, "Action"),
            CatBox().catbox(context, "Comedy"),
            CatBox().catbox(context, "Drama"),
            CatBox().catbox(context, "Fiction"),
            CatBox().catbox(context, "cartoon"),
          ],
        ),
      ),
    );
  }
}
