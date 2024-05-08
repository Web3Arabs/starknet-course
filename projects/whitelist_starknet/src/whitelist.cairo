use starknet::ContractAddress;

#[starknet::interface]
trait IWhitelist<TContractState> {
  fn add_address_to_whitelist(ref self: TContractState);
  fn check_address(self: @TContractState, address: ContractAddress) -> bool;
  fn get_num_addresses(self: @TContractState) -> u128;
  fn get_max_addresses(self: @TContractState) -> u128;
}

#[starknet::contract]
mod Whitelist {
  use starknet::{ContractAddress, get_caller_address};

  #[storage]
  struct Storage {
    whitelistedAddresses: LegacyMap<ContractAddress, bool>,
    maxWhitelistedAddresses: u128,
    numAddressesWhitelisted: u128,
  }

  #[constructor]
  fn constructor(ref self: ContractState, _maxWhitelistedAddresses: u128) {
    self.maxWhitelistedAddresses.write(_maxWhitelistedAddresses);
  }

  #[abi(embed_v0)]
  impl WhitelistImpl of super::IWhitelist<ContractState> {
    fn add_address_to_whitelist(ref self: ContractState) {
      assert(
        self.whitelistedAddresses.read(get_caller_address()) == false, 
        'Address has already added'
      );
      assert(
        self.numAddressesWhitelisted.read() < self.maxWhitelistedAddresses.read(),
        'Addresses limit reached'
      );

      self.whitelistedAddresses.write(get_caller_address(), true);

      let numAddresses: u128 = self.numAddressesWhitelisted.read();
      self.numAddressesWhitelisted.write(numAddresses + 1);
    }

    fn check_address(self: @ContractState, address: ContractAddress) -> bool {
      self.whitelistedAddresses.read(address)
    }

    fn get_num_addresses(self: @ContractState) -> u128 {
      self.numAddressesWhitelisted.read()
    }

    fn get_max_addresses(self: @ContractState) -> u128 {
      self.maxWhitelistedAddresses.read()
    }
  }
}
