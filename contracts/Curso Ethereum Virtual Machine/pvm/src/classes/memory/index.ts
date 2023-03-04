import { OffsetValueError, InvalidMemoryOffset, InvalidMemoryValue} from "./errors";
import { MAX_UINT256 } from "../../constants";
import { hexlify } from "@ethersproject/bytes";

class Memory {

    private memory: bigint[];

    constructor() {
        this.memory = [];
    }

    public store(_offset:bigint, _value:bigint): void {
        if(_offset < 0 || _offset > MAX_UINT256) throw new InvalidMemoryOffset(_offset,_value);
        if(_value < 0 || _value > MAX_UINT256) throw new InvalidMemoryValue(_offset,_value);
    
        this.memory[Number(_offset)] = _value; //Its possible to increase the memory, but that implies a cost in gas
    }

    public load(_offset:bigint): bigint {

        if(_offset < 0 || _offset > MAX_UINT256) throw new InvalidMemoryOffset(_offset,BigInt(0)); //All not defined elements have the value 0

        if(_offset > this.memory.length) return BigInt(0);

        return this.memory[Number(_offset)];
    }

    public memoryExpansionCost(offset:bigint): bigint {

        const newMemoryCost = this.memoryCost(offset+BigInt(32));
        const lastMemoryCost = this.memoryCost(BigInt(this.memory.length));

        const cost = newMemoryCost - lastMemoryCost;

        return cost < 0 ? BigInt(0): cost;

    }

    private memoryCost(memorySize: bigint):bigint {

        const memoryByteSize = memorySize*BigInt(32);

        const memorySizeWord = (memoryByteSize+BigInt(31))/BigInt(32);

        return memorySizeWord**BigInt(2) /BigInt(512) + (BigInt(3)*memorySizeWord);
    }

    public print():void {
        console.log(
            "Memory:\t", 
            this.memory.map((_value) => hexlify(_value))
        );
    }
}

export default Memory;