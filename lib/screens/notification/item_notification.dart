import 'package:antreeorder/components/export_components.dart';
import 'package:antreeorder/di/injection.dart';
import 'package:antreeorder/models/notification.dart';
import 'package:antreeorder/repository/sharedprefs_repository.dart';
import 'package:antreeorder/res/antree_textstyle.dart';
import 'package:antreeorder/screens/merchant_side/detail_antree/detail_antree_screen.dart';
import 'package:antreeorder/screens/user_side/antree/antree_screen.dart';
import 'package:antreeorder/utils/app_route.dart';
import 'package:antreeorder/utils/datetime_ext.dart';
import 'package:flutter/material.dart';
import 'package:antreeorder/models/notification.dart' as notify;

class ItemNotification extends StatelessWidget {
  final notify.Notification notification;
  final Function()? onClickDefault;
  final Function() onReaded;
  const ItemNotification(
      {Key? key,
      required this.notification,
      this.onClickDefault,
      required this.onReaded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final isMerchant =
            getIt<SharedPrefsRepository>().account?.isMerchant ?? false;
        isMerchant ? mappingClickMerchant() : mappingClick();
        if (!notification.isReaded) {
          onReaded();
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            notification.isReaded
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(right: 5, top: 5),
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    ),
                  ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AntreeText(
                    notification.title,
                    style: AntreeTextStyle.normal.bold,
                    maxLines: 2,
                  ),
                  AntreeSpacer(
                    size: 5,
                  ),
                  AntreeText(notification.message),
                  AntreeSpacer(),
                  AntreeText(
                    notification.createdAt?.toStringDate(
                            pattern: 'EEEE, dd MMMM yyyy HH:mm') ??
                        '',
                    style: AntreeTextStyle.small,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void mappingClick() {
    if (notification.type == NotificationType.antree) {
      AppRoute.to(AntreeScreen(notification.contentId));
    }
    onClickDefault!();
  }

  void mappingClickMerchant() {
    if (notification.type == NotificationType.antree) {
      AppRoute.to(DetailAntreeScreen(antreeId: notification.contentId));
    }
    onClickDefault!();
  }
}
