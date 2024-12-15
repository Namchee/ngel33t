type TrimLeft<T extends string> = T extends `-${infer Rest}` ? TrimLeft<Rest> : T;
type TrimRight<T extends string> = T extends `${infer Rest}-` ? TrimRight<Rest> : T;

type GetRouteHelper<
  S extends string,
  Count extends any[] = [],
  Result extends any[] = []
> = S extends ''
  ? Count
  : S extends `-${infer Rest}`
    ? GetRouteHelper<Rest, [...Count, 0], Result>
    : S extends `${infer Segment}-${infer Rest}`
      ? GetRouteHelper<Rest, [0], [...Result, [Segment, Count['length']]]>
      : S extends `${infer Segment}`
        ? [...Result, [Segment, Count['length']]]
        : Result;

type GetRoute<T extends string> = GetRouteHelper<TrimLeft<TrimRight<T>>>;
