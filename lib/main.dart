import 'package:clust/models/tag_model.dart';
import 'package:clust/screens/logo.dart';
import 'package:clust/screens/signinx.dart';
import 'package:clust/screens/start.dart';
import 'package:clust/styles/web_styles.dart' as web;
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' show Platform;
import 'controllers/tag_controller';

import 'models/event_model.dart';

Future<void> main() async {
    TagController controller = TagController();

///////////////////////////////////////////
//   Event newEvent = Event(
// 0,
//     'New Event',
//     'A new event',
//     2,
//     1,
//     "2023-03-19",
//    "2023-03-19",
//     'Pending',
//     0,
//     100,
//     'Thank you for registering!',
  
//   );
 

//    Event addedEvent = await controller.createEvent(newEvent);

///////////////////////////////////////////////////
  List<Tag> events = await controller.getAll();
  Tag eventbyid =await controller.getByID(2);
  events.forEach((event) {
    print(event.text_description);
  });
   print(eventbyid.text_description);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: Platform.isWindows
              ? GoogleFonts.kameronTextTheme(
                  const TextTheme(
                    displayLarge: web.displayLarge,
                    displayMedium: web.displayMedium,
                    headlineLarge: web.headlineLarge,
                    headlineMedium: web.headlineMedium,
                    headlineSmall: web.headlineSmall,
                    bodyLarge: web.bodyLarge,
                    bodyMedium: web.bodyMedium,
                    bodySmall: web.bodySmall,
                    labelLarge: web.labelLarge,
                    labelMedium: web.labelMedium,
                    labelSmall: web.labelSmall,
                  ),
                )
              : GoogleFonts.kameronTextTheme(
                  const TextTheme(
                    displayLarge: mobile.displayLarge,
                    headlineLarge: mobile.headlineLarge,
                    headlineMedium: mobile.headlineMedium,
                    headlineSmall: mobile.headlineSmall,
                    bodySmall: mobile.bodySmall,
                    labelSmall: mobile.labelSmall,
                  ),
                )),
      home: Scaffold(
        body: Center(
          child: logo(),
        ),
      ),
      routes: {
        "/start": (context) => start(),
        "/signin": (context) => signinx(),
      },
    );
  }
}
