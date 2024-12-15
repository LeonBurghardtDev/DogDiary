import 'package:dog_diary/widgets/restart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/data_service.dart';
import 'routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataService = DataService();
  await dataService.loadData(); // Lade gespeicherte Daten
  runApp(RestartWidget(child:DogDiaryApp(dataService: dataService)));
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
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: routes,

      ),
    );
  }
}
