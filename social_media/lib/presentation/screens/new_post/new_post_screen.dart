import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/application/new_post/new_post_bloc.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/constants/enums.dart';
import 'package:social_media/domain/db/user_data/user_data.dart';
import 'package:social_media/domain/global/global_variables.dart';
import 'package:social_media/domain/models/post/post_model.dart';
import 'package:social_media/presentation/widgets/gap.dart';
import 'package:social_media/presentation/widgets/video_player.dart';
import 'package:uuid/uuid.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) async {

    // });

    return const Scaffold(
      appBar: PreferredSize(
        child: NewPostAppBar(),
        preferredSize: appBarHeight,
      ),
      body: SafeArea(
        child: NewPostBody(),
      ),
    );
  }
}

TextEditingController _discr = TextEditingController();
TextEditingController _tag = TextEditingController();

class NewPostAppBar extends StatelessWidget {
  const NewPostAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.sm),
          bottomRight: Radius.circular(40.sm)),
      child: AppBar(
        // backgroundColor: Theme.of(context).appBarTheme.color,
        elevation: 2,
        // titleSpacing: 45.sm,
        // centerTitle: true,

        leading: Padding(
          padding: EdgeInsets.only(left: 30.sm),
          child: Builder(builder: (context) {
            return Center(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: IconTheme(
                    data: Theme.of(context).primaryIconTheme,
                    child: Icon(
                      Icons.arrow_back,
                      size: 25.sm,
                    ),
                  )),
            );
          }),
        ),

        automaticallyImplyLeading: false,
        title: Text("Add New Post",
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontSize: 23, fontWeight: FontWeight.w500)),
        // actions: [
        //   Gap(W: 30.sm),
        //   IconButton(
        //     icon: Icon(Icons.upload),
        //     onPressed: () {},
        //   ),
        //   Gap(W: 15.sm),
        // ],
      ),
    );
  }
}

ValueNotifier<BoxFit> _fit = ValueNotifier(BoxFit.fitHeight);

class NewPostBody extends StatelessWidget {
  const NewPostBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
          child: Padding(
        padding: constPadding,
        child: Center(
          child: BlocConsumer<NewPostBloc, NewPostState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  state.postType == PostType.image
                      ? ValueListenableBuilder(
                          valueListenable: _fit,
                          builder: (context, BoxFit value, _) {
                            return Container(
                              height: 250.sm,
                              width: 350,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: _fit.value,
                                      image: FileImage(File(
                                          state.post!.files.single.path!))),
                                  color: softBlack,
                                  borderRadius: BorderRadius.circular(10.sm)),
                            );
                          })
                      : Container(
                          height: 250.sm,
                          decoration: BoxDecoration(color: softBlack),
                          // child: LocalVideoPlayer(
                          //     path: state.post!.files.single.path!),
                        ),
                  Gap(
                    H: 20.sm,
                  ),
                  state.postType == PostType.image
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _fit.value = BoxFit.fitHeight;
                                  _fit.notifyListeners();
                                },
                                icon: Icon(Icons.fullscreen)),
                            IconButton(
                                onPressed: () {
                                  _fit.value = BoxFit.cover;
                                  _fit.notifyListeners();
                                },
                                icon: Icon(Icons.fullscreen_exit)),
                            IconButton(
                                onPressed: () {
                                  _fit.value = BoxFit.fill;
                                  _fit.notifyListeners();
                                },
                                icon: Icon(Icons.crop_5_4)),
                          ],
                        )
                      : SizedBox(),
                  Gap(H: 20.sm),
                  SizedBox(
                    width: 350.sm,
                    height: 75.sm,
                    child: TextField(
                      cursorColor: darkBlue,
                      maxLength: 100,
                      style: TextStyle(
                          color: softBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sm),
                      controller: _discr,
                      decoration: InputDecoration(
                        hintText: "Discription",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5.sm),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 221, 221, 221),
                      ),
                    ),
                  ),
                  Gap(
                    H: 10.sm,
                  ),
                  SizedBox(
                    width: 350.sm,
                    height: 75.sm,
                    child: TextField(
                      cursorColor: darkBlue,
                      maxLength: 30,
                      style: TextStyle(
                          color: softBlack,
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sm),
                      controller: _tag,
                      decoration: InputDecoration(
                        hintText: "Tag",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5.sm),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 221, 221, 221),
                      ),
                    ),
                  ),
                  Gap(
                    H: 30.sm,
                  ),
                  TextButton.icon(
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                vertical: 10.sm, horizontal: 20.sm)),
                        backgroundColor: MaterialStateProperty.all(darkBlue),
                      ),
                      onPressed: () {},
                      icon: IconTheme(
                          data: Theme.of(context).primaryIconTheme,
                          child: Icon(Icons.upload)),
                      label: Text(
                        "Upload",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge!
                            .copyWith(fontSize: 15.sm),
                      ))
                ],
              );
            },
          ),
        ),
      )),
    );
  }
}
