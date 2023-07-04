import 'package:flutter/material.dart';
import '../../../core/util/app_color.dart';

class ShowProfileDetailsComponent extends StatelessWidget {
  const ShowProfileDetailsComponent({Key? key,required this.text,required this.labelText}) : super(key: key);
final String text;
  final String labelText;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: Theme.of(context).textTheme.bodyText2,
          textAlign: TextAlign.start,
        ),
        Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: AppColors.darkGreyColor,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Text(text,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
      ],
    );


  }
}
