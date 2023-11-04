// import 'package:flutter/material.dart';

// import '../../../constants.dart';
// import 'signup_dialog.dart';

// void openSignUpDialog(BuildContext context) {
//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: "Sign Up",
//     transitionDuration: const Duration(milliseconds: 400),
//     transitionBuilder: (context, a1, a2, widget) {
//       final curvedValue = Curves.easeInOut.transform(a1.value) - 1.0;
//       return Transform(
//         transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
//         child: Opacity(opacity: a1.value, child: const SignUpDialog()),
//       );
//     },
//     pageBuilder: (context, animation, secondaryAnimation) => Container(),
//   );
// }

// class SignUpButton extends StatelessWidget {
//   const SignUpButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {
//         Future.delayed(
//           const Duration(milliseconds: 200),
//           () {
//             openSignUpDialog(context);
//           },
//         );
//       },
//       style: ElevatedButton.styleFrom(
//         backgroundColor: darkBlue,
//         minimumSize: const Size(250, 50),
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(12)),
//         ),
//       ),
//       child: const Text(
//         "Sign Up",
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontSize: 18,
//         ),
//       ),
//     );
//   }
// }
