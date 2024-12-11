enum Gift {
    Coal,
    Train,
    Bicycle,
  
    SuccessorToTheNintendoSwitch = Bicycle << Train,
    TikTokPremium = SuccessorToTheNintendoSwitch << Train,
    Vape = TikTokPremium << Train,
    Traditional = Train | Bicycle,
    OnTheMove = Coal | Bicycle | TikTokPremium | Vape,
    OnTheCouch = (OnTheMove & ~Bicycle) | SuccessorToTheNintendoSwitch,
  }
