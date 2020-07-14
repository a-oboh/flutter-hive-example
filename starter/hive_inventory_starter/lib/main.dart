import 'package:flutter/material.dart';
import 'package:hive_inventory_starter/app/provider_list.dart';
import 'package:provider/provider.dart';

import 'app/router.gr.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hive Inventory',
        theme: ThemeData(
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Lato',
        ),
        onGenerateRoute: Router(),
      ),
    );
  }
}
