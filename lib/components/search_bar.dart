import 'package:flutter/material.dart';
import 'package:student_care_app/resources/color_manager.dart';
import 'package:student_care_app/resources/styles_manager.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = StylesManager.regular14Black();
    final styleHint = StylesManager.regular16Grey();
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(20, 20, 15, 0),
      decoration: BoxDecoration(
        /* boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withOpacity(0.2),
            offset: Offset(0.0, 1), //(x,y)
            blurRadius: 5,
          ),
        ],*/
        borderRadius: BorderRadius.circular(15),
        color: ColorManager.lightGrey,
      ),
      child: TextField(
        textDirection: TextDirection.rtl,
        textAlignVertical: TextAlignVertical.center,
        // textAlign: TextAlign.end,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon:
              Icon(Icons.search, color: ColorManager.primary.withOpacity(0.8)),
          // prefixIcon: widget.text.isNotEmpty
          //     ? GestureDetector(
          //         child: Icon(Icons.close, color: style.color),
          //         onTap: () {
          //           controller.clear();
          //           widget.onChanged('');
          //           FocusScope.of(context).requestFocus(FocusNode());
          //         },
          //       )
          //     : null,
          hintText: widget.hintText,
          hintStyle: style,
          hintTextDirection: TextDirection.rtl,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
