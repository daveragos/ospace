String getWeatherIconFromCode(int wmoCode) {
  switch (wmoCode) {
    case 0:
      return 'assets/icons/clear-sky.png';
    case 1:
    case 2:
    case 3:
      return 'assets/icons/partly-cloudy.png';
    case 45:
    case 48:
      return 'assets/icons/fog.png';
    case 51:
    case 53:
    case 55:
    case 56:
    case 57:
      return 'assets/icons/drizzle.png';
    case 61:
    case 63:
    case 65:
    case 66:
    case 67:
    case 80:
    case 81:
    case 82:
      return 'assets/icons/rain.png';
    case 71:
    case 73:
    case 75:
    case 77:
    case 85:
    case 86:
      return 'assets/icons/snow.png';
    case 95:
    case 96:
    case 99:
      return 'assets/icons/storm.png';
    default:
      return 'assets/icons/partly-cloudy.png';
  }
}
