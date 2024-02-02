import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LandingGridItem extends StatelessWidget {
  const LandingGridItem({
    Key? key,
    required this.topImage,
    required this.topImageVisible,
    required this.image,
    required this.bottomImage,
    required this.bottomImageVisible,
    required this.press,
  }) : super(key: key);

  final String topImage;
  final bool topImageVisible;
  final String image;
  final void Function() press;
  final String bottomImage;
  final bool bottomImageVisible;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: press,
      child: Container(
        width: size.width * 0.4,
        color: Colors.white,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: -9,
              top: -9,
              child: Visibility(
                visible: topImageVisible,
                child: SvgPicture.asset(topImage),
              ),
            ),
            Positioned(
              right: -9,
              bottom: -9,
              child: Visibility(
                visible: bottomImageVisible,
                child: SvgPicture.asset(bottomImage),
              ),
            ),
            SvgPicture.asset(image),
          ],
        ),
      ),
    );
  }
}
