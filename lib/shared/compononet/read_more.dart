import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helpy_app/shared/localization/translate.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(this.text,
      {Key? key, this.trimLines = 3, required this.textColor})
      : super(key: key);

  final String text;
  final int trimLines;
  final Color textColor;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    final colorClickableText = Colors.red[600];
    //final widgetColor = Colors.black;
    TextSpan link = TextSpan(
        text: _readMore
            ? mytranslate(context, "readmore")
            : mytranslate(context, "readless"),
        style: TextStyle(
          color: colorClickableText,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          style: const TextStyle(
            wordSpacing: 1,
            fontWeight: FontWeight.w600,
            fontSize: 16,
            height: 1,
          ),
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection
              .rtl, //better to pass this from master widget if ltr and rtl both supported
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int? endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: TextStyle(
              color: widget.textColor,
            ),
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
              text: widget.text, style: TextStyle(color: widget.textColor));
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
