import 'package:flutter/material.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Новости', style: TextStyle(fontSize: 20)),
    );
  }
}
