import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ApiProvider(api: Api(), child: const HomePage()),
    );
  }
}

class ApiProvider extends InheritedWidget {
  final Api api;
  final String uuid;
  ApiProvider({
    Key? key,
    required this.api,
    required Widget child,
  })  : uuid = const Uuid().v4(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    // ignore: unrelated_type_equality_checks
    return uuid != oldWidget;
  }

  static ApiProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ApiProvider>()!;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ValueKey _textKey = const ValueKey<String>(!null);
  String title = 'Tap the screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
        onTap: ()async {
           final api = ApiProvider.of(context);
          setState(() {
           
          });
        },
        child: Container(color: Colors.white),
      ),
    );
  }
}

class DteTimeWidget extends StatelessWidget {
  const DteTimeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final api = ApiProvider.of(context).api;
    return Text(api.dateAndTime ?? 'Tap your Screen to fetch date and time');
  }
}

class Api {
  String? dateAndTime;

  Future<String> getDateAndTime() {
    return Future.delayed(
            const Duration(seconds: 1), () => DateTime.now().toIso8601String())
        .then((value) {
      dateAndTime = value;
      return value;
    });
  }
}
