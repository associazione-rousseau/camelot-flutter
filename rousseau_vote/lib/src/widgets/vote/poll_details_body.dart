
import 'package:flutter/cupertino.dart';
import 'package:rousseau_vote/src/models/poll.dart';

class PollDetailsBody extends StatelessWidget {
  const PollDetailsBody(this._poll);

  final Poll _poll;

  @override
  Widget build(BuildContext context) {
    return Text(_poll.title);
  }
}