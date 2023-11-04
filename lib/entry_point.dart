import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import 'package:sb_diagnostics/screens/contact/contact_screen.dart';
import 'package:sb_diagnostics/screens/profile/profile_screen.dart';
import 'package:sb_diagnostics/screens/reports/reports_screen.dart';

import '../components/side_menu.dart';
import 'components/animated_bar.dart';
import 'constants.dart';
import '../screens/tests/tests_screen.dart';
import '../utils/rive_utils.dart';
import 'components/menu_button.dart';
import 'models/menu_assets.dart';
import 'screens/home/home_screen.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key, this.selectedNav = 0});

  final int selectedNav;

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation animation;
  late Animation<double> scaleAnimation;

  late SMIBool isSideBarClosed;

  bool isSideMenuClosed = true;

  int selectedBottomNav = 0;
  int selectedSideBarNav = 0;

  @override
  void initState() {
    selectedBottomNav = widget.selectedNav;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget? screenMaker(int index) {
    if (index == 1) {
      return const TestsScreen();
    } else if (index == 2) {
      return const ReportsScreen();
    } else if (index == 3) {
      return const ProfileScreen();
    } else {
      return const HomeScreen();
    }
  }

  void menuChanger(int index) {
    if (index <= 3) {
      setState(() {
        selectedBottomNav = index;
      });
      Future.delayed(
        const Duration(milliseconds: 200),
        () {
          isSideBarClosed.value = !isSideBarClosed.value;
          if (isSideMenuClosed) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
          setState(() {
            isSideMenuClosed = isSideBarClosed.value;
          });
        },
      );
    } else {
      if (index == 4) {
        isSideBarClosed.value = !isSideBarClosed.value;
        if (isSideMenuClosed) {
          _animationController.forward();
        } else {
          _animationController.reverse();
        }
        setState(() {
          isSideMenuClosed = isSideBarClosed.value;
        });
        Get.to(() => const ContactScreen());
      }
    }
  }

  int sideBarValueChanger() {
    if (selectedBottomNav == 0 || selectedBottomNav == 1 || selectedBottomNav == 2 || selectedBottomNav == 3) {
      selectedSideBarNav = selectedBottomNav;
    } else {
      selectedSideBarNav = 0;
    }
    return selectedSideBarNav;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.fastOutSlowIn,
            // ignore: sort_child_properties_last
            child: SideMenu(
              menuChanger: menuChanger,
              selectedMenu: sideBarValueChanger(),
            ),
            width: 288,
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 288, 0),
              child: Transform.scale(
                scale: scaleAnimation.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(animation.value * 24)),
                  child: GestureDetector(
                    onTap: isSideMenuClosed
                        ? null
                        : () {
                            isSideBarClosed.value = !isSideBarClosed.value;
                            _animationController.reverse();
                            setState(() {
                              isSideMenuClosed = isSideBarClosed.value;
                            });
                          },
                    onPanUpdate: isSideMenuClosed
                        ? null
                        : (details) {
                            if (details.delta.dx < 0) {
                              isSideBarClosed.value = !isSideBarClosed.value;
                              _animationController.reverse();
                              setState(() {
                                isSideMenuClosed = isSideBarClosed.value;
                              });
                            }
                          },
                    child: screenMaker(selectedBottomNav),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: 15,
            right: medPadding,
            child: MenuButton(
              riveInit: (artboard) {
                StateMachineController controller = RiveUtil.getRiveController(artboard, stateMachineName: "State Machine");
                isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                isSideBarClosed.value = true;
              },
              press: () {
                isSideBarClosed.value = !isSideBarClosed.value;
                if (isSideMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(() {
                  isSideMenuClosed = isSideBarClosed.value;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        // offset: Offset(0, animation.value * 100),
        offset: Offset(
          0,
          Platform.isAndroid ? animation.value * 120 - 20 : animation.value * 100,
        ),
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(24)),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 7,
                  sigmaY: 7,
                  //tileMode: TileMode.mirror,
                ),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: backgroundColor2.withOpacity(0.8),
                    borderRadius: const BorderRadius.all(Radius.circular(24)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ...List.generate(
                        bottomNavs.length,
                        (index) => GestureDetector(
                          onTap: () {
                            if (index != selectedBottomNav) {
                              setState(() {
                                selectedBottomNav = index;
                              });
                            }
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedBar(isActive: index == selectedBottomNav),
                              SizedBox(
                                height: 32,
                                width: 32,
                                child: Opacity(
                                  opacity: index == selectedBottomNav ? 1 : 0.5,
                                  child: bottomNavs[index],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
