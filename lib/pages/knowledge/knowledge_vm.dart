import 'package:flutter/cupertino.dart';
import 'package:wan_android_flutter/repository/api.dart';

import '../../repository/datas/knowledge_data.dart';

class KnowledgeViewModel with ChangeNotifier {
  List<KnowledgeData>? knowledgeList;

  ///获取体系列表数据
  Future getKnowledgeList() async {
    var value = await Api.instance.getKnowledgeList();
    print("getKnowledgeList length = ${value?.length}");
    knowledgeList = value ?? [];
    notifyListeners();
  }

  String generalSubTitle(List<KnowledgeChildren>? childrenList){
    if(childrenList == null || childrenList.isEmpty == true){
      return "";
    }

    StringBuffer stringBuffer = StringBuffer("");
    for (var value in childrenList) {
      stringBuffer.write("${value.name}  ");
    }
    return stringBuffer.toString();
  }
}
