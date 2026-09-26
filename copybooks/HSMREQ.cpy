* Exact contract
       01  HSM-REQUEST.
           05  HSM-COMMAND              PIC X(2).
               88  CMD-PIN-VERIFY       VALUE "PV".
               88  CMD-PIN-TRANSLATE    VALUE "PT".
               88  CMD-ARQC-VERIFY-ARPC VALUE "AC".
               88  CMD-MAC-VERIFY       VALUE "MV".
           05  HSM-KEY-SPEC.
               10  KEY-LABEL-OR-INDEX   PIC X(16).
               10  KEY-SCHEME           PIC X(1).
           05  HSM-PIN-BLOCK.
               10  PIN-BLOCK-FORMAT     PIC X(2).
               10  ENCRYPTED-PIN-BLOCK  PIC X(16).
               10  KSN                  PIC X(20).   *> mandatory for DUKPT
           05  HSM-PAN-DATA.
               10  PAN-LAST-12          PIC X(12).
               10  PAN-LENGTH           PIC 9(2).
           05  HSM-EMV-DATA.
               10  ARQC                 PIC X(16).
               10  ATC                  PIC X(4).
               10  UNPREDICTABLE-NUM    PIC X(8).
               10  TRANSACTION-DATA     PIC X(64).
           05  HSM-MAC-DATA.
               10  MAC-DATA             PIC X(1024).
               10  MAC-LENGTH           PIC 9(4).
               10  EXPECTED-MAC         PIC X(16).