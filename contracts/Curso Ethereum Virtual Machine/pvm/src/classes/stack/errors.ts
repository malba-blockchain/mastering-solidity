class InvalidStackValue extends Error {
    constructor(value: bigint) {
        super("Value ${value} is not valid");
    }
}

class StackOverflow extends Error {}

class StackUnderflow extends Error {}

class IndexOutOfBounds extends Error {}


export {InvalidStackValue, StackOverflow, StackUnderflow, IndexOutOfBounds};