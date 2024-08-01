use starknet::ContractAddress;

#[starknet::interface]
trait ILesson<TContractState> {
    fn get(self: @TContractState) -> u128;
    fn set(ref self: TContractState, _number: u128);
    fn get_map(self: @TContractState, _address: ContractAddress) -> felt252;
    fn set_map(ref self: TContractState, _address: ContractAddress, _name: felt252);
}

#[starknet::contract]
mod Lesson1 {
    use super::ILesson;
    use starknet::ContractAddress;
    use starknet::storage::{Map, StoragePathEntry};

    #[storage]
    struct Storage {
        storedData: u128,
        myMap: Map::<ContractAddress, felt252>,
    }

    #[constructor]
    fn constructor(ref self: ContractState, _value: u128) {
        self.storedData.write(_value);
    }

    #[abi(embed_v0)]
    impl LessonImpl of ILesson<ContractState> {
        fn get(self: @ContractState) -> u128 {
            self.storedData.read()
        }

        fn set(ref self: ContractState, _number: u128) {
            self.storedData.write(_number);
        }

        fn get_map(self: @ContractState, _address: ContractAddress) -> felt252 {
            self.myMap.read(_address)
        }

        fn set_map(ref self: ContractState, _address: ContractAddress, _name: felt252) {
            self.myMap.write(_address, _name);
        }
    }
}
