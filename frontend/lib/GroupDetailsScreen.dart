import 'package:flutter/material.dart';
import 'AddItemScreen.dart';
import 'TotalScreen.dart';

class GroupDetailsScreen extends StatefulWidget {
  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Zens'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Details',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '2 members in the group',
                style: TextStyle(fontSize: 18),
              ),
            ),
            ListTile(
              title: Text('BOTELLA'),
              subtitle: Text('Gaby'),
              trailing: Text('\$70'),
            ),
            ListTile(
              title: Text('UBER'),
              subtitle: Text('Martina'),
              trailing: Text('\$5'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddItemScreen()));
                },
                child: Icon(Icons.add),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TotalScreen()));
                },
                child: Text('Get Budget'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
