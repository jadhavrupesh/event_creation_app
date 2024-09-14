// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EventModelImpl _$$EventModelImplFromJson(Map<String, dynamic> json) =>
    _$EventModelImpl(
      eventName: json['eventName'] as String,
      eventDescription: json['eventDescription'] as String,
      selectedDate: DateTime.parse(json['selectedDate'] as String),
    );

Map<String, dynamic> _$$EventModelImplToJson(_$EventModelImpl instance) =>
    <String, dynamic>{
      'eventName': instance.eventName,
      'eventDescription': instance.eventDescription,
      'selectedDate': instance.selectedDate.toIso8601String(),
    };
