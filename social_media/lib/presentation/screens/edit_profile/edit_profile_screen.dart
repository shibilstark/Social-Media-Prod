// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:social_media/application/pick_media/pick_media_bloc.dart';
// import 'package:social_media/application/user/user_bloc.dart';
// import 'package:social_media/core/colors/colors.dart';
// import 'package:social_media/core/constants/constants.dart';
// import 'package:social_media/core/controllers/text_controllers.dart';
// import 'package:social_media/domain/models/post_model/post_model.dart';
// import 'package:social_media/presentation/screens/profile/widgets/profile_part.dart';
// import 'package:social_media/presentation/widgets/gap.dart';

// class EditProfileScreen extends StatelessWidget {
//   const EditProfileScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       appBar: PreferredSize(
//         child: EditProfileAppBar(),
//         preferredSize: appBarHeight,
//       ),
//       body: SafeArea(child: EditProfileBody()),
//     );
//   }
// }

// class EditProfileAppBar extends StatelessWidget {
//   const EditProfileAppBar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(40.sm),
//           bottomRight: Radius.circular(40.sm)),
//       child: AppBar(
//         leading: Padding(
//           padding: EdgeInsets.only(left: 15.sm),
//           child: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//         title: Text(
//           "Edit Profile",
//           style: Theme.of(context)
//               .textTheme
//               .titleMedium!
//               .copyWith(color: pureWhite),
//         ),
//       ),
//     );
//   }
// }

// String? _newProfilePic;
// String? _newCoverPic;

// class EditProfileBody extends StatelessWidget {
//   const EditProfileBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 5.sm, horizontal: 10.sm),
//       child: SingleChildScrollView(
//           child: BlocConsumer<UserBloc, UserState>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           if (state is FetchCurrentUserSuccess) {
//             final userModel = state.data.user;

//             EditProfileTextEditingControllers.discription.text =
//                 userModel.discription;
//             EditProfileTextEditingControllers.name.text = userModel.name;
//             final profilePic = userModel.profileImage;
//             final coverPic = userModel.coverImage;

//             return BlocConsumer<PickMediaBloc, PickMediaState>(
//               listener: (context, pickMediaState) {},
//               builder: (context, pickMediaState) {
//                 if (PickMediaState is PickMediaSuccess) {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Stack(
//                         alignment: Alignment.bottomRight,
//                         children: [
//                           //
//                           //
//                           //
//                           //
//                           //
//                           //
//                           //
//                           Builder(builder: (context) {
//                             if (pickMediaState is PickCoverImageSuccess) {
//                               _newCoverPic = pickMediaState.postTypeModel.file;
//                               return Container(
//                                 width: double.infinity,
//                                 constraints: BoxConstraints(maxHeight: 150.sm),
//                                 child: Image.asset(
//                                   _newCoverPic!,
//                                   fit: BoxFit.cover,
//                                 ),
//                               );
//                             } else {
//                               return ClipRRect(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(40.sm),
//                                     topRight: Radius.circular(40.sm)),
//                                 child: userModel.coverImage == "" ||
//                                         userModel.coverImage.isEmpty
//                                     ? Container(
//                                         constraints:
//                                             BoxConstraints(maxHeight: 150.sm),
//                                         color: primaryBlue,
//                                         width: double.infinity,
//                                       )
//                                     : userModel.coverImage != "" ||
//                                             userModel.coverImage.isNotEmpty
//                                         ? Container(
//                                             width: double.infinity,
//                                             constraints: BoxConstraints(
//                                                 maxHeight: 150.sm),
//                                             child: Image.network(
//                                               coverPic,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           )
//                                         : SizedBox(),
//                               );
//                             }
//                           }),

