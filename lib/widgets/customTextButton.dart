import 'package:flutter/material.dart';

Container customTextButton({
  required BuildContext context,
  required TextEditingController textController,
  required String buttonText,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
      color: Colors.grey.withOpacity(.3),
      width: 1.0,
    ))),
    child: TextButton(
      child: Text(
        buttonText,
        style: const TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context);
        textController.text = buttonText;
      },
    ),
  );
}

// ignore: must_be_immutable
class ListItem extends StatelessWidget {
  String name = "", position = "", date = "";
  ListItem(
      {Key? key, required this.name, required this.position, required this.date})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
            color: Colors.grey.withOpacity(0.1),
            width: 1.0,
          ))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,style: TextStyle(color:Colors.black,fontSize: 15),),
          const SizedBox(
            height: 5,
          ),
          Text(position,style:TextStyle(color:Colors.grey.withOpacity(.6),fontSize: 13)),
          const SizedBox(
            height: 5,
          ),
          Text(date,style:TextStyle(color:Colors.grey.withOpacity(.6),fontSize: 13)),
        ],
      ),
    );
  }
}
