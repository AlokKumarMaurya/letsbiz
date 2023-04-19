import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/controller/auth_controller.dart';
import 'package:sixam_mart/controller/banner_controller.dart';
import 'package:sixam_mart/controller/banner_controller.dart';
import 'package:sixam_mart/controller/item_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/location_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/data/model/response/address_model.dart';
import 'package:sixam_mart/data/model/response/basic_campaign_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/model/response/module_model.dart';
import 'package:sixam_mart/data/model/response/store_model.dart';
import 'package:sixam_mart/data/model/response/zone_response_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/custom_loader.dart';
import 'package:sixam_mart/view/base/custom_snackbar.dart';
import 'package:sixam_mart/view/base/title_widget.dart';
import 'package:sixam_mart/view/screens/address/widget/address_widget.dart';
import 'package:sixam_mart/view/screens/home/widget/banner_view.dart';
import 'package:sixam_mart/view/screens/home/widget/basic_campaign_view.dart';
import 'package:sixam_mart/view/screens/home/widget/popular_store_view.dart';
import 'package:sixam_mart/view/screens/store/store_screen.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:sixam_mart/controller/campaign_controller.dart';
import '../../../../controller/item_controller.dart';
import '../../../../data/model/response/basic_campaign_model.dart';
import '../../../../data/model/response/item_model.dart';
import '../../../../data/model/response/module_model.dart';
import '../../../../data/model/response/zone_response_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sixam_mart/data/repository/campaign_repo.dart';
import 'package:sixam_mart/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/util/app_constants.dart';

import '../../store/campaign_screen.dart';
import '../theme1/banner_view1.dart';

//SharedPreferences sharedPreferences=new Sha;
class ModuleView extends StatelessWidget {
  final SplashController splashController;

  ModuleView({@required this.splashController});

 CampaignController _campaignController=Get.put(CampaignController(campaignRepo:CampaignRepo(apiClient: ApiClient(appBaseUrl: AppConstants.BASE_URL,sharedPreferences: Get.find() )) ));
RxString temptemp="sssssssssssss".obs;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GetBuilder<BannerController>(builder: (bannerController) {
        return BannerView(isFeatured: true);
      }),
      SizedBox(
        height: 20,
      ),
      splashController.moduleList != null
          ? splashController.moduleList.length > 0
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                    crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
                    childAspectRatio: 1.5,     //bigger the number smaller the size
                  ),
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  itemCount: splashController.moduleList.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => splashController.switchModule(index, true),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Stack(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                                child: CustomImage(
                                  image:
                                      '${splashController.configModel.baseUrls.moduleImageUrl}/${splashController.moduleList[index].icon}',
                                  height: 122,
                                  width: 110,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              left: 10,
                              child: Container(
                                width: 79,
                              height: 112,
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                              ),
                              child: Text(
                                splashController.moduleList[index].moduleName,
                                textAlign: TextAlign.center,
                               // overflow: TextOverflow.ellipsis,
                                style: robotoMedium.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                            ),)
                            // SizedBox(height: 6),


                          ],
                        ),
                      ),
                    );

                    /*InkWell(
            onTap: () => splashController.switchModule(index, true),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                color: Theme.of(context).cardColor,
                boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 200], spreadRadius: 1, blurRadius: 5)],
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                  child: CustomImage(
                    image: '${splashController.configModel.baseUrls.moduleImageUrl}/${splashController.moduleList[index].icon}',
                    height: 50, width: 50,
                  ),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),

                Center(child: Text(
                  splashController.moduleList[index].moduleName,
                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                )),

              ]),
            ),
          );*/
                  },
                )
              : Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                  child: Text('no_module_found'.tr),
                ))
          : ModuleShimmer(isEnabled: splashController.moduleList == null),
      SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

      //deliver to is hidden from the main screen
      /*  Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        child: TitleWidget(title: "'deliver_to'.tr"),
      ),
      SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
      GetBuilder<LocationController>(builder: (locationController) {
        List<AddressModel> _addressList = [];
        if(Get.find<AuthController>().isLoggedIn() && locationController.addressList != null) {
          _addressList = [];
          bool _contain = false;
          if(locationController.getUserAddress().id != null) {
            for(int index=0; index<locationController.addressList.length; index++) {
              if(locationController.addressList[index].id == locationController.getUserAddress().id) {
                _contain = true;
                break;
              }
            }
          }
          if(!_contain) {
            _addressList.add(Get.find<LocationController>().getUserAddress());
          }
          _addressList.addAll(locationController.addressList);
        }else {
          _addressList.add(Get.find<LocationController>().getUserAddress());
        }
        return (!Get.find<AuthController>().isLoggedIn() || locationController.addressList != null) ? SizedBox(
          height: 70,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _addressList.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
            itemBuilder: (context, index) {
              return Container(
                width: 300,
                padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                child: AddressWidget(
                  address: _addressList[index],
                  fromAddress: false,
                  onTap: () {
                    if(locationController.getUserAddress().id != _addressList[index].id) {
                      Get.dialog(CustomLoader(), barrierDismissible: false);
                      locationController.saveAddressAndNavigate(
                        _addressList[index], false, null, false, ResponsiveHelper.isDesktop(context),
                      );
                    }
                  },
                ),
              );
            },
          ),
        ) : AddressShimmer(isEnabled: Get.find<AuthController>().isLoggedIn() && locationController.addressList == null);
      }),*/
      SizedBox(
        height: 15,
      ),

      ///Place add banner here
     Get.find<CampaignController>().allCampianList.value.length>0? Container(
        padding:EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    height: 3,
                    width: Get.width/5.5,
                    color: Colors.black,
                  ),
                  SizedBox(width: 5,),
                  Text(
                    "FAVOURITE OFFERS",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w800
                      )
                    )
                  ),
                  SizedBox(width: 5,),
                  Container(
                    height: 3,
                    width: Get.width/5.5,
                    color: Colors.black,
                  ),
                ],
              ),
              Text("LOCALLY !",style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5
                  )
              ),)
            ],
          )):SizedBox(),
      SizedBox(
        height: 15,
      ),




