// import 'package:demand_supply/screens/admin/giveAdminPrivs.dart';
// import 'package:demand_supply/screens/admin/listUnverifiedPosts.dart';
// import 'package:flutter/material.dart';

// class AdminPageScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Admin Priviledges",
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Material(
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text('Give Admin Privileges'),
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => GiveAdminPrivsPage())),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Material(
//                 elevation: 4,
//                 child: ListTile(
//                   title: Text('Verify Posts'),
//                   onTap: () => Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ListUnverifiedPosts())),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
