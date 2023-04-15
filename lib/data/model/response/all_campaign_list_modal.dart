// To parse this JSON data, do
//
//     final allCampaignListModal = allCampaignListModalFromJson(jsonString);

import 'dart:convert';

AllCampaignListModal allCampaignListModalFromJson(String str) => AllCampaignListModal.fromJson(json.decode(str));

String allCampaignListModalToJson(AllCampaignListModal data) => json.encode(data.toJson());

class AllCampaignListModal {
  AllCampaignListModal({
     this.campaignData,
  });

  List<CampaignDatum> campaignData;

  factory AllCampaignListModal.fromJson(Map<String, dynamic> json) => AllCampaignListModal(
    campaignData: List<CampaignDatum>.from(json["campaignData"].map((x) => CampaignDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "campaignData": List<dynamic>.from(campaignData.map((x) => x.toJson())),
  };
}

class CampaignDatum {
  CampaignDatum({
     this.moduleId,
     this.campaignId,
     this.title,
     this.image,
  });

  int moduleId;
  int campaignId;
  String title;
  String image;

  factory CampaignDatum.fromJson(Map<String, dynamic> json) => CampaignDatum(
    moduleId: json["module_id"],
    campaignId: json["campaign_id"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "module_id": moduleId,
    "campaign_id": campaignId,
    "title": title,
    "image": image,
  };
}
