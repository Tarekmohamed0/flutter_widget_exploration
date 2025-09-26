import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_exploration/dragabble/dragabble.dart';

import 'advanced animation/advanced_animation.dart';
import 'reordebale list/reordebale_list.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Widget Exploration'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ExampleItem(
                  title: 'Reorderable List',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => ReordebaleList()),
                  ),
                ),
                ExampleItem(
                  title: 'Draggable Widget',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (builder) => Dragabble()),
                  ),
                ),
                ExampleItem(
                  title: 'Advanced Animation',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => AdvancedAnimation(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExampleItem extends StatelessWidget {
  const ExampleItem({super.key, required this.title, required this.onTap});
  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CupertinoListTile(
            trailing: Icon(Icons.arrow_forward_ios),
            padding: EdgeInsets.all(20),
            title: Text(
              title,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
