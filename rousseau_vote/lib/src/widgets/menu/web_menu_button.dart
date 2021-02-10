
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/menu/rousseau_menu_item.dart';
import 'package:share/share.dart';

class WebMenuButton extends StatelessWidget {

  const WebMenuButton({ @required this.url });

  final String url;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<RousseauMenuItemType>(
      onSelected: (RousseauMenuItemType type) {_onMenuItemSelected(context, type); },
      itemBuilder: (BuildContext context) {
        return const <PopupMenuEntry<RousseauMenuItemType>>[
          PopupMenuItem<RousseauMenuItemType>(
            value: RousseauMenuItemType.SHARE,
            child: RousseauMenuItem(
              textKey: 'menu-share',
              iconData: Icons.share,
            ),
          ),
          PopupMenuItem<RousseauMenuItemType>(
            value: RousseauMenuItemType.COPY_LINK,
            child: RousseauMenuItem(
              textKey: 'menu-copy-link',
              iconData: Icons.link,
            ),
          ),
          PopupMenuItem<RousseauMenuItemType>(
            value: RousseauMenuItemType.OPEN_IN_BROWSER,
            child: RousseauMenuItem(
              textKey: 'menu-open-in-browser',
              iconData: Icons.open_in_new,
            ),
          ),
        ];
      },
    );
  }

  void _onMenuItemSelected(BuildContext context, RousseauMenuItemType item) {
    switch (item) {
      case RousseauMenuItemType.SHARE:
        final String text = RousseauLocalizations.getTextFormatted(
            context, 'share-text', <String>[url]);
        final String subject =
        RousseauLocalizations.getText(context, 'share-subject');
        Share.share(text, subject: subject);
        break;
      case RousseauMenuItemType.COPY_LINK:
        Clipboard.setData(ClipboardData(text: url));
        showSimpleSnackbar(context, duration: 3, textKey: 'link-copied');
        break;
      case RousseauMenuItemType.OPEN_IN_BROWSER:
        openUrl(context, url);
        break;
    }
  }

}