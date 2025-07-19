/// Module: nft
module nft::nft {
    use std::string;
    use sui::event;

    public struct NFT has key, store {
        id: UID,
        name: string::String,
        description: string::String,
        url: string::String,
    }

    public struct NFTMinted has copy, drop {
        object_id: ID,
        creator: address,
        name: string::String,
    }

    public fun name(nft: &NFT): &string::String {
        &nft.name
    }

    public fun description(nft: &NFT): &string::String {
        &nft.description
    }

    public fun url(nft: &NFT): &string::String {
        &nft.url
    }

    public fun mint_nft(
        name: vector<u8>,
        description: vector<u8>,
        url: vector<u8>,
        ctx: &mut TxContext,
    ): NFT {
        let sender = ctx.sender();
        let nft = NFT {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
            url: string::utf8(url),
        };

        event::emit(NFTMinted {
            object_id: object::id(&nft),
            creator: sender,
            name: nft.name,  // Removed .clone() since string::String doesn't need it
        });

        nft  // Return the NFT for composability
    }

    public fun transfer(nft: NFT, recipient: address, _: &mut TxContext) {
        transfer::public_transfer(nft, recipient);
    }
}