      ******************************************************************
      * Canonical payment request – single contract for all rails
      ******************************************************************
       01  PAYMENT-REQUEST.
           05  REQ-ID                    PIC X(36).
           05  PAYMENT-RAIL              PIC X(10).
               88  RAIL-CARD             VALUE "CARD".
               88  RAIL-PAYSHAP          VALUE "PAYSHAP".
           05  AMOUNT-MINOR              PIC 9(15).
           05  CURRENCY-CODE             PIC X(3) VALUE "ZAR".
           05  PAYER-ACCOUNT             PIC X(34).
           05  PAYEE-ACCOUNT             PIC X(34).
           05  MERCHANT-REF              PIC X(35).
           05  TIMESTAMP                 PIC X(26).
           05  STAN                      PIC 9(6).
           05  RRN                       PIC X(12).
           05  TERMINAL-ID               PIC X(8).
           05  ACQUIRER-ID               PIC X(11).
           05  CARD-DATA.
               10  PAN-TOKEN             PIC X(19).
               10  EXPIRY                PIC X(4).
               10  ENTRY-MODE            PIC X(3).
               10  PIN-BLOCK             PIC X(16).
               10  KSN                   PIC X(20).
               10  ARQC                  PIC X(16).
               10  ATC                   PIC X(4).
           05  PAYSHAP-DATA.
               10  PROXY-TYPE            PIC X(8).
                   88  PROXY-MSISDN      VALUE "MSISDN".
                   88  PROXY-SHAPID      VALUE "SHAPID".
                   88  PROXY-ACCOUNT     VALUE "ACCOUNT".
               10  PROXY-VALUE           PIC X(40).
               10  RESOLVED-PARTICIPANT  PIC X(11).
               10  RESOLVED-ACCOUNT-TOKEN PIC X(34).
               10  DISPLAY-NAME-EVIDENCE PIC X(36).
               10  END-TO-END-ID         PIC X(35).
               10  INSTRUCTION-ID        PIC X(35).
           05  FRAUD-SCORE               PIC 9(3).
           05  LIMIT-RESULT              PIC X(1).