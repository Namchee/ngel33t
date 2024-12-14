type PerfReview<T> = T extends AsyncGenerator<infer Ret, infer _, infer _>
	? Ret
	: never;