///campaion here**********************
      /*SizedBox(
        height: 200,
        child: BasicCampaignView(campaignController: _campaignController),
      ),*/

      //BannerView1(isFeatured: false),
       Obx((){
         debugPrint(temptemp.value);
         return SizedBox(height:200 ,child: GetBuilder<CampaignController>(builder: (bannerController){
           //List<String> bannerList = false ? bannerController.featuredBannerList : bannerController.bannerImageList;
           //List<dynamic> bannerDataList = false ? bannerController.featuredBannerDataList : bannerController.bannerDataList;




           debugPrint("this is in the build methid ${bannerController.allCampianList}");

           return bannerController.allCampianList.value !=null? ListView.builder(
             shrinkWrap: true,
             scrollDirection: Axis.horizontal,
             itemCount: bannerController.allCampianList.value.length,
             itemBuilder: (context, index) {



               // String _baseUrl = bannerDataList[index] is BasicCampaignModel ? Get.find<SplashController>()
               //   .configModel.baseUrls.campaignImageUrl  : Get.find<SplashController>().configModel.baseUrls.bannerImageUrl;
               // debugPrint("this is the url------$_baseUrl/${bannerList[index]}");

               return /*bannerDataList[index] is BasicCampaignModel ?Container(
              width: 40,
              height: 40,
              color:Colors.pink,
              ) :*/Padding(
                 padding: const EdgeInsets.only(right: 18.0),
                 child: InkWell(
                   onTap: () async {

                     if( Get.find<SplashController>().moduleList != null) {
                       for(ModuleModel module in Get.find<SplashController>().moduleList) {
                         if(module.id == bannerController.allCampianList.value[index].moduleId) {
                           Get.find<SplashController>().setModule(module);
                           break;
                         }
                       }
                     }



                  //   Get.find<SplashController>().setModule(ModuleModel(id:bannerController.allCampianList[index].moduleId, moduleName: _module.moduleName, moduleType: _module.moduleType, themeId: _module.themeId, storesCount: _module.storesCount));
                     Get.to(CampaignScreen(modalId: bannerController.allCampianList.value[index].moduleId.toString(),campainIIID:bannerController.allCampianList.value[index]));
                     //bannerController.getBasicCampaignDetails(campaignID:bannerController.allCampianList[index].campaignId , moduleid:bannerController.allCampianList[index].moduleId.toString() );
                     //Get.toNamed(RouteHelper.getBasicCampaignRoute(bannerController.basicCampaignList[index]));
                     /*    if(bannerDataList[index] is Item) {
                      Item _item = bannerDataList[index];
                      Get.find<ItemController>().navigateToItemPage(_item, context);
                    }else if(bannerDataList[index] is Store) {
                      Store _store = bannerDataList[index];
                      if(false && Get.find<SplashController>().moduleList != null) {
                        for(ModuleModel module in Get.find<SplashController>().moduleList) {
                          if(module.id == _store.moduleId) {
                            Get.find<SplashController>().setModule(module);
                            break;
                          }
                        }
                      }
                      Get.toNamed(
                        RouteHelper.getStoreRoute(_store.id, false ? 'module' : 'banner'),
                        arguments: StoreScreen(store: _store, fromModule: false),
                      );
                    }else if(bannerDataList[index] is BasicCampaignModel) {
                      BasicCampaignModel _campaign = bannerDataList[index];

                      Get.toNamed(RouteHelper.getBasicCampaignRoute(_campaign,));
                    }else {
                      String url = bannerDataList[index];
                      if (await canLaunchUrlString(url)) {
                        await launchUrlString(url, mode: LaunchMode.externalApplication);
                      }else {
                        showCustomSnackBar('unable_to_found_url'.tr);
                      }
                    }*/
                   },
                   child: Container(
                     margin:index==0?EdgeInsets.only(right: 10,left: 10): EdgeInsets.only(right: 10),
                     width: Get.width/2.5,
                     decoration: BoxDecoration(
                       color: Theme.of(context).dividerColor,
                       // borderRadius: BorderRadius.circular(20),
                       boxShadow: [BoxShadow(color: Colors.grey

                           /*[Get.isDarkMode ? 800 : 200]*/
                           , spreadRadius: 1, blurRadius: 15)],
                     ),
                     child: ClipRRect(
                       // borderRadius: BorderRadius.circular(20),
                       child: GetBuilder<SplashController>(builder: (splashController) {
                         return CustomImage(
                           width: Get.width/2.6,
                           image:bannerController.allCampianList.value[index].image,
                           fit: BoxFit.cover,
                         );
                       }),
                     ),
                   ),
                 ),
               );
             },
           ):SizedBox();
         }
         ),);
       }),

      /*GetBuilder<BannerController>(builder: (bannerController) {
        List<String> bannerList = false
            ? bannerController.featuredBannerList
            : bannerController.bannerImageList;
        List<dynamic> bannerDataList = false
            ? bannerController.featuredBannerDataList
            : bannerController.bannerDataList;

        return (bannerList != null && bannerList.length == 0)
            ? SizedBox()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: GetPlatform.isDesktop
                    ? 500
                    : MediaQuery.of(context).size.width * 0.60,
                padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_DEFAULT),
                margin: EdgeInsets.only(left: Dimensions.PADDING_SIZE_DEFAULT),
                child: bannerList != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: bannerList.length == 0
                                  ? 1
                                  : bannerList.length,
                              itemBuilder: (context, index,) {
                                String _baseUrl =
                                bannerDataList[index] is BasicCampaignModel
                                    ? Get.find<SplashController>()
                                    .configModel
                                    .baseUrls
                                    .campaignImageUrl
                                    : Get.find<SplashController>()
                                    .configModel
                                    .baseUrls
                                    .bannerImageUrl;
                                return bannerDataList[index] is BasicCampaignModel?InkWell(
                                  onTap: () async {
                                    if (bannerDataList[index] is Item) {
                                      Item _item = bannerDataList[index];
                                      Get.find<ItemController>()
                                          .navigateToItemPage(_item, context);
                                    } else if (bannerDataList[index] is Store) {
                                      Store _store = bannerDataList[index];
                                      if (false &&
                                          Get.find<SplashController>()
                                              .moduleList !=
                                              null) {
                                        for (ModuleModel module
                                        in Get.find<SplashController>()
                                            .moduleList) {
                                          if (module.id == _store.moduleId) {
                                            Get.find<SplashController>()
                                                .setModule(module);
                                            break;
                                          }
                                        }
                                      }
                                      Get.toNamed(
                                        RouteHelper.getStoreRoute(_store.id,
                                            false ? 'module' : 'banner'),
                                        arguments: StoreScreen(
                                            store: _store,
                                            fromModule: false),
                                      );
                                    } else if (bannerDataList[index]
                                    is BasicCampaignModel) {
                                      BasicCampaignModel _campaign =
                                      bannerDataList[index];
                                      Get.toNamed(
                                          RouteHelper.getBasicCampaignRoute(
                                              _campaign));
                                    } else {
                                      String url = bannerDataList[index];
                                      if (await canLaunchUrlString(url)) {
                                        await launchUrlString(url,
                                            mode:
                                            LaunchMode.externalApplication);
                                      } else {
                                        showCustomSnackBar(
                                            'unable_to_found_url'.tr);
                                      }
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      //borderRadius: BorderRadius.circular(20),
                                    boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 4, blurRadius: 5,offset: Offset(8.0,1.0))],
                                    ),
                                    child: ClipRRect(
                                      //borderRadius: BorderRadius.circular(20),
                                      child: GetBuilder<SplashController>(
                                          builder: (splashController) {
                                            return CustomImage(
                                              image:
                                              '$_baseUrl/${bannerList[index]}',
                                              fit: BoxFit.cover,
                                            );
                                          }),
                                    ),
                                  ),
                                ):SizedBox();
                              },
                            ),
                          ),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        */
      /*  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: bannerList.map((bnr) {
                              int index = bannerList.indexOf(bnr);
                              return Container(
                                height: 4,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color:
                                        index == bannerController.currentIndex
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context)
                                                .primaryColor
                                                .withOpacity(0.5)),
                              );

                              *//**/
      /*TabPageSelectorIndicator(
                  backgroundColor: index == bannerController.currentIndex ? Theme.of(context).primaryColor
                      : Theme.of(context).primaryColor.withOpacity(0.5),
                  borderColor: Theme.of(context).backgroundColor,
                  size: index == bannerController.currentIndex ? 10 : 7,
                );*//**/
      /*
                            }).toList(),
                          ),*/
      /*
                        ],
                      )
                    : Shimmer(
                        duration: Duration(seconds: 2),
                        enabled: bannerList == null,
                        child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.RADIUS_SMALL),
                              color: Colors.grey[300],
                            )),
                      ),
              );
      }),*/

      SizedBox(
        height: 20,
      ),

      /*  Container(
        height: MediaQuery.of(context).size.width * 0.60,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Get.isDarkMode?Colors.white:Color(0xffDCF1FA),Get.isDarkMode?Colors.white:Color(0xffDCF1FA),*/ /*Theme.of(context).backgroundColor*/ /*],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Image.network("https://freepngimg.com/thumb/grocery/41619-7-groceries-free-download-image-thumb.png"),
      ),*/

      //PopularStoreView(isPopular: false, isFeatured: true),

   SizedBox(height: 30),
    ]);
  }
}

