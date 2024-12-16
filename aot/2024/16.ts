declare function DynamicParamsCurrying<T extends any[], R>(fn: (...args: T) => R):  
  T extends [] ? R :
    <P extends any[]>(...args: P) => 
      T extends [...P, ...infer Rest] ?
        ReturnType<typeof DynamicParamsCurrying<Rest, R>> :
      R;
