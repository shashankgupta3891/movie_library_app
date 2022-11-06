import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifiedText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;
  final int maxLines;

  const ModifiedText(
      {Key? key, required this.text, this.color, this.size, this.maxLines = 2})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(color: color, fontSize: size),
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
    );
  }
}
