import 'package:flutter/material.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets margin;
  final double height;
  final double width;
  final double fontSize;
  final double radius;
  final IconData icon;
  CustomButton(
      {this.onPressed,
      @required this.buttonText,
      this.transparent = false,
      this.margin,
      this.width,
      this.height,
      this.fontSize,
      this.radius = 5,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onPressed == null
          ? Theme.of(context).disabledColor
          : transparent
              ? Colors.transparent
              : Theme.of(context).primaryColor,
      minimumSize: Size(width != null ? width : Dimensions.WEB_MAX_WIDTH,
          height != null ? height : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
    );

    return Container(
        // margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          //border:Border.all(color:Colors.black)
        ),
        child: SizedBox(
            width: width != null ? width : Dimensions.WEB_MAX_WIDTH,
            child: TextButton(
              onPressed: onPressed,
              style: _flatButtonStyle,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                icon != null
                    ? Padding(
                        padding: EdgeInsets.only(
                            right: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        child: Icon(icon,
                            color: transparent
                                ? Theme.of(context).primaryColor
                                : Colors.white),
                      )
                    : SizedBox(),
                Text(buttonText ?? '',
                    textAlign: TextAlign.center,
                    style: robotoBold.copyWith(
                      color: transparent
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      fontSize: fontSize != null
                          ? fontSize
                          : Dimensions.fontSizeLarge,
                    )),
              ]),
            )));
  }
}
