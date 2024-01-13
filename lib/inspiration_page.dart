import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logging/logging.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_colors.dart';
import 'package:lojong_flutter_inspiracoes/core/const/brand_text_styles.dart';
import 'package:lojong_flutter_inspiracoes/features/article/presentation/widgets/articles_list_widget.dart';
import 'package:lojong_flutter_inspiracoes/features/quote/presentation/widgets/quotes_list_widget.dart';
import 'package:lojong_flutter_inspiracoes/features/video/presentation/widgets/articles_list_widget.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:lojong_flutter_inspiracoes/shared/widget/section_selection_widget.dart';

final log = Logger('Logger');

class InspirationPage extends StatefulWidget {
  const InspirationPage({super.key});

  @override
  State<InspirationPage> createState() => _InspirationPageState();
}

class _InspirationPageState extends State<InspirationPage> {
  final swiperController = SwiperController();
  late SectionSelectionWidget sectionSelectionWidget;
  int selectedSwiperCard = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   sectionSelectionWidget =
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            //color: Color(0xFFE09090),
            color: BrandColors.inspirationBackGround,
            height: 110,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child:
                                SvgPicture.asset('assets/svg/back_lojong.svg')),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'INSPIRAÇÔES',
                        textAlign: TextAlign.center,
                        style: BrandTextStyles.unselectedButton,
                      ),
                    ),
                    const Expanded(child: Center()),
                  ],
                ),
              ),
              //Expanded(child: Text('INSPIRAÇÔES')),

              Padding(
                padding: EdgeInsets.all(10.0),
                // child: SectionSelectionWidget(
                //   onSelected: (value) {
                //     log.info('selected: $value');
                //     swiperController.move(value);
                //     setState(() {});
                //   },
                // ),
                child: Builder(
                  builder: (BuildContext context) {
                    log.info('rebuilding: $selectedSwiperCard');
                    sectionSelectionWidget = SectionSelectionWidget(
                      onSelected: (value) {
                        log.info('selected: $value');
                        swiperController.move(value);
                        setState(() {});
                      },
                      selected: selectedSwiperCard,
                    );
                    return sectionSelectionWidget;
                  },
                ),
              ),
              const Expanded(child: Center()),
            ]),
          ),
          //Expanded(child: const ArticlesListWidget()),
          Expanded(
            //flex: 65,
            child: Swiper.children(
              //pagination: const SwiperPagination(
              //    builder: SwiperPagination.fraction),
              //control: const SwiperControl(),
              controller: swiperController,
              children: const [
                VideoListWidget(),
                ArticlesListWidget(),
                QuotesListWidget(),
              ],
              onIndexChanged: (value) {
                log.info('onIndexChanged: $value');
                //sectionSelectionWidget.setSelected(value);
                selectedSwiperCard = value;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    ));
  }
}
