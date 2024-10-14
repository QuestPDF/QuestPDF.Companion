import 'package:json_annotation/json_annotation.dart';

import 'generic_exception_stack_frame.dart';

part 'generic_exception_details.g.dart';

@JsonSerializable()
class GenericExceptionDetails {
  final String type;
  final String message;
  final List<GenericExceptionStackFrame> stackTrace;
  final GenericExceptionDetails? innerException;

  GenericExceptionDetails(this.type, this.message, this.stackTrace, this.innerException);

  factory GenericExceptionDetails.fromJson(Map<String, dynamic> json) => _$GenericExceptionDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$GenericExceptionDetailsToJson(this);
}
