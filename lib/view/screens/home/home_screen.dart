import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/banner_controller.dart';
import 'package:sixam_mart/controller/campaign_controller.dart';
import 'package:sixam_mart/controller/category_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/notification_controller.dart';
import 'package:sixam_mart/controller/parcel_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/store_controller.dart';
import 'package:sixam_mart/controller/user_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/web_menu_bar.dart';
import 'package:sixam_mart/view/screens/home/theme1/theme1_home_screen.dart';
import 'package:sixam_mart/view/screens/home/web_home_screen.dart';
import 'package:sixam_mart/view/screens/home/widget/banner_view.dart';
import 'package:sixam_mart/view/screens/home/widget/category_view.dart';
import 'package:sixam_mart/view/screens/home/widget/item_campaign_view.dart';
import 'package:sixam_mart/view/screens/home/widget/module_view.dart';
import 'package:sixam_mart/view/screens/home/widget/popular_item_view.dart';
import 'package:sixam_mart/view/screens/parcel/parcel_category_screen.dart';

class HomeScreen extends StatefulWidget {
  static Future<void> loadData(bool reload) async {
    if (Get.find<SplashController>().module != null &&
        !Get.find<SplashController>()
            .configModel
            .moduleConfig
            .module
            .isParcel) {
      Get.find<LocationController>().syncZoneData();
      Get.find<BannerController>().getBannerList(reload);
      Get.find<CategoryController>().getCategoryList(reload);
      Get.find<StoreController>().getPopularStoreList(reload, 'all', false);
      Get.find<CampaignController>().getItemCampaignList(
          reload,
          Get.find<SplashController>().module.moduleType,
          Get.find<SplashController>().module.id);
      Get.find<ItemController>().getPopularItemList(reload, 'all', false);
      Get.find<StoreController>().getLatestStoreList(reload, 'all', false);
      Get.find<ItemController>().getReviewedItemList(reload, 'all', false);
      Get.find<StoreController>().getStoreList(1, reload);
    }
    if (Get.find<AuthController>().isLoggedIn()) {
      Get.find<UserController>().getUserInfo();
      Get.find<NotificationController>().getNotificationList(reload);
    }
    Get.find<SplashController>().getModules();
    if (Get.find<SplashController>().module == null &&
        Get.find<SplashController>().configModel.module == null) {
      Get.find<BannerController>().getFeaturedBanner();
      Get.find<StoreController>().getFeaturedStoreList();
      if (Get.find<AuthController>().isLoggedIn()) {
        Get.find<LocationController>().getAddressList();
      }
    }
    if (Get.find<SplashController>().module != null &&
        Get.find<SplashController>().configModel.moduleConfig.module.isParcel) {
      Get.find<ParcelController>().getParcelCategoryList();
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    super.initState();
    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    HomeScreen.loadData(false);
    if (!ResponsiveHelper.isWeb()) {
      Get.find<LocationController>().getZone(
          Get.find<LocationController>().getUserAddress().latitude,
          Get.find<LocationController>().getUserAddress().longitude,
          false,
          updateInAddress: true);
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Breakfast time';
    }
    if (hour < 17) {
      return '''It's lunch time''';
    }
    return 'Dinner time';
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      bool _showMobileModule = !ResponsiveHelper.isDesktop(context) &&
          splashController.module == null &&
          splashController.configModel.module == null;
      bool _isParcel = splashController.module != null &&
          splashController.configModel.moduleConfig.module.isParcel;

      return Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? WebMenuBar() : null,
        // endDrawer: MenuDrawer(),
        /* backgroundColor: ResponsiveHelper.isDesktop(context) ? Theme.of(context).cardColor : splashController.module == null
            ? Theme.of(context).backgroundColor : null,*/
        body: Container(
          color: Colors.white,
          child: _isParcel
              ? ParcelCategoryScreen()
              : SafeArea(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      if (Get.find<SplashController>().module != null) {
                        await Get.find<LocationController>().syncZoneData();
                        await Get.find<BannerController>().getBannerList(true);
                        await Get.find<CategoryController>()
                            .getCategoryList(true);
                        await Get.find<StoreController>()
                            .getPopularStoreList(true, 'all', false);
                        await Get.find<CampaignController>()
                            .getItemCampaignList(
                                true,
                                Get.find<SplashController>().module.moduleType,
                                Get.find<SplashController>().module.id);
                        await Get.find<ItemController>()
                            .getPopularItemList(true, 'all', false);
                        await Get.find<StoreController>()
                            .getLatestStoreList(true, 'all', false);
                        await Get.find<ItemController>()
                            .getReviewedItemList(true, 'all', false);
                        await Get.find<StoreController>().getStoreList(1, true);
                        if (Get.find<AuthController>().isLoggedIn()) {
                          await Get.find<UserController>().getUserInfo();
                          await Get.find<NotificationController>()
                              .getNotificationList(true);
                        }
                      } else {
                        await Get.find<BannerController>().getFeaturedBanner();
                        await Get.find<SplashController>().getModules();
                        if (Get.find<AuthController>().isLoggedIn()) {
                          await Get.find<LocationController>().getAddressList();
                        }
                        await Get.find<StoreController>()
                            .getFeaturedStoreList();
                      }
                    },
                    child: ResponsiveHelper.isDesktop(context)
                        ? WebHomeScreen(
                            scrollController: _scrollController,
                          )
                        : (Get.find<SplashController>().module != null &&
                                Get.find<SplashController>().module.themeId ==
                                    2)
                            ? Theme1HomeScreen(
                                scrollController: _scrollController,
                                splashController: splashController,
                                showMobileModule: _showMobileModule,
                              )
                            : CustomScrollView(
                                controller: _scrollController,
                                physics: AlwaysScrollableScrollPhysics(),
                                slivers: [
                                  // App Bar
                                  /* SliverAppBar(
                    stretch: true,
                    floating: true, elevation: 0, automaticallyImplyLeading: false,
                    backgroundColor: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Colors.transparent,
                    leadingWidth: 0,
                    titleSpacing: 0,
                    title: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      width: Get.width,
                      decoration: BoxDecoration(
                          border:BorderDirectional(bottom: BorderSide(color: Colors.black))
                      ),
                      child: Row(children: [
                        (splashController.module != null && splashController.configModel.module == null) ? InkWell(
                          onTap: () => splashController.removeModule(),
                          child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)//Image.asset(Images.module_icon, height: 22, width: 22, color: Colors.yellow),
                        ) : SizedBox(),
                        SizedBox(width: (splashController.module != null && splashController.configModel.module
                            == null) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0),
                        Expanded(child: InkWell(
                          onTap: () => Get.toNamed(RouteHelper.getAccessLocationRoute('home')),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: Dimensions.PADDING_SIZE_SMALL,
                            ),
                            child: GetBuilder<LocationController>(builder: (locationController) {
                              return Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset("assets/image/navigator.png",height: 20,width: 20,color: Colors.black,),
                                    Icon(
                                      locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                                          : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                                      size: 20, color: Theme.of(context).textTheme.bodyText1.color,
                                    ),SizedBox(width: 10),
                                      Flexible(
                                        child: Text(
                                          locationController.getUserAddress().address,
                                          style: GoogleFonts.montserrat(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500
                                              )
                                          ),
                                          maxLines: 1, overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_down, color: Colors.black),
                                    ],
                                  ),
                                ],
                              );
                            }),
                          ),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: InkWell(
                            child: GetBuilder<NotificationController>(builder: (notificationController) {
                              return Stack(children:[
                                Image.asset("assets/image/notification.png",height: 25,color: Colors.black,),
                                notificationController.hasNotification ? Positioned(top: 0, right: 0, child: Container(
                                  height: 10, width: 10, decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor, shape: BoxShape.circle,
                                  border: Border.all(width: 1, color: Colors.black),
                                ),
                                )) : SizedBox(),
                              ]);
                            }),
                            onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
                          ),
                        ),
                      ]),
                    ),
                    //actions: [SizedBox()],
                  ),
                  SliverAppBar(
                                      collapsedHeight: 170,
                                      stretch: true,
                                      floating: true,
                                      elevation: 0,
                                      automaticallyImplyLeading: false,
                                      backgroundColor:
                                          ResponsiveHelper.isDesktop(context)
                                              ? Colors.transparent
                                              : Colors.transparent,
                                      leadingWidth: 0,
                                      titleSpacing: 0,
                                      title: Container(
                                        height: 200,
                                          alignment: Alignment.bottomCenter,
                                          color: Colors.pink,
                                          child: Row(children: <Widget>[
                                        //removed back ios button in the appBar
                                        (splashController.module != null &&
                                                splashController
                                                        .configModel.module ==
                                                    null)
                                            ? InkWell(
                                                onTap: () => splashController
                                                    .removeModule(),
                                                child: Icon(
                                                  Icons.arrow_back_ios_new,
                                                  color: Colors.black,
                                                ) //Image.asset(Images.module_icon, height: 22, width: 22, color: Colors.yellow),
                                                )
                                            : SizedBox(),
                                        Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          InkWell(
                                            onTap: () => Get.toNamed(RouteHelper
                                                .getAccessLocationRoute(
                                                    'home')),
                                            child: InkWell(
                                              onTap: () => Get.toNamed(
                                                  RouteHelper
                                                      .getAccessLocationRoute(
                                                          'home')),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: Dimensions
                                                      .PADDING_SIZE_SMALL,
                                                ),
                                                child: GetBuilder<
                                                        LocationController>(
                                                    builder:
                                                        (locationController) {
                                                  return Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const SizedBox(width: 10,),
                                                     Image.asset(
                                                    "assets/image/navigator.png",
                                                    height: 20,
                                                    width: 20,
                                                    color: Colors.black,
                                                  ),Icon(
                                                locationController
                                                    .getUserAddress()
                                                    .addressType ==
                                                    'home'
                                                    ? Icons.home_filled
                                                    : locationController
                                                    .getUserAddress()
                                                    .addressType ==
                                                    'office'
                                                    ? Icons.work
                                                    : Icons.location_on,
                                                size: 30,
                                                color: Colors.red,
                                              ),Image.asset(
                                                        "assets/image/location_icon.png",
                                                        width: 40,
                                                        height: 40,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                              children: <
                                                                  Widget>[
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                GetBuilder<
                                                                        UserController>(
                                                                    builder:
                                                                        (userController) {
                                                                  return userController
                                                                              .userInfoModel !=
                                                                          null
                                                                      ? Text(
                                                                          _isLoggedIn
                                                                              ? '${userController.userInfoModel.fName} ${userController.userInfoModel.lName}'
                                                                              : 'guest'
                                                                                  .tr,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 18))
                                                                      : const SizedBox();
                                                                }),

                                                                SizedBox(
                                                                    width: 5),
                                                                //onTap: () => Get.toNamed(RouteHelper.getAccessLocationRoute('home'))

                                                                SizedBox(
                                                                    width: 5),
                                                                GetBuilder<
                                                                    GpsController>(
                                                                    init:
                                                                        GpsController(),
                                                                    builder:
                                                                        (gpsController) {
                                                                      return InkWell(
                                                                        onTap: () async =>
                                                                            AppSettings.openLocationSettings(),
                                                                        child: Obx(() =>
                                                                            Container(
                                                                              padding: const EdgeInsets.all(5),
                                                                              decoration: BoxDecoration(color: gpsController.isLocationEnabled.value ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(8)),
                                                                              child: Text(
                                                                                gpsController.isLocationEnabled.value ? "GPS ON" : "GPS is off",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12,
                                                                                ),
                                                                              ),
                                                                            )),
                                                                      );
                                                                    })
                                                              ]),
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                  width: 10),
                                                              SizedBox(
                                                                width:
                                                                    Get.width -
                                                                        90,
                                                                child: Text(
                                                                  locationController
                                                                      .getUserAddress()
                                                                      .address,
                                                                  style: GoogleFonts.montserrat(
                                                                      textStyle: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w500)),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),

                                                      //profile image here

                                                      InkWell(
                                                onTap: () => null,
                                                child: GetBuilder<
                                                    UserController>(
                                                    builder:
                                                        (userController) {
                                                      return (_isLoggedIn &&
                                                          userController
                                                              .userInfoModel ==
                                                              null)
                                                          ? Center(
                                                          child:
                                                          CircularProgressIndicator())
                                                          : Container(
                                                        decoration:
                                                        BoxDecoration(
                                                          // color: Color(0xff1167b1),
                                                          image: DecorationImage(
                                                              image: AssetImage(
                                                                  "assets/image/appBg.png"),
                                                              fit: BoxFit
                                                                  .fill),
                                                          border: Border.all(
                                                              width: 2,
                                                              color: Theme
                                                                  .of(
                                                                  context)
                                                                  .cardColor),
                                                          shape: BoxShape
                                                              .circle,
                                                        ),
                                                        alignment:
                                                        Alignment
                                                            .center,
                                                        child: ClipOval(
                                                            child: const SizedBox()
                                                         CustomImage(
                                                              image:
                                                              '${Get
                                                                  .find<
                                                                  SplashController>()
                                                                  .configModel
                                                                  .baseUrls
                                                                  .customerImageUrl}'
                                                                  '/${(userController
                                                                  .userInfoModel !=
                                                                  null &&
                                                                  _isLoggedIn)
                                                                  ? userController
                                                                  .userInfoModel
                                                                  .image
                                                                  : ''}',
                                                              height: 40,
                                                              width: 40,
                                                              fit: BoxFit
                                                                  .cover,
                                                            )),
                                                      );
                                                    }),
                                              )
                                                    ],
                                                  );
                                                }),
                                              ),
                                            ),
                                          )
                                        ])
                                      ]))
                                      //actions: [SizedBox()],
                                      ),*/

                                  SliverToBoxAdapter(
                                      child: _showMobileModule
                                          ? Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                    Colors.green
                                                        .withOpacity(0.3),
                                                    Colors.white
                                                  ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter)),
                                              height:
                                                  _showMobileModule ? 200 : 80,
                                              //color: Colors.pink,
                                              child: Column(children: <Widget>[
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: Dimensions
                                                        .PADDING_SIZE_SMALL,
                                                  ),
                                                  child: GetBuilder<
                                                          LocationController>(
                                                      builder:
                                                          (locationController) {
                                                    return Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        /* Image.asset(
                                              "assets/image/navigator.png",
                                              height: 20,
                                              width: 20,
                                              color: Colors.black,
                                            ),*/
                                                        /*Icon(
                                            locationController
                                              .getUserAddress()
                                              .addressType ==
                                              'home'
                                              ? Icons.home_filled
                                              : locationController
                                              .getUserAddress()
                                              .addressType ==
                                              'office'
                                              ? Icons.work
                                              : Icons.location_on,
                                            size: 30,
                                            color: Colors.red,
                                            ),*/
                                                        /* Image.asset(
                                                  "assets/image/location_icon.png",
                                                  width: 40,
                                                  height: 40,
                                                ),*/
                                                        Container(
                                                          width: Get.width*0.95,
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: <
                                                                  Widget>[
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                  children: [
                                                                    GetBuilder<UserController>(builder:
                                                                        (userController) {
                                                                      //${userController.userInfoModel.lName}
                                                                      return userController.userInfoModel != null
                                                                          ? Row(
                                                                              children: [
                                                                                Text(_isLoggedIn ? 'Hi , ${userController.userInfoModel.fName} ' : 'guest'.tr, style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18))),
                                                                                const SizedBox(
                                                                                  width: 5,
                                                                                ),
                                                                                Image.asset(
                                                                                  "assets/image/waving_hand.png",
                                                                                  height: 30,
                                                                                  width: 30,
                                                                                )
                                                                              ],
                                                                            )
                                                                          : const SizedBox();
                                                                    }),
                                                                    Text(
                                                                      "Let's order locally",
                                                                      //greeting(),
                                                                      style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    )
                                                                  ],
                                                                ),


                                                                Expanded(
                                                                  child: Container(
                                                                    alignment: Alignment.centerRight,
                                                                    child: Text(
                                                                      "Deliver in \n8 minute",
                                                                      style: GoogleFonts.poppins(
                                                                          textStyle: TextStyle(
                                                                            color:
                                                                            Colors.black,
                                                                            fontSize:
                                                                            18,
                                                                            fontWeight:
                                                                            FontWeight.w700,
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ),

                                                                //onTap: () => Get.toNamed(RouteHelper.getAccessLocationRoute('home'))

                                                                /* Container(
                                                              width: Get.width /
                                                                      2 -
                                                                  10,
                                                              alignment:
                                                                  Alignment
                                                                      .centerRight,
                                                              child: GetBuilder<
                                                                      GpsController>(
                                                                  init:
                                                                      GpsController(),
                                                                  builder:
                                                                      (gpsController) {
                                                                    return InkWell(
                                                                      onTap: () async => AppSettings.openLocationSettings(),
                                                                      child: Obx(() => Container(
                                                                            padding: const EdgeInsets.all(5),
                                                                            decoration: BoxDecoration(color: gpsController.isLocationEnabled.value ? Colors.green : Colors.red, borderRadius: BorderRadius.circular(8)),
                                                                            child: Text(
                                                                              gpsController.isLocationEnabled.value ? "GPS ON" : "GPS is off",
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    );
                                                                  }),
                                                            )*/
                                                              ]),
                                                        ),

                                                        //profile image here

                                                        /* InkWell(
                                            onTap: () => null,
                                            child: GetBuilder<
                                              UserController>(
                                              builder:
                                                  (userController) {
                                                return (_isLoggedIn &&
                                                    userController
                                                        .userInfoModel ==
                                                        null)
                                                    ? Center(
                                                    child:
                                                    CircularProgressIndicator())
                                                    : Container(
                                                  decoration:
                                                  BoxDecoration(
                                                    // color: Color(0xff1167b1),
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/image/appBg.png"),
                                                        fit: BoxFit
                                                            .fill),
                                                    border: Border.all(
                                                        width: 2,
                                                        color: Theme
                                                            .of(
                                                            context)
                                                            .cardColor),
                                                    shape: BoxShape
                                                        .circle,
                                                  ),
                                                  alignment:
                                                  Alignment
                                                      .center,
                                                  child: ClipOval(
                                                      child: const SizedBox()
                                                    */ /*CustomImage(
                                                        image:
                                                        '${Get
                                                            .find<
                                                            SplashController>()
                                                            .configModel
                                                            .baseUrls
                                                            .customerImageUrl}'
                                                            '/${(userController
                                                            .userInfoModel !=
                                                            null &&
                                                            _isLoggedIn)
                                                            ? userController
                                                            .userInfoModel
                                                            .image
                                                            : ''}',
                                                        height: 40,
                                                        width: 40,
                                                        fit: BoxFit
                                                            .cover,
                                                      )*/ /*),
                                                );
                                              }),
                                            )*/
                                                      ],
                                                    );
                                                  }),
                                                ),
                                                _showMobileModule
                                                    ? const SizedBox(
                                                        height: 10,
                                                      )
                                                    : const SizedBox(),
                                                _showMobileModule
                                                    ? Container(
                                                        height: 70,
                                                        width: Get.width,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15,
                                                                vertical: 15),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15),
                                                        decoration: BoxDecoration(
                                                            image: DecorationImage(
                                                                image: AssetImage(
                                                                    "assets/image/google_map_bg.jpeg"),
                                                                fit: BoxFit
                                                                    .cover,
                                                                opacity: 0.4),
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                                "assets/image/location_icon.png"),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "Your delivery address",
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      //Colors.black54,
                                                                      fontSize: 16,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                                GetBuilder<
                                                                        LocationController>(
                                                                    builder:
                                                                        (locationController) {
                                                                  return InkWell(
                                                                    onTap: () =>
                                                                        Get.toNamed(
                                                                            RouteHelper.getAccessLocationRoute('home')),
                                                                    child:
                                                                        SizedBox(
                                                                      width: Get
                                                                              .width -
                                                                          150,
                                                                      child:
                                                                          Text(
                                                                        locationController
                                                                            .getUserAddress()
                                                                            .address,
                                                                        style: GoogleFonts.montserrat(
                                                                            textStyle: TextStyle(
                                                                                color: Colors.black,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.w500)),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                  );
                                                                }),
                                                              ],
                                                            ),
                                                            Expanded(
                                                                child: Icon(Icons
                                                                    .arrow_forward_ios))
                                                          ],
                                                        ),
                                                      )
                                                    : const SizedBox()
                                              ]))
                                          : const SizedBox()),
                                  // Search Button
                                  !_showMobileModule
                                      ? SliverToBoxAdapter(
                                          //pinned: true,
                                          child: Container(
                                              child: Center(
                                                  child: Container(
                                            //margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                                            height: 55,
                                            width: Get.width,
                                            margin: EdgeInsets.only(
                                                top: 15, left: 15, right: 15),
                                            //  color: Theme.of(context).backgroundColor,
                                            //padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                                            child: InkWell(
                                              onTap: () => Get.toNamed(
                                                  RouteHelper.getSearchRoute()),
                                              child: Container(
                                                height: 80,
                                                width: Get.width,
                                                /*padding: EdgeInsets.symmetric(
                                                    horizontal: 15),*/
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade200,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  //boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(children: [
                                                    Icon(
                                                      Icons.search,
                                                      size: 25,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                    SizedBox(
                                                        width: Dimensions
                                                            .PADDING_SIZE_EXTRA_SMALL),
                                                    SizedBox(
                                                      width: Get.width*0.8,
                                                      child: Text(
                                                        Get.find<SplashController>()
                                                            .configModel
                                                            .moduleConfig
                                                            .module
                                                            .showRestaurantText
                                                        ? 'search_food_or_restaurant'
                                                            .tr
                                                        : 'search_item_or_store'
                                                            .tr,
                                                        overflow: TextOverflow.ellipsis,
                                                        style:
                                                        GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      color: Theme.of(context)
                                                          .hintColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ),
                                          ))),
                                        )
                                      : SliverToBoxAdapter(),

                                  SliverToBoxAdapter(
                                    child: Center(
                                        child: Container(
                                      padding: EdgeInsets.only(
                                          bottom: 50, left: 5, right: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        /*image: DecorationImage(
                                              image: AssetImage(
                                                Images.app_bg,
                                              ),
                                              scale: 1,
                                              fit: BoxFit.fill)*/
                                      ),
                                      width: Dimensions.WEB_MAX_WIDTH,
                                      child: !_showMobileModule
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                  BannerView(isFeatured: false),
                                                  CategoryView(),
                                                  /* PopularStoreView(
                                    isPopular: true,
                                    isFeatured: false),*/
                                                  ItemCampaignView(),
                                                  PopularItemView(
                                                      isPopular: true),
                                                  /*PopularStoreView(
                                    isPopular: false,
                                    isFeatured: false),*/
                                                  PopularItemView(
                                                      isPopular: false),
                                                  /*Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(
                                      10, 15, 0, 5),
                                  child: Row(children: [
                                    Expanded(
                                        child: Text(
                                          Get
                                              .find<SplashController>()
                                              .configModel
                                              .moduleConfig
                                              .module
                                              .showRestaurantText
                                              ? 'all_restaurants'
                                              .tr
                                              : 'all_stores'.tr,
                                          style: robotoMedium.copyWith(
                                              fontSize: Dimensions
                                                  .fontSizeLarge),
                                        )),
                                    FilterView(),
                                  ]),
                                ),*/
                                                  /* GetBuilder<StoreController>(
                                    builder:
                                        (storeController) {
                                      return PaginatedListView(
                                        scrollController:
                                        _scrollController,
                                        totalSize: storeController
                                            .storeModel !=
                                            null
                                            ? storeController
                                            .storeModel
                                            .totalSize
                                            : null,
                                        offset: storeController
                                            .storeModel !=
                                            null
                                            ? storeController
                                            .storeModel.offset
                                            : null,
                                        onPaginate: (int
                                        offset) async =>
                                        await storeController
                                            .getStoreList(
                                            offset,
                                            false),
                                        itemView: ItemsView(
                                          isStore: true,
                                          items: null,
                                          stores: storeController
                                              .storeModel !=
                                              null
                                              ? storeController
                                              .storeModel
                                              .stores
                                              : null,
                                          padding: EdgeInsets
                                              .symmetric(
                                            horizontal: ResponsiveHelper
                                                .isDesktop(
                                                context)
                                                ? Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL
                                                : Dimensions
                                                .PADDING_SIZE_SMALL,
                                            vertical: ResponsiveHelper
                                                .isDesktop(
                                                context)
                                                ? Dimensions
                                                .PADDING_SIZE_EXTRA_SMALL
                                                : 0,
                                          ),
                                        ),
                                      );
                                    }),*/
                                                  SizedBox(
                                                      height: 30, width: 100)
                                                ])
                                          : ModuleView(
                                              splashController:
                                                  splashController),
                                    )),
                                  ),
                                ],
                              ),
                  ),
                ),
        ),
      );
    });
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;

  SliverDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 50 ||
        oldDelegate.minExtent != 50 ||
        child != oldDelegate.child;
  }
}
