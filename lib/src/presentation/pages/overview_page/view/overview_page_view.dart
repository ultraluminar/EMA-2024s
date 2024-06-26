import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fridge_manager/l10n/l10n.dart';
import 'package:fridge_manager/src/presentation/home/cubit/home_cubit.dart';

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).overviewAppBarTitle)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(S.of(context).nothingToSeeHereYet),
            TextButton(
              onPressed: () =>
                  context.read<HomeCubit>().setTab(HomeTab.products),
              child: Text(S.of(context).productsPageLink),
            ),
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(S.of(context).overviewAppBarTitle)),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ElevatedButton.icon(
//               icon: const Icon(Icons.notifications_none_outlined),
//               onPressed: () {
//                 LocalNotification.showSimpleNotification(
//                     title: "Warning!",
//                     body: "Ure mom is about to expire!",
//                     payload: "Take my load!");
//               },
//               label: const Text("Balls Notification"),
//             )
//             // Text(S.of(context).nothingToSeeHereYet),
//             // TextButton(
//             //   onPressed: () =>
//             //       context.read<HomeCubit>().setTab(HomeTab.products),
//             //   child: Text(S.of(context).productsPageLink),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
