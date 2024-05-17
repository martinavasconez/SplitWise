import 'package:flutter/material.dart';
import 'package:proyectofinal/CreateGroupScreen.dart';
import 'package:proyectofinal/GroupScreen.dart';
import 'GroupDetailsScreen.dart';
import 'Usuario.dart'; // Importamos la clase Usuario para su uso aquí
import 'Grupo.dart'; // Importamos la clase Grupo para su uso aquí

class JoinGroupScreen extends StatefulWidget {
  final Usuario? usuario;
  final Grupo? group;

  JoinGroupScreen({this.group, this.usuario});

  @override
  _JoinGroupScreenState createState() => _JoinGroupScreenState();
}

class _JoinGroupScreenState extends State<JoinGroupScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController _groupCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Join Group'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Group Code'),
              ],
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        'Enter your group code:',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _groupCodeController,
                        decoration: InputDecoration(
                          hintText: 'Code',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Image.asset(
                          'assets/images/picture.png', // Ruta de la imagen
                          height: 300,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => GroupScreen(
                                  group: Grupo(id: 1, nombre: 'Group Code'),
                                  usuario: widget.usuario,
                                ),
                              ),
                            );
                          },
                          child: Text('Join Group'),
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
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                "Johanna Doe",
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              accountEmail: Text(
                "johanna@company.com",
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/JeanDoe.png'), // Ruta de la imagen de perfil
                backgroundColor: Colors.white,
              ),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text(
                'Groups',
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroupScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text(
                'Create Group',
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text(
                'Join Group',
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => JoinGroupScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
