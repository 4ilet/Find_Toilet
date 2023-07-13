import 'package:find_toilet/models/toilet_model.dart';
import 'package:find_toilet/screens/main_screen.dart';
import 'package:find_toilet/utilities/global_utils.dart';
import 'package:find_toilet/utilities/style.dart';
import 'package:find_toilet/utilities/type_enum.dart';
import 'package:find_toilet/widgets/search_bar.dart';
import 'package:find_toilet/widgets/silvers.dart';
import 'package:find_toilet/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  final String query;
  final ToiletModel? toiletModel;
  const Search({
    super.key,
    required this.query,
    this.toiletModel,
  });

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final scrollController = ScrollController();
  final cnt = 10;
  bool expandSearch = false;
  bool refreshState = true;
  final globalKey = GlobalKey<ScaffoldState>();

  late String selectedValue;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() async {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.9) {
          if (getPage(context) < getTotal(context)!) {
            if (!getWorking(context)) {
              setWorking(context, true);
              Future.delayed(const Duration(seconds: 3), () {
                if (!getAdditional(context)) {
                  setAdditional(context, true);
                  search();
                }
              });
            }
          }
        }
      });
    });
  }

  void firstSearch() {
    if (readLoading(context)) {
      getSearchList(context).then((_) {
        setHeightListSize(context);
        setLoading(context, false);
      });
      increasePage(context);
    }
  }

  void search() async {
    if (getAdditional(context)) {
      getSearchList(context).then((_) {
        setHeightListSize(context);
        setAdditional(context, false);
        setWorking(context, false);
      });
      increasePage(context);
    }
  }

  void changeExpandSearch() {
    setState(() {
      if (!expandSearch) {
        expandSearch = true;
      } else {
        expandSearch = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (refreshState) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          initLoadingData(context, isSearch: true);
          initSearchList(context);
          initHeightList(context);
          firstSearch();
          setKey(context, globalKey);
          setState(() {
            refreshState = false;
          });
        },
      );
    }
    return WillPopScope(
      onWillPop: () {
        removedRouterPush(context, page: const Main(needNear: true));
        return Future.value(false);
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          key: globalKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: mainColor,
          body: Padding(
            padding: EdgeInsets.only(top: statusBarHeight(context)),
            child: CustomBoxWithScrollView(
              toolbarHeight: expandSearch
                  ? isDefaultTheme(context)
                      ? 400
                      : 430
                  : isDefaultTheme(context)
                      ? 115
                      : 120,
              listScroll: scrollController,
              flexibleSpace: Column(
                children: [
                  CustomSearchBar(
                    isMain: false,
                    query: widget.query,
                    onSearchMode: changeExpandSearch,
                    refreshPage: () {
                      setState(() {
                        refreshState = true;
                      });
                    },
                  ),
                  topOfAppBar(),
                ],
              ),
              silverChild: [
                CustomSilverList(
                  showReview: false,
                  isMain: false,
                  isSearch: true,
                  data: searchToiletList(context),
                  refreshPage: () {
                    setState(() {
                      refreshState = true;
                    });
                  },
                  // refreshPage: search,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //* app bar 맨 윗 부분
  Padding topOfAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Flexible(
            child: CustomText(
              title: '검색 결과',
              fontSize: FontSize.largeSize,
              color: CustomColors.whiteColor,
              font: kimm,
            ),
          ),
        ],
      ),
    );
  }
}
