import { ethers } from 'ethers';

export class TestNetwork {
    public async doTest() {
        try {
            const abi = [
                'function readCreditHashes(bytes32 did) view returns (bytes32[] memory)',
                'function addCreditHash(bytes32 did, bytes32 hash)',
                'function addSimple(bytes32 did, bytes32 hash)',
                'function readSimple(bytes32 did) view returns (bytes32 memory)',
                'function readValue() view returns (string memory)',
                'function readNumber() view returns (int memory)',
            ];
            // const provider = ethers.getDefaultProvider('bob.test');
            const provider = new ethers.providers.JsonRpcProvider('http://127.0.0.1:8545');

            const privateKey = `12345678901234567890123456789012`;
            const etherWallet = new ethers.Wallet(ethers.utils.toUtf8Bytes(privateKey), provider);

            // const moneyWallet = new ethers.Wallet('0xfe3b557e8fb62b89f4916b721be55ceb828dbd73', provider);
            // const tx = {
            //     to: etherWallet.getAddress(),
            //     // ... or supports ENS names
            //     // to: "ricmoo.firefly.eth",
            //
            //     // We must pass in the amount as wei (1 ether = 1e18 wei), so we
            //     // use this convenience function to convert ether to wei.
            //     value: ethers.utils.parseEther('1.0')
            // };
            //
            // console.info(`sending money to etherWallet ${etherWallet.getAddress()}`);
            // const sentTx = await moneyWallet.sendTransaction(tx);

            const contractAddress = `0x0DCd2F752394c41875e259e00bb44fd505297caF`;
            const contract = new ethers.Contract(contractAddress, abi, provider);
            const signer = contract.connect(etherWallet);
            const did = ethers.utils.formatBytes32String('entry.did');
            const hash = ethers.utils.formatBytes32String('entry.getHash()');

            console.info('about to call addSimple');
            let transaction = await signer.addSimple(did, hash);
            console.info(`transaction: ${JSON.stringify(transaction)}`);
            await transaction.wait();

            console.info('about to call readNumber');
            transaction = await contract.readNumber();
            console.info(`transaction: ${transaction}`);

            console.info('about to call addCreditHash');
            transaction = await signer.addCreditHash(did, hash);
            console.info(`transaction: ${JSON.stringify(transaction)}`);
            await transaction.wait();

            console.info('about to call readCreditHashes');
            transaction = await contract.readCreditHashes(did);
            console.info(`transaction: ${transaction}`);

            console.info(`done`);
        } catch (e) {
            console.error(`error! ${e.message}`, e);
        }
    }
}


new TestNetwork().doTest();
