import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/constants/enums.dart';
import 'package:social_media/core/themes/themes.dart';

import 'package:social_media/presentation/screens/home/end_drawer.dart';

import 'package:social_media/presentation/screens/post/post_screen.dart';
import 'package:social_media/presentation/widgets/gap.dart';

ValueNotifier<int> _bottomNav = ValueNotifier(0);

class HomeScreen extends StatelessWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  // final UserModel model;

  final _homeScaffold = GlobalKey<ScaffoldState>(debugLabel: "homeScaffold");
  openDrawer() {
    _homeScaffold.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: EndDrawer(),
      key: _homeScaffold,
      appBar: PreferredSize(
        preferredSize: appBarHeight,
        child: MainAppBar(),
      ),

      //
      //

      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _bottomNav,
        builder: (BuildContext context, int index, _) {
          return Container(
            height: 67.sm,
            child: BottomNavigationBar(
                currentIndex: _bottomNav.value,
                onTap: (value) {
                  if (value == 4) {
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                    //   context.read<UserDataBloc>().add(GetCurrentUser());
                    // });
                    _homeScaffold.currentState!.openEndDrawer();
                  } else {
                    _bottomNav.value = value;
                    _bottomNav.notifyListeners();
                  }
                },
                selectedIconTheme: Theme.of(context).iconTheme,
                unselectedIconTheme: Theme.of(context).iconTheme.copyWith(
                    color: Theme.of(context).iconTheme.color!.withOpacity(0.5)),
                // backgroundColor: ,
                elevation: 5,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.house,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_photo_alternate),
                    label: "Add New Post",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: "Search",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.forum),
                    label: "Chats",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: "Menu",
                  ),
                ]),
          );
        },
      ),
      resizeToAvoidBottomInset: false,
      body: ValueListenableBuilder(
          valueListenable: _bottomNav,
          builder: (context, int, _) {
            return SafeArea(child: _screens[_bottomNav.value]);
          }),
    );
  }
}

final _screens = [PostScreen(), Scaffold(), Scaffold(), Scaffold(), Scaffold()];

ValueNotifier<bool> _theme = ValueNotifier(false);

class MainAppBar extends StatelessWidget {
  const MainAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).appBarTheme.color,
      elevation: 2,
      automaticallyImplyLeading: false,
      title:
          Text("APPLICATION", style: Theme.of(context).textTheme.titleMedium),
      actions: [
        Gap(W: 15.sm),
        Builder(builder: (context) {
          return Stack(
            alignment: Alignment.centerLeft,
            children: [
              Center(
                child: IconButton(
                    onPressed: () {},
                    icon: IconTheme(
                      data: Theme.of(context).primaryIconTheme,
                      child: Icon(
                        Icons.notifications,
                        size: 25.sm,
                      ),
                    )),
              ),
              CircleAvatar(
                radius: 8.sm,
                backgroundColor: primary,
                child: Text(
                  "10+",
                  style: smallTextureStyle.copyWith(
                      fontSize: 8.sm, color: pureWhite),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }
}
