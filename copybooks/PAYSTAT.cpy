      ******************************************************************
      * Uniform module status returned by every called program
      ******************************************************************
       01  MODULE-STATUS.
           05  STATUS-CODE               PIC X(2).
               88  STATUS-OK             VALUE "00".
               88  STATUS-BUSINESS-REJECT VALUE "01".
               88  STATUS-TECHNICAL-ERROR VALUE "99".
               88  STATUS-TIMEOUT        VALUE "98".
           05  REASON-CODE               PIC X(10).
           05  MESSAGE                   PIC X(100).
           05  AUTH-ID                   PIC X(12).
           05  ADDITIONAL-DATA           PIC X(64).