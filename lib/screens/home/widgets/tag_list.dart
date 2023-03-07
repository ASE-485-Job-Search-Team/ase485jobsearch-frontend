import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TagList extends StatefulWidget {
  const TagList({Key? key}) : super(key: key);

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  final tagsList = <String>['All', 'Newest', 'Featured', 'Popular'];
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      height: 32.0,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Colors.grey[200]
                        : Colors.white,
                    border: Border.all(color: Colors.grey[200]!),
                    borderRadius: BorderRadius.circular(70.0),
                  ),
                  child: Text(
                    tagsList[index],
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ),
          separatorBuilder: (_, index) => const SizedBox(
                width: 12.0,
              ),
          itemCount: tagsList.length),
    );
  }
}
