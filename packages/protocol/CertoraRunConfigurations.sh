# Run bonded deposits simple
cp certora_verify.json.bonded certora_verify.json
certoraRun.py specs/harnesses/LockedGoldHarness.sol --solc solc-5.10.exe --settings -assumeUnwindCond

# Run bonded deposits linked
cp certora_verify.json.bonded.linked certora_verify.json
certoraRun.py specs/harnesses/RegistryHarness.sol specs/harnesses/LockedGoldHarness.sol --solc solc-5.10.exe --link LockedGoldHarness:registry=RegistryHarness --settings -assumeUnwindCond

# Run governance simple
cp certora_verify.json.govern certora_verify.json
#certoraRun.py contracts/governance/IntegerSortedLinkedList.sol specs/harnesses/GovernanceHarness.sol --solc solc-5.10.exe --link GovernanceHarness:queue=IntegerSortedLinkedList --settings -assumeUnwindCond

certoraRun.py contracts/common/linkedlists/IntegerSortedLinkedList.sol specs/harnesses/RegistryHarness.sol specs/harnesses/GovernanceHarness.sol --solc solc-5.10.exe --link GovernanceHarness:queue=IntegerSortedLinkedList GovernanceHarness:registry=RegistryHarness  --settings -assumeUnwindCond

# certoraRun.py contracts/governance/IntegerSortedLinkedList.sol specs/harnesses/RegistryHarness.sol specs/harnesses/GovernanceHarness.sol --solc solc-5.10.exe --link GovernanceHarness:queue=IntegerSortedLinkedList GovernanceHarness:registry=RegistryHarness --settings -assumeUnwindCond

# Run lists
cp certora_verify.json.list certora_verify.json
certoraRun.py specs/harnesses/SortedListCheck.sol specs/harnesses/IntegerSortedListCheck.sol specs/harnesses/AddressSortedListCheck.sol --solc solc-5.10.exe


### NEW:
# Lists:
certoraBuild.py specs/harnesses/SortedListCheck.sol specs/harnesses/IntegerSortedListCheck.sol specs/harnesses/AddressSortedListCheck.sol --solc solc-5.10.exe --verify SortedListCheck:specs/list.spec IntegerSortedListCheck:specs/list.spec AddressSortedListCheck:specs/list.spec
java -jar $CERTORA/prover_cli.jar verify .


# Locked Gold:
certoraBuild.py specs/harnesses/LockedGoldHarness.sol --solc solc-5.10.exe --verify LockedGoldHarness:specs/locked_gold.spec --settings -assumeUnwindCond 
java -jar $CERTORA/prover_cli.jar verify .

# Governance:
certoraBuild.py contracts/common/linkedlists/IntegerSortedLinkedList.sol specs/harnesses/RegistryHarness.sol specs/harnesses/GovernanceHarness.sol --solc solc-5.10.exe --link GovernanceHarness:queue=IntegerSortedLinkedList GovernanceHarness:registry=RegistryHarness --verify GovernanceHarness:specs/governance.spec  --settings -assumeUnwindCond