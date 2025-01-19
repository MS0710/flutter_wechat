import 'package:intl/intl.dart';

class MyDate{
  ///一個小時內,顯示xx分鐘前
  ///小於24小時,顯示xx小時前
  ///間格超過24小時,顯示昨天xx:xx
  ///間格超過48小時,顯示xx月xx日 xx:xx
  ///間格超過1年,顯示xxxx年xx月xx日 xx:xx
  static String recentTime(int? timeStamp){
    if(timeStamp==null){
      return "未知";
    }

    DateTime now = DateTime.now();
    DateTime realTime = DateTime.fromMillisecondsSinceEpoch(timeStamp*1000);
    Duration def = now.difference(realTime);
    String defFormat = 'yyyy年mm月dd日 HH:mm:ss';
    String defStr = formatTimeStampToString(timeStamp,defFormat);
    if(def.inDays > 365){
      return defStr;
    }else if(def.inHours > 48){
      String hoursFormat = 'mm月dd日 HH:mm:ss';
      String hoursStr = formatTimeStampToString(timeStamp,hoursFormat);
      return hoursStr;
    }else if(def.inDays >= 1 || def.inHours>=24){
      String _format = '昨天HH:mm';
      String _str = formatTimeStampToString(timeStamp,_format);
      return _str;
    }else if(def.inMinutes <= 1 || def.inSeconds<=60){
      String _format = 'HH:mm';
      String _str = formatTimeStampToString(timeStamp,_format);
      return "剛剛$_str";
    }else if(def.inHours <= 1 || def.inMinutes<=60){
      return "${def.inMinutes}分鐘前";
    }else if(def.inHours <= 24 || def.inDays==0){
      return "${def.inHours}小時前";
    }

    return defStr;
  }

  ///時間格式轉換
  ///單位秒
  static String formatTimeStampToString(int timeStamp,[String? format]){
    format ??= 'yyyy-mm-dd HH:mm:ss';
    DateFormat dateFormat = DateFormat(format);
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timeStamp*1000);
    return dateFormat.format(dateTime);
  }
}