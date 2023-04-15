import 'package:sixam_mart/controller/category_controller.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/view/base/custom_image.dart';
import 'package:sixam_mart/view/base/title_widget.dart';
import 'package:sixam_mart/view/screens/home/widget/category_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class CategoryView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return GetBuilder<CategoryController>(builder: (categoryController) {
      return (categoryController.categoryList != null && categoryController.categoryList.length == 0) ? SizedBox() : Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: TitleWidget(title: 'categories'.tr, onTap: () => Get.toNamed(RouteHelper.getCategoryRoute())),
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 115,
                  child: categoryController.categoryList != null ? ListView.builder(
                    controller: _scrollController,
                    itemCount: categoryController.categoryList.length > 15 ? 15 : categoryController.categoryList.length,
                    padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: InkWell(
                          onTap: () => Get.toNamed(RouteHelper.getCategoryItemRoute(
                            categoryController.categoryList[index].id, categoryController.categoryList[index].name,
                          )),
                          child: Container(
                            alignment: Alignment.center,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(10)
                           ),
                            width: 115,
                            child: Container(
                              alignment: Alignment.center,
                              height: 115, width: 115,
                             /* margin: EdgeInsets.only(
                                left: index == 0 ? 0 : Dimensions.PADDING_SIZE_EXTRA_SMALL,
                                right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                              ),*/
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                ClipRRect(
                                 borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                  child: CustomImage(
                                    image: '${Get.find<SplashController>().configModel.baseUrls.categoryImageUrl}/${categoryController.categoryList[index].image}',
                                    height: 90, width: 115, fit: BoxFit.fill,
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  //padding: EdgeInsets.symmetric(vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                                    color: Theme.of(context).primaryColor.withOpacity(0.8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3.0,bottom: 3),
                                    child: Text(
                                      categoryController.categoryList[index].name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).cardColor),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      );
                    },
                  ) : CategoryShimmer(categoryController: categoryController),
                ),
              ),

              ResponsiveHelper.isMobile(context) ? SizedBox() : categoryController.categoryList != null ? Column(
                children: [
                  InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (con) => Dialog(child: Container(height: 550, width: 600, child: CategoryPopUp(
                        categoryController: categoryController,
                      ))));
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text('view_all'.tr, style: TextStyle(fontSize: Dimensions.PADDING_SIZE_DEFAULT, color: Theme.of(context).cardColor)),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                ],
              ): CategoryAllShimmer(categoryController: categoryController)
            ],
          ),

        ],
      );
    });
  }
}

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  CategoryShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        itemCount: 14,
        padding: EdgeInsets.only(left: Dimensions.PADDING_SIZE_SMALL),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 1),
            child: SizedBox(
              width: 75,
              child: Container(
                height: 65, width: 65,
                margin: EdgeInsets.only(
                  left: index == 0 ? 0 : Dimensions.PADDING_SIZE_EXTRA_SMALL,
                  right: Dimensions.PADDING_SIZE_EXTRA_SMALL,
                ),
                child: Shimmer(
                  duration: Duration(seconds: 2),
                  enabled: categoryController.categoryList == null,
                  child: Container(
                    height: 65, width: 65,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoryAllShimmer extends StatelessWidget {
  final CategoryController categoryController;
  CategoryAllShimmer({@required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Padding(
        padding: EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
        child: Shimmer(
          duration: Duration(seconds: 2),
          enabled: categoryController.categoryList == null,
          child: Column(children: [
            Container(
              height: 50, width: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
              ),
            ),
            SizedBox(height: 5),
            Container(height: 10, width: 50, color: Colors.grey[300]),
          ]),
        ),
      ),
    );
  }
}

