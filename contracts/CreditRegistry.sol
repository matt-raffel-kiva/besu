pragma solidity ^0.5.11;

    /*
     * Note that Solidity can't return an array of strings :(
     * https://solidity.readthedocs.io/en/v0.4.21/frequently-asked-questions.html#is-it-possible-to-return-an-array-of-strings-string-from-a-solidity-function
     * So rather than allow arbitrary lengthed strings for DIDs and hashes we use a fixed size bytes32. This is the largest native bype size in solidity
     * so if we find that we need more, we will have to come up with another solution.
     */
contract CreditRegistry {
    
    mapping(bytes32 => bytes32[]) registry;
    
    /**
     * Appends the credit hash to the credit array associated with the given DID
     */ 
    function addCreditHash(bytes32 did, bytes32 hash) public {
        if (registry[did].length == 0) {
            registry[did] = [hash];
        } else {
            registry[did].push(hash);
        }
    }
    
    /**
     * Reads all the credit hashes associated with the given did
     * TODO we also want to keep track of each credit read PRO-798
     */
    function readCreditHashes(bytes32 did) public view returns (bytes32[] memory) {
        return registry[did];
    }
}
