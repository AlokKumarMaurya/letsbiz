import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/data/api/api_checker.dart';
import 'package:sixam_mart/data/model/response/basic_campaign_model.dart';
import 'package:sixam_mart/data/model/response/item_model.dart';
import 'package:sixam_mart/data/repository/campaign_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/app_constants.dart';

import '../data/api/api_client.dart';
import '../data/model/response/address_model.dart';
import '../data/model/response/all_campaign_list_modal.dart';


String publicModuleId;

class CampaignController extends GetxController implements GetxService {
  final CampaignRepo campaignRepo;
  CampaignController({@required this.campaignRepo});

  List<BasicCampaignModel> _basicCampaignList;
  BasicCampaignModel _campaign;
  List<Item> _itemCampaignList;

  List<BasicCampaignModel> get basicCampaignList => _basicCampaignList;
  BasicCampaignModel get campaign => _campaign;
  List<Item> get itemCampaignList => _itemCampaignList;

  List<CampaignDatum> _allCampianList ;
  RxList<CampaignDatum>   allCampianList =List<CampaignDatum>.empty(growable: true).obs;

  @override
  void onInit() {
    itemCampaignNull();
    getAllCampaignList();
    //getBasicCampaignList(true);
    // TODO: implement onInit
    super.onInit();
  }


  void itemCampaignNull(){
    _itemCampaignList = null;
  }

  Future<void> getBasicCampaignList(bool reload) async {
    print("basic campion function is called");
    if(_basicCampaignList == null || reload) {
      Response response = await campaignRepo.getBasicCampaignList();
      if (response.statusCode == 200) {
        _basicCampaignList = [];
        response.body.forEach((campaign) => _basicCampaignList.add(BasicCampaignModel.fromJson(campaign)));
     print(_basicCampaignList.toString());
     print("_basicCampaignList.toString()_basicCampaignList.toString()");
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> getBasicCampaignDetails({@required int campaignID,@required String moduleid}) async {
    _campaign = null;
    Response response = await campaignRepo.getCampaignDetails(campaignID: campaignID.toString(),moduleId: moduleid);
    if (response.statusCode == 200) {
      _campaign = BasicCampaignModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }


  Future<void> getBasicCampaignDetails1({@required int campaignID,@required String moduleid}) async {
    publicModuleId=moduleid;
    SharedPreferences temp=Get.find();
    AddressModel _addressModel;
    _addressModel = AddressModel.fromJson(jsonDecode(temp.getString(AppConstants.USER_ADDRESS)));
    _campaign = null;

    String token=await temp.getString(AppConstants.TOKEN);
   Response response = await GetConnect().get("https://panel.letsbiz.app/api/v1/campaigns/basic-campaign-details?basic_campaign_id=$campaignID",headers: {
//Content-Type: application/json
//charset:UTF-8
      "zoneId": jsonEncode(_addressModel.zoneIds),
      "X-localization": "en",
      "latitude": _addressModel.latitude,
      "longitude":_addressModel.longitude,
      "moduleId":moduleid,
      'Authorization': 'Bearer $token',
    });//campaignRepo.getCampaignDetails(campaignID: campaignID.toString(),moduleId: moduleid);
    if (response.statusCode == 200) {
      debugPrint("testetstetst  ${response.body}");
      _campaign = BasicCampaignModel.fromJson(response.body);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
    ApiClient(sharedPreferences: temp,appBaseUrl: AppConstants.BASE_URL).updateHeader(token, _addressModel.zoneIds, "en", int.parse(moduleid), _addressModel.latitude, _addressModel.longitude);

  }






  Future<void> getItemCampaignList(bool reload, String moduleType,int id) async {
    if(_itemCampaignList == null || reload) {

      Response response = await campaignRepo.getItemCampaignList(moduleId: id.toString());
      if (response.statusCode == 200) {
        _itemCampaignList = [];
        List<Item> _campaign = [];
        response.body.forEach((campaign) => _campaign.add(Item.fromJson(campaign)));
        _campaign.forEach((campaign) {
          if(campaign.moduleType == 'food' && moduleType == 'food' && campaign.foodVariations.isNotEmpty){
            _itemCampaignList.add(campaign);
          }else if(moduleType != 'food' && campaign.foodVariations.isEmpty){
            _itemCampaignList.add(campaign);
          }
        });
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  Future<void> getAllCampaignList()async{
    Response response=await campaignRepo.getAllCampaignList();
    if(response.statusCode==200){
      allCampianList.value.clear();
debugPrint(response.body.toString());
debugPrint("this is the response of the get all campian list modal");
AllCampaignListModal modal=AllCampaignListModal.fromJson(response.body);
      allCampianList.value=modal.campaignData;
      debugPrint("this is the after setting the valeu $_allCampianList}");
    }
  }

}