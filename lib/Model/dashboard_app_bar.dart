import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:luckyman_managers_app/Model/appbar_widgets.dart';
import 'package:luckyman_managers_app/Model/filter_widget.dart';
import 'package:luckyman_managers_app/Screens/homescreen2.dart';

class DashboardAppBar extends StatelessWidget {
  const DashboardAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SliverAppBar(
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Amount",
                    textScaleFactor: 1.12,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black.withOpacity(.7),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    "GH¢0.00",
                    textScaleFactor: 1.12,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Seat Booked",
                    textScaleFactor: 1.12,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.black.withOpacity(.7),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    "300",
                    textScaleFactor: 1.12,
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.lightBlue,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // snap: true,
      pinned: true,
      // floating: true,
      expandedHeight: 200,
      forceElevated: true,
      elevation: 20,
      shadowColor: const Color(0xffF0F0F0).withOpacity(.4),
      backgroundColor: Colors.white,
      title: const Text(
        'DASHBOARD',
        textScaleFactor: 1.12,
        style: TextStyle(
          color: Colors.lightBlue,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          color: Colors.lightBlue,
          tooltip: "Search",
          enableFeedback: true,
          icon: const Icon(
            Icons.search,
            color: Colors.lightBlue,
          ),
          onPressed: () {},
        ),
        AppBarIcons(
          icon: Icons.filter_list_rounded,
          toolTip: "Filter",
          onPressed: () {
            Get.bottomSheet(
              Container(
                height: size.height * 0.9,
                color: Colors.white,
                child: FilterWidget(),
              ),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              isScrollControlled: true,
            );
          },
        ),
        AppBarIcons(
          icon: Icons.more_vert_rounded,
          toolTip: "More",
          onPressed: () {},
        ),
      ],
      bottom: TabBar(
        isScrollable: true,
        indicatorColor: Colors.black.withOpacity(.8),
        unselectedLabelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        unselectedLabelColor: Colors.black.withOpacity(.4),
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: Colors.black.withOpacity(.8),
        tabs: tabs,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }
}
