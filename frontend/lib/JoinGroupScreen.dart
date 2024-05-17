import 'package:flutter/material.dart';
import 'package:proyectofinal/CreateGroupScreen.dart';
import 'package:proyectofinal/GroupScreen.dart';
import 'GroupDetailsScreen.dart';
import 'Usuario.dart'; // Importamos la clase Usuario para su uso aquí
import 'Grupo.dart'; // Importamos la clase Grupo para su uso aquí

class JoinGroupScreen extends StatefulWidget {
  final Usuario? usuario;

  JoinGroupScreen({required this.usuario});

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

  Future<void> _joinGroup() async {
    try {
      int groupId = int.tryParse(_groupCodeController.text)?? 0;
      if (widget.usuario!= null && groupId > 0) {
        await widget.usuario!.joinGroup(groupId);
        // Navigate to the GroupScreen after successfully joining the group
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => GroupScreen(
              group: Grupo(id: groupId, nombre: 'Joined Group'),
              usuario: widget.usuario,
            ),
          ),
        );
      } else {
        // Handle invalid input or other errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid group code.')));
      }
    } catch (e) {
      // Handle exceptions, e.g., failed to join group
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to join group.')));
    }
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
                          onPressed: _joinGroup,
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
                style: TextStyle(color: Colors.black), // Cambia el color del texto a negro
              ),
              onTap: () {
                Navigator.pop(context); // Cierra el drawer
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => GroupScreen(usuario: widget.usuario,)));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => CreateGroupScreen(usuario: widget.usuario,)));
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => JoinGroupScreen(usuario: widget.usuario)));
              },
            ),
          ],
        ),
      ),
    );
  }
}