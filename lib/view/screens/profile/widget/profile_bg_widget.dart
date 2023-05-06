import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileBgWidget extends StatelessWidget {
  final Widget circularImage;
  final Widget mainWidget;
  final bool backButton;
  ProfileBgWidget({@required this.mainWidget, @required this.circularImage, @required this.backButton});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [

      /*  Stack(clipBehavior: Clip.none, children: [

          Center(
            child: Container(
              width: Dimensions.WEB_MAX_WIDTH, height: 260,
              decoration: BoxDecoration
                (
                color: Colors.white
                 *//* image: DecorationImage(image: AssetImage(
                      "assets/image/appBg.png"
                  ),
                      fit: BoxFit.fill)*//*
              ),
            ),
          ),

          SizedBox(
            width: context.width, height: 260,
            child: Center(child: Image.asset(Images.profile_bg, height: 260, width: Dimensions.WEB_MAX_WIDTH, fit: BoxFit.fill)),
          ),

          Positioned(
            top: 200, left: 0, right: 0, bottom: 0,
            child: Center(
              child: Container(
                width: Dimensions.WEB_MAX_WIDTH,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_EXTRA_LARGE)),
                   //color:Colors.grey
                   *//* image: DecorationImage(image: AssetImage(
                        "assets/image/appBg.png"
                    ),
                        fit: BoxFit.fill)*//*
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top+10, left: 0, right: 0,
            child: Text(
              'profile'.tr, textAlign: TextAlign.center,
              style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.black),
            ),
          ),

          backButton ? Positioned(
            top: MediaQuery.of(context).padding.top, left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).cardColor, size: 20),
              onPressed: () => Get.back(),
            ),
          ) : SizedBox(),

          Positioned(
            top: 0, left: 0, right: 0,
            child: circularImage,
          ),

        ]),*/

        SingleChildScrollView(
          child: Column(
            children: [
              circularImage,
              mainWidget,
            ],
          ),
        ),

      ]),
    );
  }
}
