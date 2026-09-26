* HSMRSP.cpy
       01  HSM-RESPONSE.
           05  HSM-STATUS               PIC X(2).
               88  HSM-OK               VALUE "00".
               88  HSM-PIN-INCORRECT    VALUE "01".
               88  HSM-CRYPTO-ERROR     VALUE "05".
               88  HSM-TIMEOUT          VALUE "99".
           05  HSM-REASON-CODE          PIC X(4).
           05  HSM-ARPC                 PIC X(16).
           05  HSM-ARC                  PIC X(2).
           05  HSM-TRANSLATED-BLOCK     PIC X(16).
           05  HSM-DIAGNOSTIC           PIC X(40).