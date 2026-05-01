import 'package:intl/intl.dart';
import 'package:verademo_dart/model/Blabber.dart';

class Comment {
  final int commentid;
	final String content;
	final DateTime timestamp;
	final int blabid;
	final Blabber blabber;

  static DateFormat dateFormat = DateFormat("MMM d, y");

  const Comment({
    required this.commentid,
    required this.content,
    required this.timestamp,
    required this.blabid,
    required this.blabber,
  });

  getTimestampString() {
    return dateFormat.format(timestamp);
  }
}