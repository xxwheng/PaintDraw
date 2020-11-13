
/*月嫂 育婴师等级转换*/
class YsLevel {

  /*月嫂等级转换*/
  static String getYuesaoLevel(String level) {
    switch (level) {
      case '1': return "一星月嫂"; break;
      case '2': return "二星月嫂"; break;
      case '3': return "三星月嫂"; break;
      case '4': return "四星月嫂"; break;
      case '5': return "五星月嫂"; break;
      case '6': return "六星月嫂"; break;
      case '7': return "金牌星月嫂"; break;
      case '8': return "月子管家"; break;
      case '11': return "铜牌月子管家"; break;
      case '12': return "银牌月子管家"; break;
      case '13': return "金牌月子管家"; break;
      default: return ""; break;
    }
  }

  /*育婴师等级转换*/
}