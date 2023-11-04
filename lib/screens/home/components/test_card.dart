import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../tests/components/test_view_screen.dart';
import 'glass_morph.dart';
import '../../../models/test_model.dart';

class TestCard extends StatelessWidget {
  const TestCard({
    Key? key,
    required this.test,
  }) : super(key: key);

  final TestModel test;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: medPadding, right: medPadding, top: medPadding),
      child: GestureDetector(
        onTap: () => Get.to(() => TestViewScreen(test: test)),
        child: Stack(
          children: [
            Container(
              height: 95,
              width: MediaQuery.of(context).size.width - 2 * medPadding,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: const DecorationImage(
                  image: AssetImage("assets/Backgrounds/smallTriangleLight.png"),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    //color: pinkPurple.withOpacity(0.5),
                    offset: Offset(1, 1),
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                  ), //BoxShadow
                ],
              ),
            ),
            GlassMorph(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              height: 36,
              width: (MediaQuery.of(context).size.width - 2 * medPadding) * 0.75,
              sigma: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: medPadding),
                child: TestCardTitle(title: test.title),
              ),
            ),
            Positioned(
              top: 32,
              right: medPadding,
              child: GlassMorph(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                height: 36,
                width: 80,
                sigma: 10,
                child: Container(
                  //padding: const EdgeInsets.only(top: smallPadding),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: smallPadding),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        "₹ ${test.price}",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: medPadding,
              top: 36 + smallPadding,
              child: SizedBox(
                width: (MediaQuery.of(context).size.width - 2 * medPadding) * 0.7 - smallPadding,
                child: Text(
                  test.details,
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TestCardTitle extends StatelessWidget {
  const TestCardTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: smallPadding),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
