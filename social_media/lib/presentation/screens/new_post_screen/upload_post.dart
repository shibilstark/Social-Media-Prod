import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_media/core/colors/colors.dart';
import 'package:social_media/core/constants/constants.dart';
import 'package:social_media/core/controllers/text_editing_controllers.dart';
import 'package:social_media/presentation/widgets/custom_text_field.dart';
import 'package:social_media/presentation/widgets/gap.dart';

class UploadPostScreen extends StatelessWidget {
  const UploadPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        child: NewPostAppBar(),
        preferredSize: appBarHeight,
      ),
      body: SafeArea(child: UploadPostBody()),
      // bottomSheet: UploadPostBottomSheetWidget(),
    );
  }
}

class UploadPostBody extends StatelessWidget {
  const UploadPostBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.sm, horizontal: 5.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(H: 20.sm),
              Container(
                color: Theme.of(context).bottomSheetTheme.backgroundColor,
                height: (width * 0.95) / (4 / 3),
                width: width * 0.95,
                // child: Image.asset(
                //   "assets/dummy/1.webp",
                //   // fit: BoxFit.,
                //   // fill
                //   // cover
                //   // fitHeight
                //   //
                // ),
              ),
              Gap(H: 40.sm),
              Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 400.sm),
                  child: Column(
                    children: [
                      UploadPostTextField(
                          controller: PostTextFieldControllers.discription,
                          hint: "discription",
                          length: 250),
                      UploadPostTextField(
                          controller: PostTextFieldControllers.tag,
                          hint: "tag",
                          length: 30),
                      Gap(H: 30.sm),
                      SizedBox(
                        height: 40.sm,
                        width: 200.sm,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Upload",
                                  style: TextStyle(
                                      color: smoothWhite,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.sm),
                                ),
                                Gap(
                                  W: 5.sm,
                                ),
                                Icon(
                                  Icons.upload_sharp,
                                  size: 20.sm,
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UploadPostTextField extends StatelessWidget {
  const UploadPostTextField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.length})
      : super(key: key);
  final String hint;
  final TextEditingController controller;
  final int length;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: length,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      controller: controller,
      cursorColor: primaryBlue,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16.sm),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.sm),
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context)
                .textTheme
                .bodyMedium!
                .color!
                .withOpacity(0.5)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
              width: 1.sm),
          borderRadius: BorderRadius.circular(5.sm),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Theme.of(context).textTheme.bodyMedium!.color!,
              width: 1.sm),
          borderRadius: BorderRadius.circular(5.sm),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).textTheme.bodyMedium!.color!,
            width: 1.sm,
          ),
          borderRadius: BorderRadius.circular(5.sm),
        ),
      ),
    );
  }
}

// class UploadPostBottomSheetWidget extends StatelessWidget {
//   const UploadPostBottomSheetWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BottomSheet(
//         enableDrag: false,
//         onClosing: () {},
//         builder: (ctx) {
//           return ClipRRect(
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(40.sm),
//                 topRight: Radius.circular(40.sm)),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).pop();
//               },
//               child: Container(
//                 height: 40.sm,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.upload,
//                       color: pureWhite,
//                     ),
//                     Gap(
//                       W: 10.sm,
//                     ),
//                     Text(
//                       "Send Post",
//                       style: TextStyle(
//                           color: pureWhite,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 19.sm),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
// }

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
