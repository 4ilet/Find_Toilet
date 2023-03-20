import 'package:find_toilet/utilities/type_enum.dart';

class ToiletModel {
  final int toiletId;
  final String toiletName, address, operatingTime, phoneNo;
  final bool hasDisabledM,
      hasDisabledF,
      hasChildM,
      hasChildF,
      hasDiaper,
      is24hour;
  ToiletModel.fromJson(DynamicMap json)
      : toiletId = json['toiletId'],
        toiletName = json['toiletName'],
        address = json['address'],
        operatingTime = json['operatingTime'],
        phoneNo = json['phoneNo'],
        hasDisabledM = json['hasDisabledM'],
        hasDisabledF = json['hasDisabledF'],
        hasChildF = json['hasChildF'],
        hasChildM = json['hasChildM'],
        hasDiaper = json['hasDiaper'],
        is24hour = json['is24hour'];
}
