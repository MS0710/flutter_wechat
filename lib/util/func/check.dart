///判斷字符串是否為空
bool strNotEmpty(String? value){
  return value != null && value != "";
}
///是否網路路徑
bool isNetUrl(String? value){
  if(value == null){
    return false;
  }
  return value.startsWith("http");
}