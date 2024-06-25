use starknet::ContractAddress;

#[starknet::interface]
trait ILesson2 <TContractState> {
    fn add_names(ref self: TContractState, _address: ContractAddress, _name: felt252);
    fn get_names(self: @TContractState, _address: ContractAddress) -> felt252;
    fn get_owner(self: @TContractState) -> Lesson2B::Person;
    fn transfer_owner(ref self: TContractState, _person: Lesson2B::Person);
}

#[starknet::contract]
mod Lesson2B {
    use starknet::ContractAddress;
    use starknet::get_caller_address;

    #[storage]
    struct Storage {
        names: LegacyMap<ContractAddress, felt252>,
        owner: Person,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        Person: Person,
    }

    #[derive(Drop, Copy, Serde, starknet::Store, starknet::Event)]
    struct Person {
        address: ContractAddress,
        name: felt252,
        age: u128
    }</TContractState>

    #[constructor]
    fn constructor(ref self: ContractState, _address: ContractAddress) {
        self.owner.write(Person { address: _address, name: 'KH', age: 20 });
        self.emit(Person { address: _address, name: 'KH', age: 20 });
    }

    #[abi(embed_v0)]
    impl Lesson2Impl of super::ILesson2 <ContractState> {
        fn add_names(ref self: ContractState, _address: ContractAddress, _name: felt252) {
            self.names.write(_address, _name);
        }

        fn get_names(self: @ContractState, _address: ContractAddress) -> felt252 {
            self.names.read(_address)
        }

        fn get_owner(self: @ContractState) -> Person {
            self.owner.read()
        }

        fn transfer_owner(ref self: ContractState, _person: Person) {
            assert!(get_caller_address() == self.owner.read().address);
            self.owner.write(_person);
            self.emit(Person { address: _person.address, name: _person.name, age: _person.age });
        }
    }
}
