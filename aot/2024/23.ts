interface Base<T = unknown> {
    arg0: T;
    arg1: T;
  
    type: unknown;
  }
  
  type Apply<Fn extends Base, Arg> = (Fn & {
    arg0: Arg;
  })["type"];
  
  interface Cap extends Base<string> {
    type: Capitalize<this["arg0"]>
  }
  
  interface Push extends Base {
    arg1: this["arg0"];
    type: PushHelper<this["arg1"]>;
  }
  
  interface PushHelper<El> extends Base {
    type: this["arg0"] extends unknown[] ? [...this["arg0"], El] : never;
  }
  
  interface ApplyAll extends Base {
    arg1: this["arg0"];
    type: this["arg1"] extends Base ? ApplyAllHelper<this["arg1"]> : never;
  }
  
  interface ApplyAllHelper<Functor extends Base> extends Base {
    type: this["arg0"] extends unknown[] ? RealApplyAll<this["arg0"], Functor> : never;
  }
  
  type RealApplyAll<T extends unknown[], Functor extends Base> =
    T extends [infer El, ...infer Rest]
      ? [Apply<Functor, El>, ...RealApplyAll<Rest, Functor>]
      : [];
  
  interface Extends extends Base {
    arg1: this["arg0"];
    type: ExtendsHelper<this["arg1"]>;
  }
  
  interface ExtendsHelper<Target> extends Base {
    type: this["arg0"] extends Target ? true : false;
  }
  
  interface Filter extends Base {
    arg1: this["arg0"];
    type: this["arg1"] extends Base ? FilterHelper<this["arg1"]> : never;
  }
  
  interface FilterHelper<Criteria extends Base> extends Base {
    type: this["arg0"] extends unknown[] ? RealFilter<this["arg0"], Criteria> : never;
  }
  
  type RealFilter<T extends unknown[], U extends Base> = T extends [infer El, ...infer Rest]
    ? Apply<U, El> extends true
      ? [El, ...RealFilter<Rest, U>]
      : RealFilter<Rest, U>
    : [];
  