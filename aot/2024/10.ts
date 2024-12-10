enum Gift {
	Coal,
	Train,
	Bicycle,

	SuccessorToTheNintendoSwitch = Bicycle << 1,
	TikTokPremium = SuccessorToTheNintendoSwitch << 1,
	Vape = TikTokPremium << 1,
	Traditional = Train | Bicycle,
	OnTheMove = Coal | Bicycle | TikTokPremium | Vape,
	OnTheCouch = OnTheMove & ~Bicycle | SuccessorToTheNintendoSwitch,
};
