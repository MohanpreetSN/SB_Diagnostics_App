// import 'package:flutter/material.dart';
// import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
// import 'package:get/get.dart';
// import 'package:rive/rive.dart';
// import 'package:sb_diagnostics/firebase_stuff/user_repo.dart';
// import 'package:sb_diagnostics/models/user_model.dart';

// import '../../../constants.dart';
// import '../../../entry_point.dart';
// import '../../../firebase_stuff/auth_repo.dart';
// import '../../../firebase_stuff/otp_controller.dart';
// import '../../../firebase_stuff/signup_controller.dart';
// import '../../../utils/rive_utils.dart';
// import 'custom_buttons.dart';
// import 'red_circular_button.dart';
// import 'signin_button.dart';
// import 'text_fields.dart';

// class SignUpDialog extends StatefulWidget {
//   const SignUpDialog({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<SignUpDialog> createState() => _SignUpDialogState();
// }

// class _SignUpDialogState extends State<SignUpDialog> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   bool isLoading = false;
//   bool isShowConfetti = false;

//   late SMITrigger check;
//   late SMITrigger error;
//   late SMITrigger reset;

//   late SMITrigger confetti;

//   //bool isOtpVerification = false;
//   String otp = "000000";

//   Future<void> signInFunction(String otp) async {
//     setState(() {
//       isLoading = true;
//       isShowConfetti = true;
//     });
//     await OtpController.instance.verifyOtp(otp).then((isVerified) async {
//       if (isVerified) {
//         Get.snackbar(
//           "Sucess",
//           "Sign in succesful!",
//           duration: const Duration(seconds: 3),
//           backgroundColor: Colors.green[200],
//         );
//         check.fire();
//         UserModel user = UserRepo.instance.userx;
//         SignUpController.instance.createUser(user);
//         await Future.delayed(const Duration(seconds: 2), () async {
//           setState(() {
//             isLoading = false;
//           });

//           confetti.fire();

//           await Future.delayed(const Duration(seconds: 1), () {
//             setState(() {
//               isShowConfetti = false;
//             });

//             Get.offAll(
//               () => const EntryPoint(),
//               transition: Transition.rightToLeftWithFade,
//               duration: const Duration(milliseconds: 400),
//             );
//             SignUpController.instance.signUpOtp.value = false;
//           });
//         });
//       } else {
//         error.fire();

//         Future.delayed(const Duration(seconds: 2), () {
//           setState(() {
//             isLoading = false;
//           });
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scontroller = Get.put(SignUpController());
//     // ignore: unused_local_variable
//     final otpController = Get.put(OtpController());

//     return Center(
//       child: Container(
//         margin: MediaQuery.of(context).viewInsets,
//         height: 415,
//         width: MediaQuery.of(context).size.width - 2 * medPadding,
//         //kmargin: const EdgeInsets.symmetric(horizontal: medPadding),
//         decoration: BoxDecoration(
//           color: Colors.white.withOpacity(0.90),
//           borderRadius: const BorderRadius.all(
//             Radius.circular(40),
//           ),
//         ),
//         child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.transparent,
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const Padding(
//                   padding: EdgeInsets.only(
//                     bottom: smallPadding,
//                     top: medPadding,
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         fontSize: 34,
//                         fontFamily: "Poppins",
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(
//                     left: medPadding,
//                     right: medPadding,
//                     //bottom: smallPadding,
//                   ),
//                   child: Stack(
//                     children: [
//                       if (!SignUpController.instance.signUpOtp.value)
//                         Form(
//                           key: _formKey,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "First Name",
//                                 style: TextStyle(color: Colors.black54),
//                               ),
//                               NameTextField(scontroller: scontroller),
//                               const Text(
//                                 "Phone Number",
//                                 style: TextStyle(color: Colors.black54),
//                               ),
//                               PhoneTextField(scontroller: scontroller),
//                               RoundedRectangleButton(
//                                 label: "Continue",
//                                 padding: const EdgeInsets.only(
//                                   top: smallPadding,
//                                   bottom: medPadding,
//                                 ),
//                                 onpressed: () async {
//                                   if (_formKey.currentState!.validate()) {
//                                     final user = UserModel(
//                                         firstName: scontroller.name.text.trim(),
//                                         lastName: "",
//                                         phoneNo: scontroller.fullNum.trim(),
//                                         dob: "",
//                                         gender: "",
//                                         email: "");
//                                     UserRepo.instance.userx = user;
//                                     SignUpController.instance.phoneAuthentication(user.phoneNo);
//                                     setState(
//                                       () {
//                                         SignUpController.instance.signUpOtp.value = true;
//                                       },
//                                     );
//                                   }
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       if (SignUpController.instance.signUpOtp.value)
//                         Column(
//                           children: [
//                             const Text(
//                               "Please type in the OTP sent to your mobile number through text",
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: medPadding),
//                             OtpTextField(
//                               numberOfFields: 6,
//                               fillColor: darkPurple.withOpacity(0.2),
//                               filled: true,
//                               keyboardType: TextInputType.number,
//                               onSubmit: (code) async {
//                                 otp = code;
//                                 AuthRepo.instance.justLoggedIn.value = true;
//                                 await signInFunction(otp);
//                                 AuthRepo.instance.justLoggedIn.value = false;
//                               },
//                             ),
//                             const SizedBox(height: medPadding),
//                             RoundedRectangleButton(
//                                 onpressed: () async {
//                                   AuthRepo.instance.justLoggedIn.value = true;
//                                   await signInFunction(otp);
//                                   AuthRepo.instance.justLoggedIn.value = false;
//                                 },
//                                 label: "Sign Up"),
//                             HalfRoundedButton(
//                               label: "Go Back",
//                               onpressed: () {
//                                 setState(() {
//                                   SignUpController.instance.signUpOtp.value = false;
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       isLoading
//                           ? CustomPosition(
//                               child: RiveAnimation.asset(
//                                 "assets/RiveAssets/check.riv",
//                                 onInit: (artboard) {
//                                   StateMachineController controller = RiveUtil.getRiveController(artboard);
//                                   check = controller.findSMI("Check") as SMITrigger;
//                                   error = controller.findSMI("Error") as SMITrigger;
//                                   reset = controller.findSMI("Reset") as SMITrigger;
//                                 },
//                               ),
//                             )
//                           : const SizedBox(),
//                       isShowConfetti
//                           ? CustomPosition(
//                               child: Transform.scale(
//                                 scale: 6,
//                                 child: RiveAnimation.asset(
//                                   "assets/RiveAssets/confetti.riv",
//                                   onInit: (artboard) {
//                                     StateMachineController controller = RiveUtil.getRiveController(artboard);

//                                     confetti = controller.findSMI("Trigger explosion") as SMITrigger;
//                                   },
//                                 ),
//                               ),
//                             )
//                           : const SizedBox(),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: medPadding),
//                   child: RedCircularButton(
//                     label: "Sign In",
//                     width: 140,
//                     onPressed: () {
//                       Navigator.pop(context);
//                       openSignInDialog(context);
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
