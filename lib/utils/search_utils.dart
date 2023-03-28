setSearchParam(String query) {
  List<String> caseSearchList = [];
  String temp = "";
  for (int i = 0; i < query.length; i++) {
    temp = temp + query[i];
    caseSearchList.add(temp);
  }
  return caseSearchList;
}