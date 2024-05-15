import 'package:flutter/material.dart';

class TotalScreen extends StatefulWidget {
  @override
  _TotalScreenState createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Total')),
      body: Column(
        children: [
          ListTile(
            title: Text('Total Spent'),
            trailing: Text('\$70'),
          ),
          ListTile(
            title: Text('Total per Person'),
            trailing: Text('\$20'),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Gaby'),
                  subtitle: Text('Paid: \$20\nTo be paid: \$5'),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Martina'),
                  subtitle: Text('Paid: \$20\nTo be paid: \$5'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
