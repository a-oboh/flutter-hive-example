import 'package:hive_reminder_app/UI/views/home/home_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';


  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<HomeModel>(create: (context) => HomeModel()),
  ];

