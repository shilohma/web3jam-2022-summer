import OverluDNA from 0xOverluDNA

transaction(id: UInt64, energy: UFix64) {
    let minter: &OverluDNA.NFTMinter

    prepare(signer: AuthAccount) {
        self.minter = signer
        .borrow<&OverluDNA.NFTMinter>(from: OverluDNA.MinterStoragePath)
        ?? panic("Signer is not the nft admin")
    }

    execute {
        self.minter.addEnergy(id: id, energy: energy)
    }
}
 