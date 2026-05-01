import 'package:flutter/material.dart';
import 'package:verademo_dart/utils/constants.dart';

class Comment extends StatelessWidget {
  final String text;
  final String user; 
  final String time;

  const Comment({super.key, required this.text, required this.user, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: VConstants.codeWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(text),

          Row(
            children: [
              Text(user),
              Text(" . "),
              Text(user),
            ],
          ),
        ],
        )
    );
  }
}

class CommentButton extends StatelessWidget {
  final Function()? onTap;
  const CommentButton({super.key, required this.onTap});

 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.comment,
        size: 24,
        color: VConstants.codeWhite,
      ),
    );
  }
}
