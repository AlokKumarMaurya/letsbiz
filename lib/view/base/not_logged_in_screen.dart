import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_button.dart';

class NotLoggedInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: Get.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/appBg.png"), fit: BoxFit.fill)),
        alignment: Alignment.center,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            Images.guest,
            scale: 10,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            'sorry'.tr,
            style: robotoBold.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.023,
                color: Theme.of(context).primaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Text(
            'you_are_not_logged_in'.tr,
            style: robotoRegular.copyWith(
                fontSize: MediaQuery.of(context).size.height * 0.0175,
                color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          SizedBox(
            width: 200,
            child: CustomButton(
                buttonText: 'login_to_continue'.tr,
                height: 50,
                onPressed: () {
                  Get.toNamed(RouteHelper.getSignInRoute(RouteHelper.main));
                }),
          ),
          SizedBox(height: Get.height/5,)
        ]),
      ),
    );
  }
}
