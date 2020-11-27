
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
      case '7': return "金牌月嫂"; break;
      case '8': return "月子管家"; break;
      case '11': return "铜牌月子管家"; break;
      case '12': return "银牌月子管家"; break;
      case '13': return "金牌月子管家"; break;
      default: return "月嫂"; break;
    }
  }

  /* 育婴师等级名称转换 */
  static String getYuyingLevel(String level, {String type = '0'}) {
    return getYuyingFirst(level) + getYuyingCareType(type);
  }

  /* 育婴师等级转换 */
  static String getYuyingFirst(String level) {
    switch (level) {
      case '2': return "二星"; break;
      case '3': return "三星"; break;
      case '4': return "四星"; break;
      case '5': return "五星"; break;
      case '6': return "六星"; break;
      case '7': return "金牌"; break;
      case '8': return "钻石"; break;
      default: return ""; break;
    }
  }

  /* 育婴师类型转换 */
  static String getYuyingCareType(String type) {
    switch (type) {
      case '1': return "育婴护理师"; break;
      case '2': return "育儿护理师"; break;
      case '3': return "幼儿护理师"; break;
      default: return "育婴师"; break;
    }
  }

  /*育婴师等级转换*/
}