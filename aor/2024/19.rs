use std::marker::PhantomData;

pub struct Empty;
pub struct Ready;
pub struct Flying;

pub struct Sleigh<State> {
    _state: PhantomData<State>,
}

impl Sleigh<Empty> {
    pub fn new() -> Self {
        Sleigh {
            _state: PhantomData,
        }
    }

    pub fn load(&self) -> Sleigh<Ready> {
        Sleigh {
            _state: PhantomData,
        }
    }
}

impl Sleigh<Ready> {
    pub fn take_off(&self) -> Sleigh<Flying> {
        Sleigh {
            _state: PhantomData,
        }
    }

    pub fn unload(&self) -> Sleigh<Empty> {
        Sleigh {
           _state: PhantomData,
        }
    }
}

impl Sleigh<Flying> {
    pub fn land(&self) -> Sleigh<Ready> {
        Sleigh {
            _state: PhantomData,
        }
    }
}