//                           Padding(
//                             padding: EdgeInsets.all(10.sm),
//                             child: GestureDetector(
//                               onTap: () {
//                                 context
//                                     .read<PickMediaBloc>()
//                                     .add(PickCoverImage(type: PostType.image));
//                               },
//                               child: Container(
//                                 height: 40.sm,
//                                 width: 40.sm,
//                                 decoration: BoxDecoration(
//                                     color: darkBg,
//                                     borderRadius: BorderRadius.circular(5.sm)),
//                                 child: Icon(
//                                   Icons.edit,
//                                   color: pureWhite,
//                                   size: 15.sm,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           //
//                           //
//                           //
//                           //
//                           //
//                           //
//                           //
//                         ],
//                       ),
//                       Gap(H: 20.sm),
//                       Row(
//                         children: [
//                           Stack(
//                             alignment: Alignment.bottomRight,
//                             children: [
//                               userModel.profileImage == "" ||
//                                       userModel.profileImage.isEmpty
//                                   ? CircleAvatar(
//                                       radius: 70.sm,
//                                       backgroundColor: darkBg,
//                                       backgroundImage:
//                                           AssetImage(dummyProfilePicture),
//                                     )
//                                   : userModel.profileImage == profilePic
//                                       ? CircleAvatar(
//                                           radius: 70.sm,
//                                           backgroundColor: darkBg,
//                                           backgroundImage:
//                                               NetworkImage(profilePic),
//                                         )
//                                       : CircleAvatar(
//                                           radius: 70.sm,
//                                           backgroundColor: darkBg,
//                                           backgroundImage:
//                                               AssetImage(profilePic),
//                                         ),
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                   height: 25.sm,
//                                   width: 25.sm,
//                                   decoration: BoxDecoration(
//                                       color: primaryBlue,
//                                       borderRadius:
//                                           BorderRadius.circular(5.sm)),
//                                   child: Icon(
//                                     Icons.edit,
//                                     color: pureWhite,
//                                     size: 15.sm,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Gap(
//                             W: 10.sm,
//                           ),
//                           Column(
//                             children: [
//                               LimitedBox(
//                                 maxWidth: 250.sm,
//                                 child: TextField(
//                                   controller:
//                                       EditProfileTextEditingControllers.name,
//                                   cursorColor: primaryBlue,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium!
//                                       .copyWith(fontSize: 16.sm),
//                                   decoration: InputDecoration(
//                                     contentPadding:
//                                         EdgeInsets.symmetric(horizontal: 10.sm),
//                                     hintText: "Profile name",
//                                     hintStyle: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                             color: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyMedium!
//                                                 .color!
//                                                 .withOpacity(0.5)),
//                                     focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .color!,
//                                           width: 1.sm),
//                                       borderRadius: BorderRadius.circular(5.sm),
//                                     ),
//                                     border: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .color!,
//                                           width: 1.sm),
//                                       borderRadius: BorderRadius.circular(5.sm),
//                                     ),
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Theme.of(context)
//                                             .textTheme
//                                             .bodyMedium!
//                                             .color!,
//                                         width: 1.sm,
//                                       ),
//                                       borderRadius: BorderRadius.circular(5.sm),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       Gap(
//                         H: 10.sm,
//                       ),
//                       TextField(
//                         controller:
//                             EditProfileTextEditingControllers.discription,
//                         cursorColor: primaryBlue,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyMedium!
//                             .copyWith(fontSize: 16.sm),
//                         decoration: InputDecoration(
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: 10.sm),
//                           hintText: "About you",
//                           hintStyle: Theme.of(context)
//                               .textTheme
//                               .bodyMedium!
//                               .copyWith(
//                                   color: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium!
//                                       .color!
//                                       .withOpacity(0.5)),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .color!,
//                                 width: 1.sm),
//                             borderRadius: BorderRadius.circular(5.sm),
//                           ),
//                           border: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .color!,
//                                 width: 1.sm),
//                             borderRadius: BorderRadius.circular(5.sm),
//                           ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium!
//                                   .color!,
//                               width: 1.sm,
//                             ),
//                             borderRadius: BorderRadius.circular(5.sm),
//                           ),
//                         ),
//                       ),
//                       Gap(
//                         H: 30.sm,
//                       ),
//                       ElevatedButton(
//                           onPressed: () {},
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Update",
//                                 style: TextStyle(
//                                     color: smoothWhite,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16.sm),
//                               ),
//                             ],
//                           ))
//                     ],
//                   );
//                 } else {
//                   return Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Stack(
//                         alignment: Alignment.bottomRight,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(40.sm),
//                                 topRight: Radius.circular(40.sm)),
//                             child: userModel.coverImage != "" ||
//                                     userModel.coverImage.isEmpty
//                                 ? Container(
//                                     constraints:
//                                         BoxConstraints(maxHeight: 150.sm),
//                                     color: primaryBlue,
//                                     width: double.infinity,
//                                   )
//                                 : userModel.coverImage != "" ||
//                                         userModel.coverImage.isNotEmpty
//                                     ? Container(
//                                         width: double.infinity,
//                                         constraints:
//                                             BoxConstraints(maxHeight: 150.sm),
//                                         child: Image.network(
//                                           userModel.coverImage,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       )
//                                     : Container(),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.all(10.sm),
//                             child: GestureDetector(
//                               onTap: () {
//                                 context
//                                     .read<PickMediaBloc>()
//                                     .add(PickCoverImage(type: PostType.image));
//                               },
//                               child: Container(
//                                 height: 25.sm,
//                                 width: 25.sm,
//                                 decoration: BoxDecoration(
//                                     color: darkBg,
//                                     borderRadius: BorderRadius.circular(5.sm)),
//                                 child: Icon(
//                                   Icons.edit,
//                                   color: pureWhite,
//                                   size: 15.sm,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Gap(H: 20.sm),
//                       Row(
//                         children: [
//                           Stack(
//                             alignment: Alignment.bottomRight,
//                             children: [
//                               userModel.profileImage == "" ||
//                                       userModel.profileImage.isEmpty
//                                   ? CircleAvatar(
//                                       radius: 70.sm,
//                                       backgroundColor: darkBg,
//                                       backgroundImage:
//                                           AssetImage(dummyProfilePicture),
//                                     )
//                                   : userModel.profileImage == profilePic
//                                       ? CircleAvatar(
//                                           radius: 70.sm,
//                                           backgroundColor: darkBg,
//                                           backgroundImage:
//                                               NetworkImage(profilePic),
//                                         )
//                                       : CircleAvatar(
//                                           radius: 70.sm,
//                                           backgroundColor: darkBg,
//                                           backgroundImage:
//                                               AssetImage(profilePic),
//                                         ),
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                   height: 25.sm,
//                                   width: 25.sm,
//                                   decoration: BoxDecoration(
//                                       color: primaryBlue,
//                                       borderRadius:
//                                           BorderRadius.circular(5.sm)),
//                                   child: Icon(
//                                     Icons.edit,
//                                     color: pureWhite,
//                                     size: 15.sm,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Gap(
//                             W: 10.sm,
//                           ),
//                           Column(
//                             children: [
//                               LimitedBox(
//                                 maxWidth: 250.sm,
//                                 child: TextField(
//                                   controller:
//                                       EditProfileTextEditingControllers.name,
//                                   cursorColor: primaryBlue,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium!
//                                       .copyWith(fontSize: 16.sm),
//                                   decoration: InputDecoration(
//                                     contentPadding:
//                                         EdgeInsets.symmetric(horizontal: 10.sm),
//                                     hintText: "Profile name",
//                                     hintStyle: Theme.of(context)
//                                         .textTheme
//                                         .bodyMedium!
//                                         .copyWith(
//                                             color: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyMedium!
//                                                 .color!
//                                                 .withOpacity(0.5)),
//                                     focusedBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .color!,
//                                           width: 1.sm),
//                                       borderRadius: BorderRadius.circular(5.sm),
//                                     ),
//                                     border: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                           color: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .color!,
//                                           width: 1.sm),
//                                       borderRadius: BorderRadius.circular(5.sm),
//                                     ),
//                                     enabledBorder: UnderlineInputBorder(
//                                       borderSide: BorderSide(
//                                         color: Theme.of(context)
//                                             .textTheme
//                                             .bodyMedium!
//                                             .color!,
//                                         width: 1.sm,
//                                       ),
//                                       borderRadius: BorderRadius.circular(5.sm),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                       Gap(
//                         H: 10.sm,
//                       ),
//                       TextField(
//                         controller:
//                             EditProfileTextEditingControllers.discription,
//                         cursorColor: primaryBlue,
//                         style: Theme.of(context)
//                             .textTheme
//                             .bodyMedium!
//                             .copyWith(fontSize: 16.sm),
//                         decoration: InputDecoration(
//                           contentPadding:
//                               EdgeInsets.symmetric(horizontal: 10.sm),
//                           hintText: "About you",
//                           hintStyle: Theme.of(context)
//                               .textTheme
//                               .bodyMedium!
//                               .copyWith(
//                                   color: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium!
//                                       .color!
//                                       .withOpacity(0.5)),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .color!,
//                                 width: 1.sm),
//                             borderRadius: BorderRadius.circular(5.sm),
//                           ),
//                           border: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                                 color: Theme.of(context)
//                                     .textTheme
//                                     .bodyMedium!
//                                     .color!,
//                                 width: 1.sm),
//                             borderRadius: BorderRadius.circular(5.sm),
//                           ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Theme.of(context)
//                                   .textTheme
//                                   .bodyMedium!
//                                   .color!,
//                               width: 1.sm,
//                             ),
//                             borderRadius: BorderRadius.circular(5.sm),
//                           ),
//                         ),
//                       ),
//                       Gap(
//                         H: 30.sm,
//                       ),
//                       ElevatedButton(
//                           onPressed: () {},
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 "Update",
//                                 style: TextStyle(
//                                     color: smoothWhite,
//                                     fontWeight: FontWeight.w500,
//                                     fontSize: 16.sm),
//                               ),
//                             ],
//                           ))
//                     ],
//                   );
//                 }
//               },
//             );
//           } else {
//             return Container(
//               child: Center(
//                 child: Text("Something went wrong refresh and come back"),
//               ),
//             );
//           }
//         },
//       )),
//     );
//   }
// }
