import 'package:flutter/material.dart';
import 'package:sb_diagnostics/firebase_stuff/auth_repo.dart';

import '../constants.dart';
import '../models/menu_assets.dart';
import 'side_menu_tile.dart';

// ignore: must_be_immutable
class SideMenu extends StatefulWidget {
  SideMenu({super.key, required this.menuChanger, this.selectedMenu = 0});

  final void Function(int) menuChanger;
  int selectedMenu;

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  //RiveAsset selectedMenu = sideMenus.first;
  //int selectedMenu = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: 288,
        height: double.infinity,
        color: backgroundColor2,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: medPadding,
                  bottom: medPadding,
                ),
                child: ListTile(
                  title: Text(
                    "SB Diagnostics",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              // const InfoCard(
              //   name: "Abu Anwar",
              //   profession: "",
              // ),
              ...sideMenu.map(
                (menuItem) => SideMenuTile(
                  icon: menuItem.icon,
                  title: menuItem.title,
                  press: () {
                    setState(() {
                      widget.selectedMenu = menuItem.index;
                      widget.menuChanger(menuItem.index);
                    });
                  },
                  isActive: widget.selectedMenu == menuItem.index,
                ),
              ),
              // ...sideMenu2.map(
              //   (menu) => SideMenuTile(
              //     menu: menu,
              //     riveonInit: (artboard) {
              //       // Let me show you if user click on the menu how to show the animation
              //       StateMachineController controller =
              //           RiveUtil.getRiveController(artboard,
              //               stateMachineName: menu.stateMachineName);
              //       menu.input = controller.findSMI("active") as SMIBool;
              //       // See as we click them it start animate
              //     },
              //     press: () {
              //       menu.input!.change(true);
              //       Future.delayed(const Duration(seconds: 1), () {
              //         menu.input!.change(false);
              //       });
              //       setState(() {
              //         selectedMenu = menu;
              //       });
              //     },
              //     isActive: selectedMenu == menu,
              //   ),
              // ),
              const Spacer(),
              const Align(
                alignment: Alignment.center,
                child: SignOutButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  const SignOutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() => AuthRepo.instance.logout()),
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPurple,
        minimumSize: const Size(200, 50),
        maximumSize: const Size(200, 100),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.arrow_back),
          SizedBox(width: smallPadding),
          Text(
            "Sign Out",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
