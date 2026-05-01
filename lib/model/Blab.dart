

import 'package:verademo_dart/model/Blabber.dart';

class Blab 
{
  final int id;
	final String content;
	final DateTime postDate;
	final int commentCount;
	final Blabber author;

  const Blab({
    required this.id,
    required this.content,
    required this.postDate,
    required this.commentCount,
    required this.author,
  });
}