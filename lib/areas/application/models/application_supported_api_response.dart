import 'package:json_annotation/json_annotation.dart';

part 'application_supported_api_response.g.dart';

@JsonSerializable()
class ApplicationSupportedApiResponse {
  final List<int> supportedVersions;

  ApplicationSupportedApiResponse(this.supportedVersions);

  factory ApplicationSupportedApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApplicationSupportedApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationSupportedApiResponseToJson(this);
}
