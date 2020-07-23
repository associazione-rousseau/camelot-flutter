import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/network/response/user/residence_request_create_response.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/util/upload_util.dart';

class ChangeResidenceButton extends StatelessWidget {  
  ChangeResidenceButton(this.enabled, this.selectedDivisions, this.overseaseCity, this.userSlug, this.setResidenceChangeRequest);
  
  File _image;
  ImagePicker picker = ImagePicker();
  
  final HashMap<String, ItalianGeographicalDivision> selectedDivisions;
  final String overseaseCity;
  final UserNetworkHandler _userNetworkHandler = getIt<UserNetworkHandler>();
  final bool enabled;
  final String userSlug;
  final Function setResidenceChangeRequest;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: RoundedButton(
         onPressed: enabled == true ? () => {
          showRousseauDialog(context, createResidenceChangeRequest, 'upload-residence-document-title', 'upload-residence-document-message', 'upload-file')
        } : null,
        text: RousseauLocalizations.getText(context, 'save').toUpperCase(),
      ),
    );
  }


  Future createResidenceChangeRequest() async{
    // 1. pick image
    File image = await getImage();
    
    //2. upload it 
    String documentId = await uploadFile(image, 'residence_request_' + userSlug );
    
    //3.change residence mutation
    ResidenceRequestCreateResponse response = await _userNetworkHandler.createResidenceRequestChange(
      selectedDivisions['country'].code,
      selectedDivisions['regione'].code,
      selectedDivisions['provincia'].code,
      selectedDivisions['comune'].code,
      selectedDivisions['municipio'] != null ? selectedDivisions['municipio'].code : '',
      overseaseCity ?? '',
      documentId
    );

    //4 show residence request created
    if(response != null && response.residenceChangeRequest != null){
      setResidenceChangeRequest(response.residenceChangeRequest);
      return;
    }
    //show error
  }

  Future<File> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }
}
