const Dex = artifacts.require("Dex");
const Link = artifacts.require("Link");
const TruffleAssert = artifacts.require("truffle-assertions");

contract("Dex", (accounts) => {
  it("should be only possible for owner to add tokens", async () => {
    let dex = await Dex.deployed();
    let link = await Link.deployed();
    await TruffleAssert.passes(
      dex.addToken(webe.utils.fromUtf8("Link"), link.address, {
        from: "accounts[0]",
      })
    );
  });
});
