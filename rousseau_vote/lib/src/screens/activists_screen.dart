import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rousseau_vote/src/models/user.dart';
import 'package:rousseau_vote/src/providers/activists_search_provider.dart';
import 'package:rousseau_vote/src/providers/search_suggestions_provider.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/core/icon_text_screen.dart';
import 'package:rousseau_vote/src/widgets/core/rousseau_list.dart';
import 'package:rousseau_vote/src/widgets/rousseau_logged_scaffold.dart';
import 'package:rousseau_vote/src/widgets/search/filter_chip_widget.dart';
import 'package:rousseau_vote/src/widgets/user/user_card.dart';

class ActivistsScreen extends StatelessWidget {
  const ActivistsScreen();

  static const String ROUTE_NAME = '/activists';

  @override
  Widget build(BuildContext context) {
    return RousseauLoggedScaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
//            ActivistSearchWidget(),
            _resetFiltersWidget(context),
            RousseauList<ActivistsSearchProvider, User>(
              primary: false,
              noResultsBuilder: (BuildContext context) => const Center(
                child: IconTextScreen(
                  iconData: Icons.search,
                  messageKey: 'no-activists-found',
                ),
              ),
              itemBuilder: (BuildContext context, User user) => UserCard(
                  user: user,
                  onTap: (BuildContext context) {
                    Provider.of<SearchSuggestionsProvider>(context,
                            listen: false)
                        .onProfileOpened(user);
                    openProfile(context, user.slug);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resetFiltersWidget(BuildContext context) {
    final ActivistsSearchProvider provider = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: <FilterChipWidget>[
          FilterChipWidget(
            isSet: provider.fullNameSearchFilter.isSet,
            label: provider.fullNameSearchFilter.getWord(),
            icon: Icons.search,
            onDeleted: () => provider.onSearch(context, null),
          ),
          FilterChipWidget(
            isSet: provider.geographicalFilter.isSet,
            label: provider.geographicalFilter.geographicalName,
            icon: Icons.person_pin_circle_outlined,
            onDeleted: () => provider.onSearchByGeographicalDivision(context, null),
          ),
          FilterChipWidget(
            isSet: provider.positionFilter.isSet,
            label: provider.positionFilter.positionName,
            icon: MdiIcons.accountCheckOutline,
            onDeleted: () => provider.onSearchByPosition(context, null),
          )
        ],
      ),
    );
  }
}
