import 'package:flutter/material.dart';
import 'package:lojong_flutter_inspiracoes/core/const/text_styles.dart';

// TODO: Otimizar
// ignore: must_be_immutable
class SectionSelectionWidget extends StatefulWidget {
  final Function(int value) onSelected;
  int selected;

  SectionSelectionWidget({
    super.key,
    required this.onSelected,
    this.selected = 0,
  });

  @override
  State<SectionSelectionWidget> createState() => _SectionSelectionWidgetState();
}

class _SectionSelectionWidgetState extends State<SectionSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 40,
        color: Color.fromARGB(0xFF, 196, 119, 118),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5),
          child: Row(children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.selected = 0;
                    widget.onSelected(widget.selected);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: widget.selected == 0
                        ? Colors.white
                        : Colors.transparent,
                    height: 30,
                    child: Center(
                      child: Text(
                        'VÍDEOS',
                        textAlign: TextAlign.center,
                        style: widget.selected == 0
                            ? BrandTextStyles.selectedButton
                            : BrandTextStyles.unselectedButton,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.selected = 1;
                    widget.onSelected(widget.selected);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: widget.selected == 1
                        ? Colors.white
                        : Colors.transparent,
                    height: 30,
                    child: Center(
                      child: Text(
                        'ARTIGOS',
                        textAlign: TextAlign.center,
                        style: widget.selected == 1
                            ? BrandTextStyles.selectedButton
                            : BrandTextStyles.unselectedButton,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //     child: Text(
            //   'ARTIGOS',
            //   textAlign: TextAlign.center,
            // )),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    widget.selected = 2;
                    widget.onSelected(widget.selected);
                  });
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    color: widget.selected == 2
                        ? Colors.white
                        : Colors.transparent,
                    height: 30,
                    child: Center(
                      child: Text(
                        'CITAÇÕES',
                        textAlign: TextAlign.center,
                        style: widget.selected == 2
                            ? BrandTextStyles.selectedButton
                            : BrandTextStyles.unselectedButton,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Expanded(
            //     child: Text(
            //   'CITAÇÕES',
            //   textAlign: TextAlign.center,
            // )),
          ]),
        ),
      ),
    );
  }
}
