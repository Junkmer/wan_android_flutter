import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: double.infinity,
              child: Swiper(
                indicatorLayout: PageIndicatorLayout.NONE,
                autoplay: true,
                pagination: const SwiperPagination(),
                control: const SwiperControl(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    height: 150.h,
                    color: Colors.lightBlue,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
