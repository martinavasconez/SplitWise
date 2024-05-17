import 'package:flutter/material.dart';
import 'package:proyectofinal/AddItemScreen.dart';
import 'package:proyectofinal/TotalScreen.dart';
import 'Grupo.dart';
import 'Usuario.dart';

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

    // Call updateGroupDetails and updateDeudaPorUsuario at the beginning
    widget.group?.updateGroupDetails().then((_) {
      widget.group?.updateDeudaPorUsuario();
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget buildItemCard(int userId, String itemName, double cost) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.shopping_cart),
        title: Text(itemName),
        subtitle: Text(widget.group!.listaDeUsuarios[userId]?? 'Unknown User'), // Display user name
        trailing: Text('\$$cost'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.group!.nombre),
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
                  widget.group!.detalles?? 'No details available',
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
                  '${widget.group!.listaDeUsuarios.length} members in the group',
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
                      backgroundColor: Color.fromARGB(255, 78, 179, 204),
                      foregroundColor: Colors.white,
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
                  child: ListView.builder(
                    itemCount: widget.group!.articulos.keys.length,
                    itemBuilder: (context, index) {
                      int userId = widget.group!.articulos.keys.elementAt(index);
                      Map<String, double> userItems = widget.group!.articulos[userId]!;
                      return Column(
                        children: userItems.entries.map((entry) {
                          return buildItemCard(userId, entry.key, entry.value);
                        }).toList(),
                      );
                    },
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