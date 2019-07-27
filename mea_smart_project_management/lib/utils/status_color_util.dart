class StatusColorUtil {
  static int getColorByStatus(String status) {
    switch (status) {
      case "1":
        return getColorHexFromStr('#217cc7');
        break;
      case "2":
        return getColorHexFromStr('#388e3c');
        break;
      case "3":
        return getColorHexFromStr('#f9a825');
        break;
      case "4":
        return getColorHexFromStr('#838383');
        break;
      case "5":
        return getColorHexFromStr('#e91e63');
        break;
      case "6":
        return getColorHexFromStr('#7b1fa2');
        break;
      case "7":
        return getColorHexFromStr('#1976d2');
        break;
      default:
        return hexToInt('#d32f2f');
    }
  }

  static int hexToInt(String hex) {
    int val = 0;
    int len = hex.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = hex.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("Invalid hexadecimal value");
      }
    }
    return val;
  }

  static int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  static String getMapColorByStatus(String status) {
    var pin_color = [
      '217cc7',
      '388e3c',
      'f9a825',
      '838383',
      'e91e63',
      '7b1fa2',
      '1976d2'
    ];
    var statusIndex = 0;
    if (status.isNotEmpty) {
      statusIndex = int.parse(status);
    }
    return pin_color[statusIndex];
  }
}