class ModuleShimmer extends StatelessWidget {
  final bool isEnabled;

  ModuleShimmer({@required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
        crossAxisSpacing: Dimensions.PADDING_SIZE_SMALL,
        childAspectRatio: (1 / 1),
      ),
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      itemCount: 6,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            color: Theme.of(context).cardColor,
            // boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 700 : 200], spreadRadius: 1, blurRadius: 5)],
          ),
          child: Shimmer(
            duration: Duration(seconds: 2),
            enabled: isEnabled,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    color: Colors.grey[300]),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Center(
                  child: Container(
                      height: 15, width: 50, color: Colors.grey[300])),
            ]),
          ),
        );
      },
    );
  }
}

class AddressShimmer extends StatelessWidget {
  final bool isEnabled;

  AddressShimmer({@required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        padding:
            EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL),
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
            child: Container(
              padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)
                  ? Dimensions.PADDING_SIZE_DEFAULT
                  : Dimensions.PADDING_SIZE_SMALL),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                //boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], blurRadius: 5, spreadRadius: 1)],
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(
                  Icons.location_on,
                  size: ResponsiveHelper.isDesktop(context) ? 50 : 40,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                Expanded(
                  child: Shimmer(
                    duration: Duration(seconds: 2),
                    enabled: isEnabled,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              height: 15, width: 100, color: Colors.grey[300]),
                          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          Container(
                              height: 10, width: 150, color: Colors.grey[300]),
                        ]),
                  ),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}
