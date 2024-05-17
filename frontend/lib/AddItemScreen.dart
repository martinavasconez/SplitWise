import 'package:flutter/material.dart';

class AddItemScreen extends StatefulWidget {
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
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                    onPressed: () {
                      // Aquí puedes añadir la lógica para añadir el ítem
                      Navigator.pop(context); // Regresa a la pantalla anterior (GroupDetailsScreen)
                    },
                    child: Text('Add Item'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 78, 179, 204), // Color del botón
                      foregroundColor: Colors.white, // Color del texto
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
    );
  }
}
