import 'package:flutter/material.dart';
import 'package:proyectofinal/JoinGroupScreen.dart';
import 'GroupScreen.dart';
import 'Grupo.dart'; // Importamos la clase Grupo para su uso aquí
import 'Usuario.dart'; // Importamos la clase Usuario para su uso aquí

class CreateGroupScreen extends StatefulWidget {
  final Usuario? usuario;
  final Grupo? group;

  CreateGroupScreen({this.group, this.usuario});

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  void _nextTab() {
    _tabController?.animateTo(1);
  }

  void _createGroup() async {
    // Asignamos los valores ingresados por el usuario al nuevo grupo
    String groupName = groupNameController.text;
    String groupDetails = detailsController.text;

    try {
      // Llamamos al método createAndFetchGroups del usuario actual
      await widget.usuario!.createAndFetchGroups(groupName, groupDetails);
      
      // Navegamos a la pantalla GroupScreen con el usuario actualizado
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroupScreen(usuario: widget.usuario)));
    } catch (e) {
      // Manejar errores, por ejemplo, mostrar un mensaje de error
      print(e); // Reemplaza esto con una forma adecuada de manejar errores en tu aplicación
    }
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
                widget.usuario?.nombre?? "Johanna Doe",
                style: TextStyle(color: Colors.black),
              ),
              accountEmail: Text(
                widget.usuario?.correo?? "johanna@company.com",
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/JeanDoe.png'),
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
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroupScreen(usuario: widget.usuario)));
              },
            ),
            ListTile(
              leading: Icon(Icons.group_add),
              title: Text(
                'Create Group',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupScreen(usuario: widget.usuario)));
              },
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text(
                'Join Group',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.push(context, MaterialPageRoute(builder: (context) => JoinGroupScreen(usuario: widget.usuario,)));
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