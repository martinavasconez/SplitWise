import 'package:flutter/material.dart';
import 'GroupDetailsScreen.dart';
import 'Grupo.dart'; // Make sure this import points to the correct location of Grupo.dart
import 'Usuario.dart';

class AddItemScreen extends StatefulWidget {
  final Usuario? usuario;
  final Grupo? group;

  AddItemScreen({Key? key, this.usuario, this.group}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Description'),
            Tab(text: 'Price'),
          ],
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Description tab content
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Placeholder',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          // Price tab content
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color.fromARGB(255, 78, 179, 204)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: priceController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: '\$20',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Assuming the user ID is available and passed correctly
                      int? userId = widget.usuario?.id; // Make sure to handle nullability appropriately
                      String itemName = descriptionController.text;
                      double cost = double.parse(priceController.text);

                      // Call addItem method
                      await widget.group!.addItem(itemName, cost, userId!);

                      // Call update methods
                      await widget.group!.updateDeudaPorUsuario();
                      await widget.group!.updateGroupDetails();

                      Navigator.push(context, MaterialPageRoute(builder: (context) => GroupDetailsScreen(group: widget.group, usuario: widget.usuario)));


                      // Navigator.pop(context); // Navigate back after operations
                    },
                    child: Text('Add Item'),
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
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // This will now be handled by the ElevatedButton in the Price tab
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}