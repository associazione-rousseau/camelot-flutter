import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class ChangeResidenceButton extends StatelessWidget {  
  ChangeResidenceButton(this.enabled, this.selectedDivisions, this.overseaseCity);
  
  File _image;
  ImagePicker picker = ImagePicker();
  
  final HashMap<String, ItalianGeographicalDivision> selectedDivisions;
  final String overseaseCity;
  final UserNetworkHandler _userNetworkHandler = getIt<UserNetworkHandler>();
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RoundedButton(

         onPressed: enabled == true ? () => {
          createResidenceChangeRequest() 
        } : null,
        text: RousseauLocalizations.getText(context, 'save').toUpperCase(),
      ),
    );
  }

  Future createResidenceChangeRequest() async{
    // 1. pick image
    File image = await getImage();
    
    //2. upload it 
    //TODO
    
    //3.do mutation
    _userNetworkHandler.createResidenceRequestChange(
      selectedDivisions['country'].code,
      selectedDivisions['regione'].code,
      selectedDivisions['provincia'].code,
      selectedDivisions['comune'].code,
      selectedDivisions['municipio'] != null ? selectedDivisions['municipio'].code : '',
      overseaseCity ?? '',
      'documentId'
    );
  }

  Future<File> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }
}
