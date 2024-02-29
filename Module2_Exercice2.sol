// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract DecentralizedVotingSystem{
    // Define the struct
    struct Candidate{
        uint id;
        string name;
        uint voteCount;
    }

    event CandidateEvent(uint id, string name, uint voteCount);
    uint256 counter;
    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;
    uint public candidatesCount;
    uint[] public idsArray;

    function addCandidate(string memory _name) public {
        incrementCounter();
        uint currentId = getCounter();
        // Create a new candidate and store it in the mapping
        candidates[currentId] = Candidate(currentId, _name, 0);
        emit CandidateEvent(currentId, _name, 0); // Emitting event here
    }

    function incrementCounter() public {
        counter += 1; // Increment the counter by 1
    }

    function getCounter() public view returns (uint) {
        return counter; // Return the current value of counter
    }


    function vote(uint _candidateId) public {
        // Require that the voter hasn't voted before
        require(!hasVoted[msg.sender], "You have already voted.");

        // Require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");

        // Record that voter has voted
        hasVoted[msg.sender] = true;

        // Update candidate vote Count
        candidates[_candidateId].voteCount += 1;

        // Emitting an event here (if you have an event defined) would be a good practice
    }

}
