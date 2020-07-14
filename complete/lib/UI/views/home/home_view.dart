import 'package:flutter/material.dart';
import 'package:hive_reminder_app/core/models/inventory_model.dart';
import 'package:provider/provider.dart';

import '../../../app/extensions/size_extension.dart';
import '../../../app/size_config.dart';
import 'home_model.dart';

class HomeView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    context.watch<HomeModel>().getInventory();

    return Consumer<HomeModel>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Padding(
            padding: EdgeInsets.only(top: 6.height),
            child: Column(
              children: <Widget>[
                Text(
                  'Hive Inventory',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Lato',
                  ),
                ),
                Container(
                  height: 90.height,
                  child: ListView.builder(
                    itemCount: model.inventoryList.length,
                    itemBuilder: (context, index) {
                      Inventory inv = model.inventoryList[index];

                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 2.height,
                          horizontal: 4.5.width,
                        ),
                        height: 13.height,
                        // width: 50.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 2.width),
                              width: 16.width,
                              decoration: BoxDecoration(
                                color: Colors.green[600],
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.home,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 3.height,
                                horizontal: 3.width,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    inv.name,
                                    style: TextStyle(
                                      color: Colors.green[600],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 4.5.text,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.height,
                                  ),
                                  Text(
                                    inv.description,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 4.text,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.width),
                              child: PopupMenuButton(
                                onSelected: (item) {
                                  switch (item) {
                                    case 'update':
                                      nameController.text = inv.name;
                                      descriptionController.text =
                                          inv.description;

                                      inputItemDialog(context, 'update', index);
                                      break;
                                    case 'delete':
                                      model.deleteAt(index);
                                  }
                                },
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      value: 'update',
                                      child: Text('Update'),
                                    ),
                                    PopupMenuItem(
                                      value: 'delete',
                                      child: Text('Delete'),
                                    ),
                                  ];
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              inputItemDialog(context, 'add');
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 8.width,
            ),
          ),
        );
      },
    );
  }

  inputItemDialog(BuildContext context, String action, [int index]) {
    var inventoryDb = Provider.of<HomeModel>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 40,
            ),
            height: 45.height,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      action == 'add' ? 'Add Item' : 'Update Item',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Item name cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Item name',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Item description cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Item description',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          if (action == 'add') {
                            await inventoryDb.addInventory(Inventory(
                              name: nameController.text,
                              description: descriptionController.text,
                            ));
                          } else {
                            await inventoryDb.updateAt(
                                index,
                                Inventory(
                                  name: nameController.text,
                                  description: descriptionController.text,
                                ));
                          }

                          nameController.clear();
                          descriptionController.clear();

                          inventoryDb.getInventory();

                          Navigator.pop(context);
                        }
                      },
                      color: Colors.green[600],
                      child: Text(
                        action == 'add' ? 'Add' : 'update',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
