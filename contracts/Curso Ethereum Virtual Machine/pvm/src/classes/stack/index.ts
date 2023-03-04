import { IndexOutOfBounds, InvalidStackValue, StackOverflow, StackUnderflow } from "./errors";
import { MAX_UINT256 } from "../../constants";
import { hexlify } from "@ethersproject/bytes";

// Define a class named "stack" to represent a stack data structure
class Stack {
    // Declare a private instance variable "maxDepth" to represent the maximum number of items the stack can hold
    private readonly maxDepth;
    // Declare a private instance variable "stack" to represent the array used to store the stack items
    private stack: bigint[];

    // Define a constructor for the "stack" class that takes an optional parameter "_maxDepth" and sets "maxDepth" and "stack" variables
    constructor (_maxDepth = 1024) {
        this.maxDepth = _maxDepth;
        this.stack = [];
    }

    // Define a public function "push" that takes a big integer "value" as input and pushes it onto the stack
    public push(_value:bigint): void {
        // Check if the value is negative or greater than 2^256, and throw an error if it is
        if(_value < 0 || _value > MAX_UINT256) throw new InvalidStackValue (_value);

        // Check if the stack is already at maximum capacity, and throw an error if it is
        if(this.stack.length + 1 > this.maxDepth) throw new StackOverflow ();

        // Push the value onto the stack
        this.stack.push(_value);
    }

    // Define a public function "pop" that removes and returns the top item from the stack
    public pop(): bigint {
        // Remove the top item from the stack and store it in a variable "value"
        const value = this.stack.pop();

        // If "value" is undefined, the stack was already empty, so throw an error
        if (value == undefined) throw new StackUnderflow();

        // Return the removed value
        return value;
    }

    public duplicate(index:number): void {
        const value = this.stack[this.toStackIndex(index)];
        if(value == undefined) throw new IndexOutOfBounds();
        this.stack.push(value);
    }

    private toStackIndex(index:number) {
        return this.stack.length - index;
    }

    public swap(indexA:number, indexB:number): void {
 
        const a = this.getAtIndex(indexA);
        const b = this.getAtIndex(indexB);

        this.setAtIndex(indexA,b);
        this.setAtIndex(indexB,a);
    }

    public getAtIndex(index:number): bigint {
        const adjustedIndex = this.toStackIndex(index);
        const value = this.stack[adjustedIndex];
        if(value===undefined) throw new IndexOutOfBounds();
        return value;
    }

    public setAtIndex(index:number, value: bigint) {
        this.stack[this.toStackIndex(index)] = value;
    }

    public print():void {
        console.log(
            "Stack:\t", 
            this.stack.map((_value) => hexlify(_value))
        );
    }
}

export default Stack;