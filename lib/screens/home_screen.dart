import 'package:flutter/material.dart';
import '../helpers/database_helper.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Database'),
      ),
      body: Center(
        child: FutureBuilder(
          future: DatabaseHelper.instance.database,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text('Database initialized with sample data!');
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
