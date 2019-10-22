import { ethers } from 'ethers';

export class TestNetwork {
    public async doTest() {
        try {
            const abi = [
                'function readCreditHashes(bytes32 did) view returns (bytes32[] memory)',
                'function addCreditHash(bytes32 did, bytes32 hash)',
            ];
            // const provider = ethers.getDefaultProvider('bob.test');
            const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545');

            const privateKey = `12345678901234567890123456789012`;
            const etherWallet = new ethers.Wallet(ethers.utils.toUtf8Bytes(privateKey), provider);

            const contractAddress = `0x0DCd2F752394c41875e259e00bb44fd505297caF`;
            const contract = new ethers.Contract(contractAddress, abi, provider);
            const signer = contract.connect(etherWallet);
            const did = ethers.utils.formatBytes32String('entry.did');
            const hash = ethers.utils.formatBytes32String('entry.getHash()');

            console.info('about to call addCreditHash');
            const transaction = await signer.addCreditHash(did, hash);
            console.info('awaiting transaction');
            await transaction.wait();
            console.info(`done`);
        } catch (e) {
            console.error(`error! ${e.message}`);
        }
    }
}


new TestNetwork().doTest();
