import 'package:find_toilet/utilities/type_enum.dart';

class ToiletModel {
  final int toiletId;
  final String toiletName, address, operatingTime, phoneNo;
  final bool privateDisabledM1,
      privateDisabledM2,
      privateDisabledF,
      privateChildM1,
      privateChildM2,
      privateChildF,
      privateDiaper,
      can24hour;
  ToiletModel.fromJson(DynamicMap json)
      : toiletId = json['toiletId'],
        toiletName = json['toiletName'],
        address = json['address'],
        operatingTime = json['operatingTime'],
        phoneNo = json['phoneNumber'],
        privateDisabledF = json['dFemalePoo'],
        privateDisabledM1 = json['hasDisabledM1'],
        privateDisabledM2 = json['dFemalePoo'],
        privateChildM1 = json['cMalePee'],
        privateChildM2 = json['cMalePoo'],
        privateChildF = json['hasChildF'],
        privateDiaper = json['diaper'],
        can24hour = json['24hour'];
}
