import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:multilang/model/Column.dart' as SheetColumn;
import 'package:multilang/model/language.dart';
import 'package:multilang/multi_language_view_model.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MultiLanguagePage extends StatefulWidget {
  const MultiLanguagePage({Key? key}) : super(key: key);

  @override
  State<MultiLanguagePage> createState() => _MultiLanguagePageState();
}

class _MultiLanguagePageState extends State<MultiLanguagePage> {
  MultiLanguageViewModel model = MultiLanguageViewModel();

  // String key = "1IRY6EMSnckow7Hq3NTYrFHRax226NabY9VwUmcWzn4M";
  String key = "15Y4UjfgBtkJhSraAtudq_bpcGvjNoxtSUyDUekhQnB0";
  

  @override
  void initState() {
    model.initData(key);
    super.initState();
  }

  Widget getColumns() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        SheetColumn.Column col = model.columns[index];
        return Container(
          padding:
              const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
          child: Text("${col.id} ${col.label} | ${col.type} "),
        );
      },
      childCount: model.columns.length,
    ));
  }

  Widget getLanguages() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (BuildContext context, int index) {
        Language lang = model.languages[index];
        return Container(
          padding:
              const EdgeInsets.only(left: 16, top: 4, right: 16, bottom: 4),
          // child: Text("${lang.no}, ${lang.key}, "),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(TextSpan(
                  text: "${lang.no ?? "--"}, ",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.grey),
                  children: [
                    TextSpan(
                      text: lang.key ?? "--",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: Colors.grey[900]),
                    )
                  ])),
              Container(
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                child: Row(
                  children: [
                    lang.android
                        ? Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.only(
                                left: 8, top: 4, right: 8, bottom: 4),
                            decoration: const BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              "Android",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: Colors.white),
                            ),
                          )
                        : Container(),
                    lang.iOS
                        ? Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.only(
                                left: 8, top: 4, right: 8, bottom: 4),
                            decoration: const BoxDecoration(
                                color: Colors.deepOrange,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              "iOS",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: Colors.white),
                            ),
                          )
                        : Container(),
                    lang.format
                        ? Container(
                            width: 1,
                            margin: const EdgeInsets.only(right: 8),
                            height: 24,
                            color: Colors.grey,
                          )
                        : Container(),
                    lang.format
                        ? Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.only(
                                left: 8, top: 4, right: 8, bottom: 4),
                            decoration: const BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              "Keep format",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  ?.copyWith(color: Colors.white),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                child: Text(
                  "Vietnamese: ${lang.vietnamese}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.red),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                child: Text(
                  "English: ${lang.english}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.deepPurple),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                child: Text(
                  "Chinese: ${lang.chinese}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.black),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                child: Text(
                  "Korean: ${lang.korean}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.pink),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                child: Text(
                  "Japanese: ${lang.japanese}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.orange),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                child: Text(
                  "German: ${lang.german}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.green),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                child: Text(
                  "French: ${lang.french}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(color: Colors.blue),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: double.infinity,
                height: 1,
                color: Colors.grey,
              )
            ],
          ),
        );
      },
      childCount: model.languages.length,
    ));
  }

  void exportAndroid(String code) {
    model
        .exportForAndroid(code)
        .then((value) => {
              Share.shareFiles(
                [value],
                subject: "Language Android",
                text: "$code",
                mimeTypes: ["*/*"],
              )
            })
        .onError((error, stackTrace) => {});
  }

  void exportIOS(String code) {
    model
        .exportForIOS(code)
        .then((value) => {
              Share.shareFiles(
                [value],
                subject: "Language iOS",
                text: "$code",
                mimeTypes: ["*/*"],
              )
            })
        .onError((error, stackTrace) => {});
  }

  Widget getLanguageWidget(String language, String code) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language, style: Theme.of(context).textTheme.subtitle2),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    exportAndroid(code);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: const Text("Android")),
              SizedBox.fromSize(
                size: const Size(16, 16),
              ),
              ElevatedButton(
                  onPressed: () {
                    exportIOS(code);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("iOS")),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MultiLanguage"),
      ),
      body: ChangeNotifierProvider.value(
        value: model,
        child: Consumer<MultiLanguageViewModel>(
          builder: (context, builder, child) {
            return Center(
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(
                  //       left: 16, top: 16, right: 16, bottom: 8),
                  //   child: Text(model.name),
                  // ),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              model.initData(key);
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF3366)),
                            child: const Text("Refresh")),
                        SizedBox.fromSize(
                          size: const Size(16, 16),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, top: 8, right: 16, bottom: 8),
                    child: Text(
                        "${model.columns.length} columns, ${model.languages.length} rows"),
                  ),
                  model.loading
                      ? Container(
                          margin: const EdgeInsets.all(16),
                          child: const CupertinoActivityIndicator(),
                        )
                      : Container(),
                  Expanded(
                      child: CustomScrollView(
                    slivers: [
                      // SliverToBoxAdapter(
                      //   child: Text(model.rawData),
                      // )
                      // getColumns(),
                      getLanguages(),
                    ],
                  )),
                  model.loading
                      ? Container()
                      : SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              getLanguageWidget(
                                  "Tiếng Việt", Language.languageVietnamese),
                              getLanguageWidget(
                                  "English", Language.languageEnglish),
                              getLanguageWidget(
                                  "Tiếng Trung", Language.languageChinese),
                              getLanguageWidget(
                                  "Tiếng Hàn", Language.languageKorean),
                              getLanguageWidget(
                                  "Tiếng Nhật", Language.languageJapanese),
                              getLanguageWidget(
                                  "Tiếng Đức", Language.languageGerman),
                              getLanguageWidget(
                                  "Tiếng Pháp", Language.languageFrench),
                            ],
                          ),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
