import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/screens/home/home_screen.dart';
import 'package:sixam_mart/view/screens/home/theme1/banner_view1.dart';
import 'package:sixam_mart/view/screens/home/theme1/best_reviewed_item_view.dart';
import 'package:sixam_mart/view/screens/home/theme1/category_view1.dart';
import 'package:sixam_mart/view/screens/home/theme1/item_campaign_view1.dart';
import 'package:sixam_mart/view/screens/home/theme1/popular_item_view1.dart';
import 'package:sixam_mart/view/screens/home/widget/module_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controller/auth_controller.dart';
import '../../../../controller/gpsController.dart';
import '../../../../controller/user_controller.dart';
class Theme1HomeScreen extends StatefulWidget {
  final ScrollController scrollController;
  final SplashController splashController;
  final bool showMobileModule;
   const Theme1HomeScreen({@required this.scrollController, @required this.splashController, @required this.showMobileModule});

  @override
  State<Theme1HomeScreen> createState() => _Theme1HomeScreenState();
}

class _Theme1HomeScreenState extends State<Theme1HomeScreen> {
  bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();

  @override
  void initState() {
    if (_isLoggedIn && Get.find<UserController>().userInfoModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    // TODO: implement initState
    super.initState();
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
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: widget.scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      slivers: [


        /*SliverAppBar(
          titleSpacing: 0,
          floating: true, elevation: 0, automaticallyImplyLeading: false,
          backgroundColor: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Colors.transparent,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border:BorderDirectional(bottom: BorderSide(color: Colors.black))
            ),
            width: Get.width, height: 50,
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
                    horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_SMALL : 0,
                  ),
                  child: GetBuilder<LocationController>(builder: (locationController) {
                    return Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        */
        /* Row(
                                  children: [
                                    Text("Lets",style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500
                                    ),),
                                    Text("Biz",style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700
                                    ),),
                                  ],
                                ),*/
        /*
                        Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset("assets/image/navigator.png",height: 20,width: 20,color: Colors.black,),
                            */
        /*Icon(
                                      locationController.getUserAddress().addressType == 'home' ? Icons.home_filled
                                          : locationController.getUserAddress().addressType == 'office' ? Icons.work : Icons.location_on,
                                      size: 20, color: Theme.of(context).textTheme.bodyText1.color,
                                    ),*/
        /*
                            SizedBox(width: 10),
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
                      //Icon(Icons.notifications, size: 25, color: Theme.of(context).textTheme.bodyText1.color),
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
        ),*/








        SliverToBoxAdapter(
            child: !widget.showMobileModule
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
                !widget.showMobileModule  ? 200 : 80,
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
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: <
                                          Widget>[
                                        Container(
                                          width: (Get.width /
                                              2) -
                                              10,
                                          alignment:
                                          Alignment
                                              .centerLeft,
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  GetBuilder<UserController>(builder:
                                                      (userController) {
                                                    return userController.userInfoModel != null ? Text(_isLoggedIn ? '${userController.userInfoModel.fName} ${userController.userInfoModel.lName}' : 'guest'.tr, style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18))) : const SizedBox();
                                                  }),
                                                  Text(
                                                    greeting(),
                                                    style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width:
                                                10,
                                              ),
                                              Image
                                                  .asset(
                                                "assets/image/waving_hand.png",
                                                height:
                                                40,
                                                width:
                                                30,
                                              )
                                            ],
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
                                ],
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
                  !widget.showMobileModule
                      ? const SizedBox(
                    height: 30,
                  )
                      : const SizedBox(),
                  !widget.showMobileModule
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
                        color: Colors.grey
                            .withOpacity(
                            0.1),
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
                                  color: Colors.black,//Colors.black54,
                                  fontSize:
                                  16,
                                  fontWeight:
                                  FontWeight
                                      .w500),
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
        !widget.showMobileModule ? SliverPersistentHeader(
          pinned: true,
          delegate: SliverDelegate(child: Center(child: Container(
            height: 50, width: Dimensions.WEB_MAX_WIDTH,
            color: Colors.white,
          //  padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            child: InkWell(
              onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(25),
                 // boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
                ),
                child: Row(children: [
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Icon(
                    Icons.search, size: 25,
                    color: Theme.of(context).hintColor,
                  ),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Expanded(child: Text(
                    Get.find<SplashController>().configModel.moduleConfig.module.showRestaurantText
                        ? 'search_food_or_restaurant'.tr : 'search_item_or_store'.tr,
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor,
                    ),
                  )),
                ]),
              ),
            ),
          ))),
        ) : SliverToBoxAdapter(),

        SliverToBoxAdapter(
          child: Center(child: Container(
            decoration: BoxDecoration(
              color:Colors.white,
            ),
            width: Dimensions.WEB_MAX_WIDTH,
            child: !widget.showMobileModule ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

              BannerView1(isFeatured: false),
              CategoryView1(),
              ItemCampaignView1(),
              BestReviewedItemView(),
             // PopularStoreView1(isPopular: true, isFeatured: false),
              PopularItemView1(isPopular: true),
            //  PopularStoreView1(isPopular: false, isFeatured: false),

             /* Padding(
                padding: EdgeInsets.fromLTRB(10, 15, 0, 5),
                child: Row(children: [
                  Expanded(child: Text(
                    Get.find<SplashController>().configModel.moduleConfig.module.showRestaurantText
                        ? 'all_restaurants'.tr : 'all_stores'.tr,
                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
                  )),
                  FilterView(),
                ]),
              ),

              GetBuilder<StoreController>(builder: (storeController) {
                return PaginatedListView(
                  scrollController: widget.scrollController,
                  totalSize: storeController.storeModel != null ? storeController.storeModel.totalSize : null,
                  offset: storeController.storeModel != null ? storeController.storeModel.offset : null,
                  onPaginate: (int offset) async => await storeController.getStoreList(offset, false),
                  itemView: ItemsView(
                    isStore: true, items: null, showTheme1Store: true,
                    stores: storeController.storeModel != null ? storeController.storeModel.stores : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : Dimensions.PADDING_SIZE_SMALL,
                      vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.PADDING_SIZE_EXTRA_SMALL : 0,
                    ),
                  ),
                );
              }),*/
              SizedBox(height: 80,width: 100),
            ]) : ModuleView(splashController: widget.splashController),
          )),
        ),
      ],
    );
  }
}
