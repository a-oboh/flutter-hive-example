import 'package:hive_inventory_starter/UI/views/home/home_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel()),
  ];

