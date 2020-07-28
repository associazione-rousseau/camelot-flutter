import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rousseau_vote/src/config/app_constants.dart';
import 'package:rousseau_vote/src/l10n/rousseau_localizations.dart';
import 'package:rousseau_vote/src/models/option.dart';
import 'package:rousseau_vote/src/models/poll.dart';
import 'package:rousseau_vote/src/widgets/poll_entity_detail.dart';
import 'package:rousseau_vote/src/widgets/poll_text_detail.dart';
import 'package:rousseau_vote/src/widgets/vote/vote_bar.dart';

class PollDetailsBodyContent extends StatefulWidget {
  
  const PollDetailsBodyContent(this._poll);

  final Poll _poll;

  @override
  State<StatefulWidget> createState() {
    return _PollDetailsBodyContentState(_poll);
  }
}

class _PollDetailsBodyContentState extends State<PollDetailsBodyContent> {

  _PollDetailsBodyContentState(this._poll);

  final Poll _poll;
  List<Option> selected = <Option>[];
  List<Option> filteredOptions = <Option>[];
  TextEditingController _entityFilterController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        getPollStatusBar(context),
        Padding(
          padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
          child: Text(
            _poll.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            _poll.description,
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
        _poll.optionType == 'ENTITY' ? 
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left:10, right:10),
            child: TextField(
              controller: _entityFilterController, 
              enabled: true,
              decoration: InputDecoration(
                hintText: RousseauLocalizations.getText(context, 'vote-search-candidate')
              )
            ),
          ): null,
        Expanded(
          child: ListView.builder(
            itemCount: filteredOptions.length,
            itemBuilder: (BuildContext context, int position) {
              return getOption(position);
            },
          )
        ),
        VoteBar(_poll,selected)
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    filterCandidates();
    _entityFilterController.addListener(filterCandidates);
  }

  Widget getPollStatusBar(BuildContext context) {
    final PollStatus pollStatus = _poll.pollStatus;
    String text;
    Color color = _poll.color;
    if (_poll.alreadyVoted) {
      color = VOTED_BLUE;
      text = 'vote-already-done';
    } else if (pollStatus == PollStatus.OPEN) {
      text = 'poll-open';
    } else if (pollStatus == PollStatus.PUBLISHED) {
      text = 'vote-published';
    } else if (pollStatus == PollStatus.CLOSED) {
      text = 'vote-closed';
    }
    return Container(
        color: color,
        child: Text(
        RousseauLocalizations.getText(context, text),
        style: TextStyle(
          color: Colors.white, 
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget getOption(int index) {
    if (_poll.optionType == 'ENTITY') {
      return PollEntityDetail(
        filteredOptions[index],
        _poll.alreadyVoted || selected.length >= _poll.maxSelectableOptionsNumber, 
        _toggle,
        selected,
        _poll.maxSelectableOptionsNumber,
        selected.where((Option element) => element.entity.slug == filteredOptions[index].entity.slug).isNotEmpty
      );
    } else {
      return PollTextDetail(
        _poll.options[index],
        _poll.alreadyVoted || selected.length >= _poll.maxSelectableOptionsNumber, 
        _toggle,
        selected,
        _poll.maxSelectableOptionsNumber
      );
    }
  }

  void _toggle(Option option) {
    final List<Option> result = selected;
    if (result.contains(option)) {
      result.remove(option);
    } else {
      result.add(option);
    }
    setState(() { selected = result; });
  }

  void filterCandidates(){
    setState(() {
      filteredOptions = List.from(filteredOptions);
      filteredOptions = _poll.options.where(
        (o){ 
          return o.entity.fullName.toLowerCase().contains(_entityFilterController.text.toLowerCase());
        }).toList();
    });
  }

}
