const createStreetLight = <T>(colors: T[], defaultColor: T extends [] ? T[number] : T) => {
    console.log(colors);
    return defaultColor;
  }
  