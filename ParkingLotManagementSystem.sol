// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ParkingLotManagementSystem {
    struct ParkingSpot {
        uint spotId;
        string location;
        bool isOccupied;
    }

    mapping(uint => ParkingSpot) public parkingSpots;
    mapping(address => mapping(uint => bool)) public reservedSpots;
    uint public spotCount;

    event SpotAdded(uint spotId, string location);
    event SpotReserved(address user, uint spotId);
    event SpotFreed(address user, uint spotId);

    function addParkingSpot(string memory location) public {
        require(bytes(location).length > 0, "Location cannot be empty");

        spotCount++;
        parkingSpots[spotCount] = ParkingSpot(spotCount, location, false);

        emit SpotAdded(spotCount, location);
    }

    function reserveParkingSpot(uint spotId) public {
        ParkingSpot storage spot = parkingSpots[spotId];

        // Ensure that the parking spot exists
        require(spot.spotId != 0, "Parking spot does not exist");

        // Ensure that the spot is not already reserved
        require(!spot.isOccupied, "Parking spot is already reserved");

        // Ensure that the user has not already reserved this spot
        require(!reservedSpots[msg.sender][spotId], "Parking spot already reserved by you");

        // Mark the spot as occupied and record the reservation
        spot.isOccupied = true;
        reservedSpots[msg.sender][spotId] = true;

        emit SpotReserved(msg.sender, spotId);
    }

    function freeParkingSpot(uint spotId) public {
        ParkingSpot storage spot = parkingSpots[spotId];

        // Ensure that the parking spot exists
        require(spot.spotId != 0, "Parking spot does not exist");

        // Ensure that the user has reserved this spot
        require(reservedSpots[msg.sender][spotId], "Parking spot was not reserved by you");

        // Mark the spot as free and remove the reservation
        spot.isOccupied = false;
        reservedSpots[msg.sender][spotId] = false;

        emit SpotFreed(msg.sender, spotId);
    }

    function attemptReserveParkingSpot(uint spotId) public {
        ParkingSpot storage spot = parkingSpots[spotId];

        // Check if the parking spot exists
        if (spot.spotId == 0) {
            revert("Parking spot does not exist");
        }

        // Check if the spot is already reserved
        if (spot.isOccupied) {
            revert("Parking spot is already reserved");
        }

        // Check if the user has already reserved this spot
        if (reservedSpots[msg.sender][spotId]) {
            revert("Parking spot already reserved by you");
        }

        // Mark the spot as occupied and record the reservation
        spot.isOccupied = true;
        reservedSpots[msg.sender][spotId] = true;

        emit SpotReserved(msg.sender, spotId);
    }

    function checkAvailability(uint spotId) public view returns (string memory location, bool isOccupied) {
        ParkingSpot storage spot = parkingSpots[spotId];

        // Ensure that the parking spot exists
        require(spot.spotId != 0, "Parking spot does not exist");

        // Return the parking spot details
        return (spot.location, spot.isOccupied);
    }

    // Internal function to ensure parking spot state consistency
    function internalCheck(uint spotId) internal view {
        ParkingSpot storage spot = parkingSpots[spotId];
        assert(spot.spotId > 0);  // Assert the spot ID should always be positive
        assert(spot.isOccupied == false || spot.isOccupied == true);  // Assert that isOccupied is either true or false
    }
}
