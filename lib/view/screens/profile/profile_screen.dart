import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/confirmation_dialog.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/menu_drawer.dart';
import 'package:sixam_mart/view/base/web_menu_bar.dart';
import 'package:sixam_mart/view/screens/profile/widget/profile_bg_widget.dart';
import 'package:sixam_mart/view/screens/profile/widget/profile_button.dart';
import 'package:sixam_mart/view/screens/profile/widget/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    super.initState();

    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool _showWalletCard =
        Get.find<SplashController>().configModel.customerWalletStatus == 1 ||
            Get.find<SplashController>().configModel.loyaltyPointStatus == 1;

    return Scaffold(
      appBar: ResponsiveHelper.isDesktop(context)
          ? WebMenuBar()
          : AppBar(
              automaticallyImplyLeading: true,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                onPressed: () => Get.back(),
              ),
              elevation: 0,
              title: Text(
                "Profile",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
      //endDrawer: MenuDrawer(),
      backgroundColor: Colors.white,
      body: GetBuilder<UserController>(builder: (userController) {
        return (_isLoggedIn && userController.userInfoModel == null)
            ? Center(child: CircularProgressIndicator())
            : ProfileBgWidget(
                backButton: true,
                circularImage: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        width: 2, color: Colors.white,),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: ClipOval(
                      child: CustomImage(
                    image:
                        '${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}'
                        '/${(userController.userInfoModel != null && _isLoggedIn) ? userController.userInfoModel.image : ''}',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  )),
                ),
                mainWidget: Center(
                    child: Container(
                  width: Dimensions.WEB_MAX_WIDTH,
                  /*height: context.height,*/
                  decoration: BoxDecoration(color: Colors.white
                      /*image: DecorationImage(image: AssetImage(
                "assets/image/appBg.png"
              ),
              fit: BoxFit.fill)*/
                      ),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(children: [
                    Text(
                      _isLoggedIn
                          ? '${userController.userInfoModel.fName} ${userController.userInfoModel.lName}'
                          : 'guest'.tr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                    SizedBox(height: 30),

                    _isLoggedIn
                        ? Row(children: [
                            ProfileCard(
                                title: 'since_joining'.tr,
                                data:
                                    '${userController.userInfoModel.memberSinceDays} ${'days'.tr}'),
                            SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                            ProfileCard(
                                title: 'total_order'.tr,
                                data: userController.userInfoModel.orderCount
                                    .toString()),
                          ])
                        : SizedBox(),

                    SizedBox(
                        height: _showWalletCard
                            ? Dimensions.PADDING_SIZE_SMALL
                            : 0),
                    (_showWalletCard && _isLoggedIn)
                        ? Row(children: [
                            Get.find<SplashController>()
                                        .configModel
                                        .customerWalletStatus ==
                                    1
                                ? ProfileCard(
                                    title: 'wallet_amount'.tr,
                                    data: PriceConverter.convertPrice(
                                        userController
                                            .userInfoModel.walletBalance),
                                  )
                                : SizedBox.shrink(),
                            SizedBox(
                                width: Get.find<SplashController>()
                                                .configModel
                                                .customerWalletStatus ==
                                            1 &&
                                        Get.find<SplashController>()
                                                .configModel
                                                .loyaltyPointStatus ==
                                            1
                                    ? Dimensions.PADDING_SIZE_SMALL
                                    : 0.0),
                            Get.find<SplashController>()
                                        .configModel
                                        .loyaltyPointStatus ==
                                    1
                                ? ProfileCard(
                                    title: 'loyalty_points'.tr,
                                    data: userController
                                                .userInfoModel.loyaltyPoint !=
                                            null
                                        ? userController
                                            .userInfoModel.loyaltyPoint
                                            .toString()
                                        : '0',
                                  )
                                : SizedBox.shrink(),
                          ])
                        : SizedBox(),

                    SizedBox(height: _isLoggedIn ? 30 : 0),

                    /* ProfileButton(icon: Icons.dark_mode, title: 'dark_mode'.tr, isButtonActive: Get.isDarkMode, onTap: () {
                Get.find<ThemeController>().toggleTheme();
              }),*/
                    SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                    _isLoggedIn
                        ? GetBuilder<AuthController>(builder: (authController) {
                            return ProfileButton(
                              icon: Icons.notifications,
                              title: 'notification'.tr,
                              isButtonActive: authController.notification,
                              onTap: () {
                                authController.setNotificationActive(
                                    !authController.notification);
                              },
                            );
                          })
                        : SizedBox(),
                    SizedBox(
                        height:
                            _isLoggedIn ? Dimensions.PADDING_SIZE_SMALL : 0),

                    _isLoggedIn
                        ? userController.userInfoModel.socialId == null
                            ? ProfileButton(
                                icon: Icons.lock,
                                title: 'change_password'.tr,
                                onTap: () {
                                  Get.toNamed(RouteHelper.getResetPasswordRoute(
                                      '', '', 'password-change'));
                                })
                            : SizedBox()
                        : SizedBox(),
                    SizedBox(
                        height: _isLoggedIn
                            ? userController.userInfoModel.socialId == null
                                ? Dimensions.PADDING_SIZE_SMALL
                                : 0
                            : 0),

                    ProfileButton(
                        icon: Icons.edit,
                        title: 'edit_profile'.tr,
                        onTap: () {
                          Get.toNamed(RouteHelper.getUpdateProfileRoute());
                        }),
                    SizedBox(
                        height: _isLoggedIn
                            ? Dimensions.PADDING_SIZE_SMALL
                            : Dimensions.PADDING_SIZE_LARGE),
                    ProfileButton(
                        icon: Icons.local_offer_outlined,
                        title: 'coupon'.tr,
                        onTap: () => Get.toNamed(RouteHelper.getCouponRoute())),
                    SizedBox(
                        height: _isLoggedIn
                            ? Dimensions.PADDING_SIZE_SMALL
                            : Dimensions.PADDING_SIZE_LARGE),

                    ProfileButton(
                        icon: Icons.support_agent_outlined,
                        title: 'help_support'.tr,
                        onTap: () =>
                            Get.toNamed(RouteHelper.getSupportRoute())),
                    SizedBox(
                        height: _isLoggedIn
                            ? Dimensions.PADDING_SIZE_SMALL
                            : Dimensions.PADDING_SIZE_LARGE),
                    ProfileButton(
                        icon: Icons.person_add_alt_outlined,
                        title: 'about_us'.tr,
                        onTap: () =>
                            Get.toNamed(RouteHelper.getHtmlRoute('about-us'))),
                    SizedBox(
                        height: _isLoggedIn
                            ? Dimensions.PADDING_SIZE_SMALL
                            : Dimensions.PADDING_SIZE_LARGE),
                    ProfileButton(
                        icon: Icons.chat,
                        title: 'live_chat'.tr,
                        onTap: () =>
                            Get.toNamed(RouteHelper.getConversationRoute())),
                    SizedBox(
                        height: _isLoggedIn
                            ? Dimensions.PADDING_SIZE_SMALL
                            : Dimensions.PADDING_SIZE_LARGE),

                    (Get.find<SplashController>()
                                .configModel
                                .shippingPolicyStatus ==
                            1)
                        ? ProfileButton(
                            icon: Icons.policy,
                            title: 'shipping_policy'.tr,
                            onTap: () => Get.toNamed(
                                RouteHelper.getHtmlRoute('shipping-policy')))
                        : const SizedBox(),
                    (Get.find<SplashController>()
                                .configModel
                                .shippingPolicyStatus ==
                            1)
                        ? SizedBox(
                            height: _isLoggedIn
                                ? Dimensions.PADDING_SIZE_SMALL
                                : Dimensions.PADDING_SIZE_LARGE)
                        : const SizedBox(),

                    (Get.find<SplashController>()
                                .configModel
                                .refEarningStatus ==
                            1)
                        ? ProfileButton(
                            icon: Icons.share,
                            title: 'refer_and_earn'.tr,
                            onTap: () =>
                                Get.toNamed(RouteHelper.getReferAndEarnRoute()))
                        : const SizedBox(),
                    (Get.find<SplashController>()
                                .configModel
                                .refEarningStatus ==
                            1)
                        ? SizedBox(
                            height: _isLoggedIn
                                ? Dimensions.PADDING_SIZE_SMALL
                                : Dimensions.PADDING_SIZE_LARGE)
                        : const SizedBox(),

                    (Get.find<SplashController>()
                                .configModel
                                .customerWalletStatus ==
                            1)
                        ? ProfileButton(
                            icon: Icons.wallet,
                            title: 'wallet'.tr,
                            onTap: () =>
                                Get.toNamed((RouteHelper.getWalletRoute(true))))
                        : const SizedBox(),
                    (Get.find<SplashController>()
                                .configModel
                                .customerWalletStatus ==
                            1)
                        ? SizedBox(
                            height: _isLoggedIn
                                ? Dimensions.PADDING_SIZE_SMALL
                                : Dimensions.PADDING_SIZE_LARGE)
                        : const SizedBox(),

                    (Get.find<SplashController>()
                                .configModel
                                .loyaltyPointStatus ==
                            1)
                        ? ProfileButton(
                            icon: Icons.loyalty,
                            title: 'loyalty_points'.tr,
                            onTap: () =>
                                Get.toNamed(RouteHelper.getWalletRoute(false)))
                        : const SizedBox(),
                    (Get.find<SplashController>()
                                .configModel
                                .loyaltyPointStatus ==
                            1)
                        ? SizedBox(
                            height: _isLoggedIn
                                ? Dimensions.PADDING_SIZE_SMALL
                                : Dimensions.PADDING_SIZE_LARGE)
                        : const SizedBox(),

                    (Get.find<SplashController>()
                                .configModel
                                .toggleStoreRegistration &&
                            !ResponsiveHelper.isDesktop(context))
                        ? ProfileButton(
                            icon: Icons.restaurant_menu,
                            title: Get.find<SplashController>()
                                    .configModel
                                    .moduleConfig
                                    .module
                                    .showRestaurantText
                                ? "Join as seller"
                                : 'join_as_a_store'.tr,
                            onTap: () => Get.toNamed(
                                RouteHelper.getRestaurantRegistrationRoute()),
                          )
                        : const SizedBox(),
                    (Get.find<SplashController>()
                                .configModel
                                .toggleStoreRegistration &&
                            !ResponsiveHelper.isDesktop(context))
                        ? SizedBox(
                            height: _isLoggedIn
                                ? Dimensions.PADDING_SIZE_SMALL
                                : Dimensions.PADDING_SIZE_LARGE)
                        : const SizedBox(),

                    ProfileButton(
                        icon: Icons.logout,
                        title: _isLoggedIn ? 'logout'.tr : 'sign_in'.tr,
                        onTap: () => Get.toNamed('')),
                    SizedBox(
                        height: _isLoggedIn
                            ? Dimensions.PADDING_SIZE_SMALL
                            : Dimensions.PADDING_SIZE_LARGE),

                    _isLoggedIn
                        ? ProfileButton(
                            icon: Icons.delete,
                            title: 'delete_account'.tr,
                            onTap: () {
                              Get.dialog(
                                  ConfirmationDialog(
                                    icon: Images.support,
                                    title: 'are_you_sure_to_delete_account'.tr,
                                    description:
                                        'it_will_remove_your_all_information'
                                            .tr,
                                    isLogOut: true,
                                    onYesPressed: () =>
                                        userController.removeUser(),
                                  ),
                                  useSafeArea: false);
                            },
                          )
                        : SizedBox(),

                    //add all button here

                    SizedBox(
                        height:
                            _isLoggedIn ? Dimensions.PADDING_SIZE_LARGE : 0),

                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('${'version'.tr}:',
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall)),
                      SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                      Text(AppConstants.APP_VERSION.toString(),
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall)),
                    ]),
                  ]),
                )),
              );
      }),
    );
  }
}
