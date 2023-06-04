import 'package:carousel_slider/carousel_slider.dart';
import 'package:clust/controllers/api_helper.dart';
import 'package:clust/controllers/user_controller.dart';
import 'package:clust/globals.dart';
import 'package:clust/providers/event_spot_provider.dart';
import 'package:clust/styles/palate.dart';
import 'package:clust/styles/responsive.dart';
import 'package:clust/widgets/events_view.dart';
import 'package:clust/widgets/image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:clust/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clust/icons/my_flutter_app_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clust/styles/mobile_styles.dart' as mobile;
import 'package:provider/provider.dart';

class HomeMob extends StatefulWidget {
  HomeMob({super.key});

  @override
  State<HomeMob> createState() => _HomeMobState();
}

class _HomeMobState extends State<HomeMob> {
  List<IconData> icons = const [
    Icons.star_rounded,
    MyFlutterApp.live,
    MyFlutterApp.tinywow_stain_25094549,
    MyFlutterApp.icons8_open_delivered_box_100,
  ];
  List<String> labels = const [
    " Create events",
    " Live events",
    " Spots",
    " Memories",
  ];

  @override
  Widget build(BuildContext context) {
    return Responsive(
        mobile: mobileWidget(),
        desktop: Container(
          child: Center(
            child: Text("Not Supported"),
          ),
        ));
  }

  Widget mobileWidget() {
    return FutureBuilder<User>(
      future: UserController().getAll(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
        return Theme(
          data: !kIsWeb ? theme(context) : ThemeData(),
          child: Scaffold(
            appBar: appBar(snapshot),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 150.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return card(index);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  hotInAmman(),
                  SizedBox(
                    height: 30.h,
                  ),
                  imageSlider(),
                  SizedBox(
                    height: 30.h,
                  ),
                  explore(),
                  Container(
                    width: double.infinity,
                    child: Consumer(
                      builder: (BuildContext context,
                          eventSpotProvider provider, Widget? child) {
                        return EventsView(provider.allEvents);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Padding explore() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Text(
        "Explore",
        style: GoogleFonts.kameron(
            textStyle: mobile.headlineLarge(color: Palate.black)),
      ),
    );
  }

  SizedBox imageSlider() {
    return SizedBox(
      height: 200,
      child: Consumer(
        builder:
            (BuildContext context, eventSpotProvider provider, Widget? child) {
          if (!provider.empty())
            return Center(
              child: Container(height: 200, child: slider(provider)),
            );
          else
            return SizedBox();
        },
      ),
    );
  }

  Padding hotInAmman() {
    return Padding(
      padding: EdgeInsets.only(left: 10.w),
      child: Text(
        "Hot in Amman",
        style: GoogleFonts.kameron(
            textStyle: mobile.headlineLarge(color: Palate.black)),
      ),
    );
  }

  CarouselSlider slider(eventSpotProvider provider) {
    return CarouselSlider(
      items: provider.hotEvents
          .map(
            (event) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/displayEvent", arguments: event);
              },
              child: Card(
                clipBehavior: Clip.hardEdge,
                child: Container(
                    width: double.infinity,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        ImageView(event),
                        shadow(),
                        txt(provider, event),
                      ],
                    )),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        height: 200,
        autoPlay: true,
        enlargeFactor: 0.2,
        aspectRatio: 0,
        enlargeCenterPage: true,
      ),
    );
  }

  ThemeData theme(BuildContext context) {
    return ThemeData(
      textTheme: Theme.of(context).textTheme.copyWith(
            displayLarge: mobile.displayLarge(color: Colors.amber),
            headlineLarge: mobile.headlineLarge(color: Palate.black),
            headlineMedium: mobile.headlineMedium(color: Palate.black),
            headlineSmall: mobile.headlineSmall(color: Palate.black),
            bodySmall: mobile.bodySmall(color: Palate.black),
            labelSmall: mobile.labelSmall(color: Palate.black),
          ),
    );
  }

  SizedBox card(int index) {
    return SizedBox(
      width: 200.w,
      child: GestureDetector(
        onTap: () {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, "/creatEvent");
              break;
            case 1:
              Navigator.pushNamed(context, "/displayEvents",
                  arguments: "Live Events");
              break;
            case 2:
              Navigator.pushNamed(context, "/spots");
              break;
            case 3:
              Navigator.pushNamed(context, "/memories");
              break;
          }
        },
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient:
                      LinearGradient(colors: [Color(0xffF4E7CA), Palate.sand]),
                ),
              ),
              bgIcon(index),
              cardLabel(index),
            ],
          ),
        ),
      ),
    );
  }

  Positioned bgIcon(int index) {
    return Positioned(
      right: 15.w,
      bottom: -50.h,
      child: Icon(
        icons[index],
        size: 250,
        color: Palate.black.withOpacity(0.1),
      ),
    );
  }

  Positioned cardLabel(int index) {
    return Positioned(
        bottom: 20.h,
        left: 20.w,
        child: Row(
          children: [
            Icon(
              icons[index],
              size: 25,
              color: Palate.black,
            ),
            Text(" ${labels[index]}"),
          ],
        ));
  }

  PreferredSize appBar(AsyncSnapshot<User> snapshot) {
    return PreferredSize(
      preferredSize: Size.fromHeight(75.0.h),
      child: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        centerTitle: false,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            "Welcome ${snapshot.data!.firstName}",
            style: GoogleFonts.kameron(
                textStyle: mobile.displayLarge(color: Palate.black)),
          ),
        ),
      ),
    );
  }

  Align txt(eventSpotProvider provider, event) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${event.name}",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "${event.organizer!.firstName}",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Align shadow() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.7),
              Colors.black.withOpacity(0),
            ],
            begin: const FractionalOffset(0.0, 1.0),
            end: const FractionalOffset(0.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
        ));
  }
}
