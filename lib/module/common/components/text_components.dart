import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifiedText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? size;

  const ModifiedText({Key? key, required this.text, this.color, this.size})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(color: color, fontSize: size),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
