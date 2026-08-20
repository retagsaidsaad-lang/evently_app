import 'package:flutter/material.dart';

import '../utiles/size_utiles.dart';

class DataOrTimeWidget extends StatelessWidget {
  final Widget icon ;
  final String dataOrTime ;
  final VoidCallback onChooseClick ;
  final String chooseDataOrTime ;
  const DataOrTimeWidget({super.key
    , required this.icon , required this.dataOrTime ,
    required this.onChooseClick , required this.chooseDataOrTime
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: context.width*0.02,
      children: [
        icon,
        Text(dataOrTime ,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Spacer(),
        TextButton(
            onPressed: onChooseClick,
            child: Text(chooseDataOrTime ,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                decoration: TextDecoration.underline,
                decorationColor: Theme.of(context).cardColor
              ),
            )
        ),
      ],
    );
  }
}
