import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/data_service.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataService = DataService();
  await dataService.loadData(); // Lade gespeicherte Daten
  runApp(DogDiaryApp(dataService: dataService));
}

class DogDiaryApp extends StatelessWidget {
  final DataService dataService;

  const DogDiaryApp({Key? key, required this.dataService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => dataService,
      child: MaterialApp(
        title: 'Dog Diary',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: routes,
      ),
    );
  }
}
