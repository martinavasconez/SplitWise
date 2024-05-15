import 'package:flutter/material.dart';
import 'CreateGroupScreen.dart';
import 'JoinGroupScreen.dart';
import 'GroupDetailsScreen.dart'; // Asegúrate de importar la pantalla de detalles del grupo

class GroupsScreen extends StatefulWidget {
  @override
  _GroupsScreenState createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Groups"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("User Name"),
              accountEmail: Text("user@example.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("U"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('All Groups'),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text('Create Group'),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateGroupScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text('Join Group'),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JoinGroupScreen()));
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.group),
              title: Text('Plan Zens'),
              subtitle: Text('Code: 1234'),
              onTap: () {
                // Navegación a GroupDetailsScreen al tocar el grupo
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GroupDetailsScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
