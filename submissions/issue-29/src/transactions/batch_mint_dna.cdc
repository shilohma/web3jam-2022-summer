import NonFungibleToken from 0xNonFungibleToken
import MetadataViews from 0xMetadataViews
import OverluDNA from 0xOverluDNA

transaction(typeId: UInt64, count: UInt64, recipient: Address) {
    let minter: &OverluDNA.NFTMinter
    let receiver: &{NonFungibleToken.CollectionPublic}

    prepare(signer: AuthAccount) {
         self.minter = signer
        .borrow<&OverluDNA.NFTMinter>(from: OverluDNA.MinterStoragePath)
        ?? panic("Signer is not the nft admin")

        self.receiver = getAccount(recipient)
        .getCapability(OverluDNA.CollectionPublicPath)!
        .borrow<&{NonFungibleToken.CollectionPublic}>()
        ?? panic("Unable to borrow receiver reference")
    }

    execute {

        var idx: UInt64 = 0
        while idx < count {
            self.minter.mintNFT(
                typeId: typeId,
                recipient: self.receiver,
                name: "Overlu DNA",
                description: "",
                thumbnail: "",
                royalties: []
            )
            idx = idx + 1 as UInt64
        }
       

    }
}
