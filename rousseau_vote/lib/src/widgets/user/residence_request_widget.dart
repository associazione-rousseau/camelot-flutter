import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/residence_change_request.dart';

class ResidenceRequestWidget extends StatelessWidget{
  ResidenceRequestWidget(this.residenceChangeRequest);
  ResidenceChangeRequest residenceChangeRequest;

  @override Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(DEFAULT_SP)),
      elevation: 5,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom:10),
            child: Text(
              RousseauLocalizations.of(context).text('residence-' + residenceChangeRequest.status.toLowerCase()),
            ),
          ),
          Divider(
            endIndent: 30,
            indent: 30,
            thickness: 2,
            color: PRIMARY_RED,
          ),
          ListTile(
            leading: Text(RousseauLocalizations.of(context).text('country')+ ':'),
            title: Text(residenceChangeRequest.country.name),
          ),
          residenceChangeRequest.overseaseCity != null ? Column(
            children: <Widget>[
              ListTile(
                leading: Text(RousseauLocalizations.of(context).text('overseas-city') + ':'),
                title: Text(residenceChangeRequest.overseaseCity),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10,bottom: 10),
                child: Text(
                  RousseauLocalizations.of(context).text('last-italian-residence').toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            ],
          ) : Container(),
          residenceChangeRequest.regione != null ? ListTile(
            leading: Text(RousseauLocalizations.of(context).text('regione')+ ':'),
            title: Text(residenceChangeRequest.regione.name),
          ) : Container(),
          residenceChangeRequest.provincia != null ? ListTile(
            leading: Text(RousseauLocalizations.of(context).text('provincia')+ ':'),
            title: Text(residenceChangeRequest.provincia.name),
          ) : Container(),
          residenceChangeRequest.comune != null ? ListTile(
            leading: Text(RousseauLocalizations.of(context).text('comune')+ ':'),
            title: Text(residenceChangeRequest.comune.name),
          ) : Container() ,
          residenceChangeRequest.municipio != null ? ListTile(
            leading: Text(RousseauLocalizations.of(context).text('municipio')+ ':'),
            title: Text(residenceChangeRequest.municipio.name),
          ) : Container(),
        ],
      ),
    );
  }

}