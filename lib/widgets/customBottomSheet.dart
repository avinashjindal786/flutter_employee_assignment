
import 'package:flutter/material.dart';

import 'customTextButton.dart';

void showMyModalBottomSheet(
      BuildContext context, TextEditingController textController) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                customTextButton(context:context,textController:textController,buttonText: 'Product Designer'),
                customTextButton(context:context,textController:textController,buttonText: 'Flutter Developer' ),
                customTextButton(context:context,textController:textController,buttonText: 'QA Tester' ),
                customTextButton(context:context,textController:textController,buttonText: 'Product Owner'),
              ],
            ),
          ),
        );
      },
    );
  }
  
  void showMyModalBottomSheetForCurrentEmployee(
      BuildContext context, TextEditingController textController) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 100,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                customTextButton(context:context,textController:textController,buttonText: 'Yes'),
                customTextButton(context:context,textController:textController,buttonText: 'No' ),
  
              ],
            ),
          ),
        );
      },
    );
  }