import 'package:find_toilet/utilities/type_enum.dart';

class ToiletModel {
  final int toiletId, reviewLen;
  final double score, lat, lng;
  final String toiletName, address, duration, phoneNo;
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
        duration = json['operationTime'],
        phoneNo = json['phoneNumber'],
        reviewLen = json['reviewLen'],
        score = json['score'],
        lat = json['lat'],
        lng = json['lon'],
        privateDisabledF = json['dfemalePoo'],
        privateDisabledM1 = json['dmalePee'],
        privateDisabledM2 = json['dmalePoo'],
        privateChildM1 = json['cmalePee'],
        privateChildM2 = json['cmalePoo'],
        privateChildF = json['cfemalePoo'],
        privateDiaper = json['diaper'],
        can24hour = json['allDay'];
}
