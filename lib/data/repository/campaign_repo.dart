import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/data/api/api_client.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get.dart';

import '../model/response/address_model.dart';
class CampaignRepo {
  final ApiClient apiClient;
  CampaignRepo({@required this.apiClient});

  Future<Response> getBasicCampaignList() async {
    print("this is the url of the get ==${AppConstants.BASIC_CAMPAIGN_URI} ");
    return await apiClient.getData(AppConstants.BASIC_CAMPAIGN_URI
      /*,headers: {
      'Content-Type': 'application/json; charset=UTF-8',
  */
      /*    AppConstants.ZONE_ID: zoneIDs != null ? jsonEncode(zoneIDs) : null,
      AppConstants.LOCALIZATION_KEY: languageCode ?? AppConstants.languages[0].languageCode,
      AppConstants.LATITUDE: latitude != null ? jsonEncode(latitude) : null,
      AppConstants.LONGITUDE: longitude != null ? jsonEncode(longitude) : null,
      'Authorization': 'Bearer $token'*//*
    }*/);
  }


  Future<Response> getAllCampaignList()async{
    debugPrint("get all campian list function called");
    var aa=await GetConnect().get("https://panel.letsbiz.app/api/v1/basic-compaign");
    if(aa.statusCode==200){

    }
    return aa;
  }







  Future<Response> getCampaignDetails({@required String campaignID ,@required String moduleId}) async {
    AddressModel _addressModel;
    SharedPreferences temp=Get.find();
    var aa=await temp.getString(AppConstants.LONGITUDE);
    print("hurray we did it $aa");
    return await apiClient.getData('${AppConstants.BASIC_CAMPAIGN_DETAILS_URI}$campaignID',
        /*,headers: {
    'Authorization': 'Bearer $token',
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.LOCALIZATION_KEY: AppConstants.languages[0].languageCode,
      "moduleId": "2",
      "zoneId":jsonEncode([1,2,3])
     */
        /* AppConstants.LATITUDE: latitude != null ? jsonEncode(latitude) : null,
      AppConstants.LONGITUDE: longitude != null ? jsonEncode(longitude) : null,*//*
    }*/

      /*headers: {
        "moduleId":moduleId,
     "Content-Type": "application/json",
"charset":"UTF-8",
        "zoneId": jsonEncode([1]),
"X-localization": temp.getString(AppConstants.LANGUAGE_CODE),
        "latitude": _addressModel.latitude,
        "longitude": _addressModel.longitude,

        }*/

    );
  }

  Future<Response> getItemCampaignList({@required String moduleId}) async {
    SharedPreferences temp=Get.find();
    AddressModel _addressModel;
    _addressModel = AddressModel.fromJson(jsonDecode(temp.getString(AppConstants.USER_ADDRESS)));
    String token=await temp.getString(AppConstants.TOKEN);
    return await /*apiClient.getData*/GetConnect().get(AppConstants.BASE_URL+AppConstants.ITEM_CAMPAIGN_URI,headers: {
      "zoneId": jsonEncode(_addressModel.zoneIds),
      "X-localization": "en",
      "latitude": _addressModel.latitude,
      "longitude":_addressModel.longitude,
      "moduleId":moduleId,
      'Authorization': 'Bearer $token',
    });
  }

}