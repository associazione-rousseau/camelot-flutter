import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/residence_change_request.dart';

class ResidenceRequestWidget extends StatelessWidget{
  ResidenceRequestWidget(this.residenceChangeRequest);
  ResidenceChangeRequest residenceChangeRequest;

  @override Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(residenceChangeRequest.status),
        ListTile(
          leading: Text(RousseauLocalizations.of(context).text('country')),
          title: Text(residenceChangeRequest.country.name),
        ),
        residenceChangeRequest.overseaseCity != null ? Column(
          children: <Widget>[
            ListTile(
              leading: Text(RousseauLocalizations.of(context).text('overseas-city')),
              title: Text(residenceChangeRequest.overseaseCity),
            ),
            Padding(
              padding: const EdgeInsets.only(top:30,bottom: 10),
              child: Text(
                RousseauLocalizations.of(context).text('last-italian-residence').toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
          ],
        ) : Container(),
        ListTile(
          leading: Text(RousseauLocalizations.of(context).text('regione')),
          title: Text(residenceChangeRequest.regione.name),
        ),
        ListTile(
          leading: Text(RousseauLocalizations.of(context).text('provincia')),
          title: Text(residenceChangeRequest.provincia.name),
        ),
        ListTile(
          leading: Text(RousseauLocalizations.of(context).text('comune')),
          title: Text(residenceChangeRequest.comune.name),
        ),
        residenceChangeRequest.municipio != null ? ListTile(
          leading: Text(RousseauLocalizations.of(context).text('municipio')),
          title: Text(residenceChangeRequest.municipio.name),
        ) : Container(),
      ],
    );
  }

}