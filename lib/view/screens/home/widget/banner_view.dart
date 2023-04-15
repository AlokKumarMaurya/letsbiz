import 'package:carousel_slider/carousel_slider.dart';
import 'package:sixam_mart/controller/banner_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/basic_campaign_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/module_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/data/model/response/zone_response_model.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/screens/store/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BannerView extends StatelessWidget {
  final bool isFeatured;
  BannerView({@required this.isFeatured});

  @override
  Widget build(BuildContext context) {

    return GetBuilder<BannerController>(builder: (bannerController) {
      List<String> bannerList = isFeatured ? bannerController.featuredBannerList : bannerController.bannerImageList;
      List<dynamic> bannerDataList = isFeatured ? bannerController.featuredBannerDataList : bannerController.bannerDataList;

      return (bannerList != null && bannerList.length == 0) ? SizedBox() : Container(
        width: MediaQuery.of(context).size.width,
        height: GetPlatform.isDesktop ? 500 : MediaQuery.of(context).size.width * 0.60,
        padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
        child: bannerList != null ? Stack(
         // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height:GetPlatform.isDesktop ? 500 : MediaQuery.of(context).size.width * 0.60 ,
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  disableCenter: true,
                  viewportFraction: 0.95,
                  autoPlayInterval: Duration(seconds: 7),
                  onPageChanged: (index, reason) {
                    bannerController.setCurrentIndex(index, true);
                  },
                ),
                itemCount: bannerList.length == 0 ? 1 : bannerList.length,
                itemBuilder: (context, index, _) {



                  String _baseUrl = bannerDataList[index] is BasicCampaignModel ? Get.find<SplashController>()
                      .configModel.baseUrls.campaignImageUrl  : Get.find<SplashController>().configModel.baseUrls.bannerImageUrl;
                 // debugPrint("this is the url------$_baseUrl/${bannerList[index]}");

                  return bannerDataList[index] is BasicCampaignModel ?SizedBox():InkWell(
                    onTap: () async {
                      if(bannerDataList[index] is Item) {
                        Item _item = bannerDataList[index];
                        Get.find<ItemController>().navigateToItemPage(_item, context);
                      }else if(bannerDataList[index] is Store) {
                        Store _store = bannerDataList[index];
                        if(isFeatured && (Get.find<LocationController>().getUserAddress().zoneData != null && Get.find<LocationController>().getUserAddress().zoneData.length > 0)) {
                          for(ModuleModel module in Get.find<SplashController>().moduleList) {
                            if(module.id == _store.moduleId) {
                              Get.find<SplashController>().setModule(module);
                              break;
                            }
                          }
                          ZoneData _zoneData = Get.find<LocationController>().getUserAddress().zoneData.firstWhere((data) => data.id == _store.zoneId);

                          Modules _module = _zoneData.modules.firstWhere((module) => module.id == _store.moduleId);
                          Get.find<SplashController>().setModule(ModuleModel(id: _module.id, moduleName: _module.moduleName, moduleType: _module.moduleType, themeId: _module.themeId, storesCount: _module.storesCount));
                        }
                        Get.toNamed(
                          RouteHelper.getStoreRoute(_store.id, isFeatured ? 'module' : 'banner'),
                          arguments: StoreScreen(store: _store, fromModule: isFeatured),
                        );
                      }else if(bannerDataList[index] is BasicCampaignModel) {
                        BasicCampaignModel _campaign = bannerDataList[index];
                        Get.toNamed(RouteHelper.getBasicCampaignRoute(_campaign));
                      }else {
                        String url = bannerDataList[index];
                        print('--------------url is: $url');
                        if (await canLaunchUrlString(url)) {
                          await launchUrlString(url, mode: LaunchMode.externalApplication);
                        }else {
                          showCustomSnackBar('unable_to_found_url'.tr);
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(15),
                        // boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: GetBuilder<SplashController>(builder: (splashController) {
                          return CustomImage(
                            image: '$_baseUrl/${bannerList[index]}',
                            fit: BoxFit.cover,
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
            ),

           // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            Positioned(
              bottom: 5,
              child: Container(
                alignment: Alignment.center,
                width: Get.width,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: bannerList.map((bnr) {
                  int index = bannerList.indexOf(bnr);
                  return bannerDataList[index] is BasicCampaignModel ?SizedBox(): Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color:  index == bannerController.currentIndex ? Theme.of(context).primaryColor
                            : Theme.of(context).primaryColor.withOpacity(0.5)
                    ),
                  );

                  /*TabPageSelectorIndicator(
                    backgroundColor: index == bannerController.currentIndex ? Theme.of(context).primaryColor
                        : Theme.of(context).primaryColor.withOpacity(0.5),
                    borderColor: Theme.of(context).backgroundColor,
                    size: index == bannerController.currentIndex ? 10 : 7,
                  );*/
                }).toList(),
            ),
              ),)


          ],
        ) : Shimmer(
          duration: Duration(seconds: 2),
          enabled: bannerList == null,
          child: Container(margin: EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            color: Colors.grey[300],
          )),
        ),
      );
    });
  }

}