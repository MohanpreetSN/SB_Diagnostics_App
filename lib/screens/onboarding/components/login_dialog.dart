import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';

import '/firebase_stuff/test_controller.dart';
import '/entry_point.dart';
import '/firebase_stuff/auth_repo.dart';
import '/utils/rive_utils.dart';
import 'custom_buttons.dart';
import '/constants.dart';
import 'text_fields.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginDialog> createState() => _SignInDialogState();
}

class _SignInDialogState extends State<LoginDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool isShowConfetti = false;

  late SMITrigger check;
  late SMITrigger error;
  late SMITrigger reset;

  late SMITrigger confetti;
  final aController = Get.put(AuthRepo());

  Future<void> signInFunction(String email, password) async {
    setState(() {
      isLoading = true;
      isShowConfetti = true;
    });
    aController.justLoggedIn.value = true;

    await aController.loginWithEmailAndPassword(email, password).then((isLoggedIn) async {
      if (isLoggedIn) {
        Get.snackbar(
          "Sucess",
          "Sign in succesful!",
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green[200],
        );
        check.fire();
        //UserModel user = UserRepo.instance.userx;
        //SignUpController.instance.createUser(user);

        await Future.delayed(const Duration(seconds: 2), () async {
          setState(() {
            isLoading = false;
          });

          confetti.fire();

          await Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              isShowConfetti = false;
            });
            AuthRepo.instance.justLoggedIn.value = false;
            Get.offAll(
              () => const EntryPoint(),
              transition: Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 400),
            );
          });
        });
      } else {
        Get.snackbar("Oops", "Your username or password is incorrect", backgroundColor: Colors.red[200]);
        error.fire();

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            isLoading = false;
          });
        });
      }
    });
  }

  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  final testController = Get.put(TestController());

  bool textError = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: MediaQuery.of(context).viewInsets,
        height: textError ? 440 : 400,
        width: MediaQuery.of(context).size.width - 2 * medPadding,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.90),
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: smallPadding,
                    top: medPadding,
                  ),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 34,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: medPadding,
                    right: medPadding,
                    bottom: smallPadding,
                  ),
                  child: Text(
                    "Note: Username/Password will be sent via text message after registration at the lab's reception.",
                    style: TextStyle(color: Colors.black.withOpacity(0.7)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: medPadding,
                    right: medPadding,
                    //bottom: medPadding,
                  ),
                  child: Stack(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Username",
                              style: TextStyle(color: Colors.black54),
                            ),
                            UsernameTextField(controller: _userNameController),
                            const Text(
                              "Password",
                              style: TextStyle(color: Colors.black54),
                            ),
                            PasswordTextField(controller: _passwordController),
                            RoundedRectangleButton(
                              label: "Log in",
                              onpressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  signInFunction("${_userNameController.text}@gmail.com", _passwordController.text);
                                } else {
                                  setState(() {
                                    textError = true;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      isLoading
                          ? CustomPosition(
                              child: RiveAnimation.asset(
                                "assets/RiveAssets/check.riv",
                                onInit: (artboard) {
                                  StateMachineController controller = RiveUtil.getRiveController(artboard);
                                  check = controller.findSMI("Check") as SMITrigger;
                                  error = controller.findSMI("Error") as SMITrigger;
                                  reset = controller.findSMI("Reset") as SMITrigger;
                                },
                              ),
                            )
                          : const SizedBox(),
                      isShowConfetti
                          ? CustomPosition(
                              child: Transform.scale(
                                scale: 6,
                                child: RiveAnimation.asset(
                                  "assets/RiveAssets/confetti.riv",
                                  onInit: (artboard) {
                                    StateMachineController controller = RiveUtil.getRiveController(artboard);

                                    confetti = controller.findSMI("Trigger explosion") as SMITrigger;
                                  },
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
