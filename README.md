# Parking Lot Management System

This is a Solidity smart contract for a decentralized Parking Lot Management System. The contract allows users to add parking spots, reserve a parking spot, free a reserved spot, and check the availability of parking spots. It uses `require`, `revert`, and `assert` for error handling and state consistency.

## Features

- **Add Parking Spots**: Administrators can add parking spots with a unique ID and location.
- **Reserve Parking Spot**: Users can reserve an available parking spot.
- **Free Parking Spot**: Users can free a parking spot they have reserved.
- **Check Availability**: Users can check the availability of a specific parking spot.

## Contract Details

The contract includes the following data structures and events:

### Data Structures

- `struct ParkingSpot`
  - `uint spotId`: The unique ID of the parking spot.
  - `string location`: The location of the parking spot.
  - `bool isOccupied`: Indicates whether the parking spot is reserved.

### Mappings

- `mapping(uint => ParkingSpot) public parkingSpots`: Maps a parking spot ID to its details.
- `mapping(address => mapping(uint => bool)) public reservedSpots`: Tracks which user has reserved which parking spot.

### Events

- `event SpotAdded(uint spotId, string location)`: Emitted when a new parking spot is added.
- `event SpotReserved(address user, uint spotId)`: Emitted when a user reserves a parking spot.
- `event SpotFreed(address user, uint spotId)`: Emitted when a user frees a reserved parking spot.

## Functions

### `addParkingSpot(string memory location) public`

Adds a new parking spot with a given location. Increments the `spotCount`.

- **Require**: Location cannot be empty.
- **Emit**: `SpotAdded` event.

### `reserveParkingSpot(uint spotId) public`

Allows a user to reserve a parking spot if it's available.

- **Require**: The parking spot exists, is not already reserved, and the user has not reserved it before.
- **Emit**: `SpotReserved` event.

### `freeParkingSpot(uint spotId) public`

Allows a user to free a parking spot that they have reserved.

- **Require**: The parking spot exists, and the user has reserved it.
- **Emit**: `SpotFreed` event.

### `attemptReserveParkingSpot(uint spotId) public`

Attempts to reserve a parking spot. Uses `revert` for error handling instead of `require`.

- **Revert**: If the parking spot doesn't exist, is already reserved, or has already been reserved by the user.

### `checkAvailability(uint spotId) public view returns (string memory location, bool isOccupied)`

Checks and returns the availability of a specific parking spot.

- **Require**: The parking spot exists.

### `internalCheck(uint spotId) internal view`

An internal function to ensure the state consistency of the parking spot. Uses `assert` to verify the correctness of the internal state.

## Error Handling

- **`require`**: Used to validate inputs and conditions before executing logic.
- **`revert`**: Used for flow control and to cancel the transaction when conditions are not met.
- **`assert`**: Used internally to check for unexpected conditions that should never occur.

## Deployment

1. Install the necessary tools for Solidity development such as Truffle, Hardhat, or Remix.
2. Compile and deploy the contract on your desired blockchain (e.g., Ethereum, Binance Smart Chain, etc.).
3. Interact with the contract via a frontend, command line, or directly using tools like MetaMask or Remix.

## Example Usage

### Add a Parking Spot

```solidity
parkingLot.addParkingSpot("Location A");
