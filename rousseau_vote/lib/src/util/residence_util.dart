import 'package:rousseau_vote/src/models/user/current_user.dart';
import 'dart:collection';
import 'package:rousseau_vote/src/models/italianGeographicalDivision.dart';

const List<String> DIVISIONS = <String>['country','regione','provincia','comune','municipio'];

bool fieldsUnchanged(CurrentUser currentUser, HashMap<String,ItalianGeographicalDivision> selectedDivisions){
  if(currentUser.country != null && selectedDivisions['country'] != null && currentUser.country.code != selectedDivisions['country'].code) return false;
  if(currentUser.regione != null && selectedDivisions['regione'] != null && currentUser.regione.code != selectedDivisions['regione'].code) return false;
  if(currentUser.provincia != null && selectedDivisions['provincia'] != null && currentUser.provincia.code != selectedDivisions['provincia'].code) return false;
  if(currentUser.comune != null && selectedDivisions['comune'] != null && currentUser.comune.code != selectedDivisions['comune'].code) return false;
  if(currentUser.municipio != null && selectedDivisions['municipio'] != null && currentUser.municipio.code != selectedDivisions['municipio'].code) return false;
  return true;
}