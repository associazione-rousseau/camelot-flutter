import 'dart:collection';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rousseau_vote/src/injection/injector_config.dart';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';
import 'package:rousseau_vote/src/network/handlers/user_network_handler.dart';
import 'package:rousseau_vote/src/network/handlers/image_upload_handler.dart';
import 'package:rousseau_vote/src/network/response/user/residence_request_create_response.dart';
import 'package:rousseau_vote/src/util/ui_util.dart';
import 'package:rousseau_vote/src/widgets/rounded_button.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';

class ChangeResidenceButton extends StatefulWidget {  
  ChangeResidenceButton(this.enabled, this.selectedDivisions, this.overseaseCity, this.userSlug, this.setResidenceChangeRequest);
  
  final HashMap<String, ItalianGeographicalDivision> selectedDivisions;
  final String overseaseCity;
  final bool enabled;
  final String userSlug;
  final Function setResidenceChangeRequest;

  @override
  _ChangeResidenceButtonState createState() => _ChangeResidenceButtonState();
}

class _ChangeResidenceButtonState extends State<ChangeResidenceButton> {
  final ImagePicker picker = ImagePicker();

  final UserNetworkHandler _userNetworkHandler = getIt<UserNetworkHandler>();

  ImageUploadHandler imageUploadHandler;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    imageUploadHandler = getIt<ImageUploadHandler>();
    return Padding(
      padding: const EdgeInsets.all(15),
      child: RoundedButton(
         loading: loading,
         onPressed: widget.enabled == true ? () => {
          showRousseauDialog(context, createResidenceChangeRequest, 'upload-residence-document-title', 'upload-residence-document-message', 'upload-file')
        } : null,
        text: RousseauLocalizations.getText(context, 'save'),
      ),
    );
  }

  Future<void> createResidenceChangeRequest() async{

    setState(() {
      loading = true;
    });
    // 1. pick image
    final PickedFile file = await picker.getImage(source: ImageSource.gallery);
    
    String documentId;
    
    //2. upload it 
    try{
      documentId = await imageUploadHandler.uploadImage(file);
    }catch(e){
      print(e);
      return;
    }

    if(documentId == null)return;

    //3.change residence mutation
    final ResidenceRequestCreateResponse response = await _userNetworkHandler.createResidenceRequestChange(
      widget.selectedDivisions['country'].code,
      widget.selectedDivisions['regione'].code,
      widget.selectedDivisions['provincia'].code,
      widget.selectedDivisions['comune'].code,
      widget.selectedDivisions['municipio'] != null ? widget.selectedDivisions['municipio'].code : '',
      widget.overseaseCity ?? '',
      documentId
    );

    //4 show residence request created
    if(response != null && response.residenceChangeRequest != null){
      widget.setResidenceChangeRequest(response.residenceChangeRequest);
      return;
    }
    //show error
    setState(() {
      loading = false;
    });
  }
}