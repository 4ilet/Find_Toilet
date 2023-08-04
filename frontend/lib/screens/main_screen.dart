import 'package:find_toilet/providers/state_provider.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/bottom_sheet.dart';
import 'package:find_toilet/widgets/box_container.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/map_widget.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Main extends StatefulWidget {
  final bool showReview, needNear;
  final ReturnVoid? refreshPage;
  final String? beforePage;
  const Main({
    super.key,
    this.showReview = false,
    this.refreshPage,
    this.needNear = true,
    this.beforePage,
  });

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final globalKey = GlobalKey<ScaffoldState>();
  double paddingTop = 0;
  bool refreshState = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (widget.showReview && !context.read<MainSearchProvider>().showAll) {
          changeShow(context);
        }
        setState(() {
          paddingTop = statusBarHeight(context);
        });
      },
    );
  }

  void refreshMain(int index) {
    if (readLoading(context)) {
      initPage(context);
      initHeightList(context);
      initMainData(
        context,
        showReview: widget.showReview,
        needClear: true,
      ).then((data) {
        setHeightListSize(context);
        setLoading(context, false);
      });
      increasePage(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (refreshState) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          initLoadingData(context, isMain: true);
          if (!widget.showReview) {
            initHeightList(context);
          }
          initMainData(
            context,
            showReview: widget.showReview,
            needClear: true,
          ).then((data) {
            if (!widget.showReview) {
              setHeightListSize(context);
            }
            setLoading(context, false);
          });
          increasePage(context);
          setKey(context, globalKey);
          setState(() {
            refreshState = false;
          });
        },
      );
    }
    return WillPopScope(
        onWillPop: widget.showReview
            ? () {
                context.read<MainSearchProvider>().removeMarker();
                routerPop(context)();
                return Future.value(false);
              }
            : () => exitApp(context),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            key: globalKey,
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(top: paddingTop),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: screenWidth(context),
                        height: screenHeight(context) - paddingTop,
                        child: MapScreen(
                          showReview: widget.showReview,
                          refreshPage: widget.refreshPage,
                          needNear: widget.needNear,
                        ),
                      ),
                    ],
                  ),
                  if (!widget.showReview && showAll(context))
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: Column(
                        children: [
                          FilterBox(
                            onPressed: refreshMain,
                            applyLong: !isDefaultTheme(context),
                            isMain: true,
                          ),
                        ],
                      ),
                    ),
                  if (showAll(context))
                    ToiletBottomSheet(
                        showReview: widget.showReview,
                        refreshPage: () {
                          if (widget.refreshPage != null) {
                            widget.refreshPage!();
                          }
                          setState(() {
                            refreshState = true;
                          });
                        }),
                  if (showAll(context))
                    CustomSearchBar(
                        isMain: true,
                        showReview: widget.showReview,
                        refreshPage: () {
                          if (widget.refreshPage != null) {
                            widget.refreshPage!();
                          }
                          setState(() {
                            refreshState = true;
                          });
                        }),
                  if (watchPressed(context))
                    Center(
                      child: CustomBox(
                        height: 80,
                        width: isDefaultTheme(context) ? 300 : 350,
                        color: const Color.fromRGBO(0, 0, 0, 0.6),
                        child: const Center(
                          child: CustomText(
                            title: '뒤로 가기 버튼을 한 번 더\n누르시면 앱이 종료됩니다',
                            isCentered: true,
                            color: CustomColors.whiteColor,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ));
  }
}
