import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'ChatApp/services/auth/auth_service.dart';
import 'app.dart';

main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print(" Firebase Connected Successfully ");

  runApp(
    ChangeNotifierProvider(create: (context)=> AuthService(),
      child: const MyApp(),
    ),
  );
}