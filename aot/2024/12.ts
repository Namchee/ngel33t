type NaughtyOrNice<
    T extends string,
    Curr extends 'naughty' | 'nice' = 'naughty'
> = T extends `${infer _}${infer Rest}`
	? NaughtyOrNice<Rest, Curr extends 'naughty' ? 'nice' : 'naughty'>
	: Curr;

type FormatNames<T extends [string, string, string][]> = {
	[Key in keyof T]: {
		name: T[Key][0];
		count: T[Key][2] extends `${infer Num extends number}` ? Num : never;
		rating: NaughtyOrNice<T[Key][0]>;
	};
}
