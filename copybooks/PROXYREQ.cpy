       01  PROXY-RESOLVE-REQUEST.
           05  PROXY-TYPE               PIC X(8).
           05  PROXY-VALUE              PIC X(40).
           05  REQUESTING-PARTICIPANT   PIC X(11).

       01  PROXY-RESOLVE-RESPONSE.
           05  RESOLVE-STATUS           PIC X(2).
               88  RESOLVE-OK           VALUE "00".
               88  RESOLVE-NOT-FOUND    VALUE "01".
               88  RESOLVE-AMBIGUOUS    VALUE "02".
               88  RESOLVE-BLOCKED      VALUE "03".
           05  RESOLVED-PARTICIPANT     PIC X(11).
           05  RESOLVED-ACCOUNT-TOKEN   PIC X(34).
           05  DISPLAY-NAME             PIC X(70).
           05  EVIDENCE-ID              PIC X(36).