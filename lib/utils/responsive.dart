import 'package:flutter/widgets.dart';


enum DeviceType { phone, tablet }


DeviceType deviceType(MediaQueryData mq) {
final width = mq.size.width;
if (width >= 900) return DeviceType.tablet;
return DeviceType.phone;
}


bool isLandscape(BuildContext context) => MediaQuery.of(context).orientation == Orientation.landscape;