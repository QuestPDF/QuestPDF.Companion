import 'package:json_annotation/json_annotation.dart';

import 'generic_exception_details.dart';

part 'show_generic_exception_command.g.dart';

@JsonSerializable()
class ShowGenericExceptionCommand {
  final GenericExceptionDetails exception;

  ShowGenericExceptionCommand(this.exception);

  factory ShowGenericExceptionCommand.fromJson(Map<String, dynamic> json) =>
      _$ShowGenericExceptionCommandFromJson(json);

  Map<String, dynamic> toJson() => _$ShowGenericExceptionCommandToJson(this);
}
