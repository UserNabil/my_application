import 'package:my_taraji/views/home/models/crowdfunding.dart';

class CrowdfundingOutput {
  List<Crowdfunding>? data;
  bool? isSuccess;

  CrowdfundingOutput({
    required this.data,
    required this.isSuccess,
  });

  // Factory constructor for JSON deserialization
  factory CrowdfundingOutput.fromJson(Map<String, dynamic> json) {
    return CrowdfundingOutput(
      data: List<Crowdfunding>.from(
        json['Data'].map((item) => Crowdfunding.fromJson(item)),
      ),
      isSuccess: json['IsSuccess'],
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'Data': List<dynamic>.from(data!.map((item) => item.toJson())),
      'IsSuccess': isSuccess,
    };
  }
}
