// import 'package:doc_tracker/Models/Class/data.dart';
// import 'package:doc_tracker/Models/Widgets/card.dart';
// import 'package:doc_tracker/Models/Widgets/style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {

//     Widget UpPage = Column(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Container(
//         child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Losted',
//                 style: bodyLightStyle(ColorApp.primaryText, fontSize: 30),
//               ),
//               Text(
//                 'Documents',
//                 style: bodyBoldStyle(ColorApp.primaryText, fontSize: 30),
//               )
//             ]),
//       ),
//       space,
//       search(),
//       space,
//       Container(
//         margin: paddingSymetric(vertical: 16),
//         width: getSize(context).width,
//         height: 50,
//         child: ListView(
//           scrollDirection: Axis.horizontal,
//           children: AppData.categoryList
//               .map((e) => CategoryWidget(model: e))
//               .toList(),
//         ),
//       ),
//     ],
//   );


//     ColorApp().init(context);
//     return Scaffold(
//       body: Container(
//         padding: paddingOnly(top: 100, bottom: 16, right: 16, left: 16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             UpPage,
//             Container(
//                 child: GridView.count(
//               padding: EdgeInsets.zero,
//               childAspectRatio: 0.75,
//               crossAxisCount: 2,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               children: List.generate(
//                   AppData.categoryList.length, (index) => DocumentCard()),
//             )),
//           ],
//         ),
//       ),
//     );
    
//   }



//   Widget search() {
//     return Container(
//       child: Row(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               height: 50,
//               alignment: Alignment.center,
//               padding: paddingOnly(top: 8),
//               decoration: BoxDecoration(
//                   color: ColorApp.fieldColor,
//                   borderRadius: BorderRadius.all(Radius.circular(10))),
//               child: Center(
//                 child: TextField(
//                   cursorColor: primaryMain,
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: "Search Documents",
//                       hintStyle: footnoteStyle(ColorApp.secondaryText),
//                       contentPadding: EdgeInsets.only(
//                           left: 10, right: 10, bottom: 0, top: 5),
//                       prefixIcon: Icon(Icons.search, color: Colors.black54)),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 20),
//           Container(
//             padding: paddingAll(10),
//             decoration: BoxDecoration(
//                 borderRadius: circularBorder,
//                 color: ColorApp.defaultBackgroundColor,
//                 boxShadow [boxShadow(context)]),
//             child: Icon(
//               Icons.filter_list,
//               color: ColorApp.blackWhiteColor,
//             ),
//           )
//         ],
//       ),
//     );

    
//   }

//   Widget CategoryWidget({required Category model}) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           model.isSelected = !model.isSelected;
//         });
//       },
//       child: Container(
//           // height: 70,
//           padding: paddingSymetric(vertical: 4, horizontal: 8),
//           margin: paddingOnly(
//             right: 16,
//           ),
//           decoration: BoxDecoration(
//               borderRadius: circularBorder,
//               color: model.isSelected
//                   ? ColorApp.defaultBackgroundColor
//                   : Colors.transparent,
//               border: Border.all(
//                 color: model.isSelected ? primaryMain : Colors.grey,
//                 width: model.isSelected ? 2 : 1,
//               ),
//               boxShadow [boxShadow(context)]),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SvgPicture.asset(
//                 model.asset,
//                 color: ColorApp.blackWhiteColor,
//                 // height: 20,
//               ),
//               Text(model.name, style: bodyStyle(ColorApp.secondaryText)),
//             ],
//           )),
//     );
//   }


    
// }
