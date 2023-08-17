import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task4/root.dart';

// firebaseConfig = {
// apiKey: "AIzaSyB_sYddSiWToQwx_yF_BWuPnMk0NNPJxY4",
// authDomain: "jimshad-87988.firebaseapp.com",
// projectId: "jimshad-87988",
// storageBucket: "jimshad-87988.appspot.com",
// messagingSenderId: "48588202226",
// appId: "1:48588202226:web:4b2d8b31e7f7e9ab53b06b",
// measurementId: "G-ZCP5YXPS8D"
// };
var h;
var w;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyB_sYddSiWToQwx_yF_BWuPnMk0NNPJxY4",
            appId: "1:48588202226:web:4b2d8b31e7f7e9ab53b06b",
            messagingSenderId: "48588202226",
            projectId: "jimshad-87988"));
  } else{
    await Firebase.initializeApp();
  }
    runApp(const ProviderScope(child: Task()));
}

class Task extends StatefulWidget {
  const Task({super.key});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {


    @override
  Widget build(BuildContext context) {
    h = MediaQuery.sizeOf(context).height;
    w = MediaQuery.sizeOf(context).width;
    return const MaterialApp(debugShowCheckedModeBanner: false,
        home: Rootpage());
  }
}
