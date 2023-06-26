
module me::sample_store {
    use std::error;
    use std::signer;
    use std::string::String;

    const ENOT_PUBLISHED: u64 = 1;

    struct SampleStore has key {
        str: String,
    }

    // read a string from `SampleStore`
    #[view]
    public fun read(addr: address): String acquires SampleStore {
        assert!(exists<SampleStore>(addr), error::not_found(ENOT_PUBLISHED));
        let sample_store = borrow_global<SampleStore>(addr);
        return sample_store.str
    }

    // write a string in `SampleStore`
    public entry fun write(account: &signer, str: String) acquires SampleStore {
        let addr = signer::address_of(account);

        if (!exists<SampleStore>(addr)) {
            move_to(account, SampleStore { str });
        } else {
            let sample_store = borrow_global_mut<SampleStore>(addr);
            sample_store.str = str;
        };
    }
}
