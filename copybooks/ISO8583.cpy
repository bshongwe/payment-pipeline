       01  ISO8583-MESSAGE.
           05  MTI                      PIC X(4).
           05  PRIMARY-BITMAP           PIC X(16).
           05  SECONDARY-BITMAP         PIC X(16).
           05  DE02-PAN                 PIC X(19).
           05  DE03-PROC-CODE           PIC X(6).
           05  DE04-AMOUNT              PIC 9(12).
           05  DE07-TRANSMISSION        PIC X(10).
           05  DE11-STAN                PIC 9(6).
           05  DE12-LOCAL-TIME          PIC X(6).
           05  DE13-LOCAL-DATE          PIC X(4).
           05  DE22-POS-ENTRY           PIC X(3).
           05  DE32-ACQUIRER            PIC X(11).
           05  DE37-RRN                 PIC X(12).
           05  DE39-RESPONSE            PIC X(2).
           05  DE41-TERMINAL            PIC X(8).
           05  DE42-MERCHANT            PIC X(15).
           05  DE49-CURRENCY            PIC X(3).
           05  DE52-PIN-BLOCK           PIC X(16).
           05  DE53-SECURITY            PIC X(16).
           05  DE64-MAC                 PIC X(16).   *> or DE128
           05  DE128-MAC                PIC X(16).