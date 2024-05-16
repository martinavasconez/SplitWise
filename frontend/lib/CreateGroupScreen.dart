import 'package:flutter/material.dart';
import 'package:proyectofinal/JoinGroupScreen.dart';
import 'GroupScreen.dart';
import 'Grupo.dart'; // Importamos la clase Grupo para su uso aquí

class CreateGroupScreen extends StatefulWidget {
  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  late Grupo newGroup; // Variable para almacenar el nuevo grupo

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    newGroup = Grupo(
      id: 0, // Aquí puedes asignar un ID único al grupo
      nombre: '',
      articulos: {},
      total: 0.0,
      totalPorUsuario: {},
      deudaPorUsuario: {},
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _nextTab() {
    _tabController?.animateTo(1);
  }

  void _createGroup() {
    // Asignamos los valores ingresados por el usuario al nuevo grupo
    newGroup.nombre = groupNameController.text;
    // Aquí puedes continuar asignando otros valores del grupo si es necesario

    // Lógica para crear el grupo
    // En este punto, podrías guardar el nuevo grupo en tu base de datos o realizar otras acciones necesarias
    // En este ejemplo, simplemente lo pasamos a la pantalla GroupScreen
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroupScreen(group: newGroup)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Group"),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Name of group'),
                Tab(text: 'Details'),
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
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: TextField(
                          controller: groupNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter the group name',
                            border: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                                                    onPressed: _nextTab,
                          child: Text('Next'),
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: TextField(
                          controller: detailsController,
                          decoration: InputDecoration(
                            hintText: 'Enter your plans',
                            border: UnderlineInputBorder(),
                          ),
                          maxLines: 4,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _createGroup,
                          child: Text('Create Group'),
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
    );
  }
}

