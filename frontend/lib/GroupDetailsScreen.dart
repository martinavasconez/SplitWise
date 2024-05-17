import 'package:flutter/material.dart';
import 'TotalScreen.dart';
import 'AddItemScreen.dart'; // Asegúrate de crear esta pantalla
import 'Grupo.dart'; // Importamos la clase Grupo para su uso aquí
import 'Usuario.dart'; // Importamos la clase Usuario para su uso aquí

class GroupDetailsScreen extends StatefulWidget {
  final Usuario? usuario;
  final Grupo? group;

  GroupDetailsScreen({this.group, this.usuario});

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget buildItemCard(String title, String price) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.shopping_cart),
        title: Text(title),
        subtitle: Text('Gaby'), // Aquí puedes cambiar el nombre dinámicamente si es necesario
        trailing: Text('\$$price'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan Zens'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Details'),
            Tab(text: 'Members'),
            Tab(text: 'Items'),
          ],
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Here are the details of the group...',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Members',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '2 members in the group',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => TotalScreen()));
                    },
                    child: Text('Get Budget'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 78, 179, 204), // Color del botón
                      foregroundColor: Colors.white,    // Color del texto
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      buildItemCard('BOTELLA', '70'),
                      buildItemCard('UBER', '5'),
                      buildItemCard('otro', '15'),
                    ],
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => AddItemScreen(group: widget.group, usuario: widget.usuario)));
                  },
                  child: Icon(Icons.add),
                  backgroundColor: Color.fromARGB(255, 78, 179, 204),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
