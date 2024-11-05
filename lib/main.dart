import 'package:firebase_core/firebase_core.dart';
import 'package:firetoken/firebase_options.dart';
import 'package:firetoken/model/notification_model.dart';
import 'package:firetoken/services/database_helper.dart';
import 'package:firetoken/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized

  /* Firebase Integration */
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseService.instance.initializeFirebase();

  /* Hive Database Initialize */
  await Hive.initFlutter();
  await DatabaseHelper.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FireToken',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFf1f9ea),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF9cee69),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF9cee69),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _token; // Variable to hold the token

  Future<void> getTokenAndPrint() async {
    String? token = await FirebaseService.instance.generateToken();
    setState(() {
      _token = token; // Update the token state
    });
  }

  // Function to copy the token to clipboard
  void _copyToken() {
    if (_token != null) {
      Clipboard.setData(ClipboardData(text: _token.toString()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTokenAndPrint();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FireToken"),
        actions: [
          IconButton(
            onPressed: _launchUrl,
            icon: const Icon(Icons.web),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Your Device FCM Token",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    // Display token in a container
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                          color: const Color(0xFFfff5ed),
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(color: Colors.black)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _token ?? "Fetching Token...",
                            style: const TextStyle(fontSize: 11),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16), // Spacing
                          InkWell(
                            onTap: _copyToken,
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: const Color(0xFF9cee69),
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(color: Colors.black)),
                              child: const Center(
                                child: Text("Copy Token"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Notification List",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Divider(),
                const SizedBox(
                  height: 10.0,
                ),
                // List of Notification
                Expanded(
                  child: ValueListenableBuilder(
                    valueListenable:
                        Hive.box(DatabaseHelper.notification).listenable(),
                    builder: (context, notifications, child) {
                      final data = notifications.values
                          .whereType<Map<dynamic, dynamic>>()
                          .toList();
                      if (notifications.isEmpty) {
                        return const Center(
                          child: Text('No notifications found.'),
                        );
                      }
                      return ListView.separated(
                        itemCount: data.length,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final res = NotificationModel.fromJson(data[index]);
                          return ListTile(
                            title: Column(
                              children: [
                                Text(
                                  res.notification!.title.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                SizedBox(
                                  height:
                                      res.notification!.android!['imageUrl'] !=
                                              null
                                          ? 10.0
                                          : 0.0,
                                ),
                                res.notification!.android!['imageUrl'] != null
                                    ? Image.network(
                                        res.notification!.android!['imageUrl'])
                                    : const SizedBox()
                              ],
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(
                                  top: res.notification!.android!['imageUrl'] !=
                                          null
                                      ? 15.0
                                      : 8.0),
                              child: Text(
                                res.notification!.body.toString(),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _sendNotificationUrl,
        label: const Text("Send Notification"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse('https://trueulymarket.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _sendNotificationUrl() async {
    final Uri url = Uri.parse('https://firetoken.trueulymarket.com/');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
