      ******************************************************************
      * Common status and reason codes – single source of truth
      ******************************************************************
       01  COMM-STATUS-CODES.
           05  STAT-OK                   PIC X(2) VALUE "00".
           05  STAT-BUSINESS-REJECT      PIC X(2) VALUE "01".
           05  STAT-TECHNICAL-ERROR      PIC X(2) VALUE "99".
           05  STAT-TIMEOUT              PIC X(2) VALUE "98".
           05  STAT-DUPLICATE            PIC X(2) VALUE "94".

       01  COMM-REASON-CODES.
           05  RSN-INVAMT                PIC X(10) VALUE "INVAMT    ".
           05  RSN-INVCARD               PIC X(10) VALUE "INVCARD   ".
           05  RSN-PINFAIL               PIC X(10) VALUE "PINFAIL   ".
           05  RSN-LIMITEXC              PIC X(10) VALUE "LIMITEXC  ".
           05  RSN-PROXYNF               PIC X(10) VALUE "PROXYNF   ".
           05  RSN-HSMOUT                PIC X(10) VALUE "HSMOUT    ".
           05  RSN-LEDGFAIL              PIC X(10) VALUE "LEDGFAIL  ".
           05  RSN-MACFAIL               PIC X(10) VALUE "MACFAIL   ".