       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYMSG.
      ******************************************************************
      * ISO 8583 parse/build and MAC verification/generation
      * MAC algorithm: ANSI X9.19 (retail) or bank-specific profile
      ******************************************************************
       DATA DIVISION.
       LINKAGE SECTION.
           COPY ISO8583.
           COPY PAYREQ.
           COPY PAYSTAT.
           COPY HSMREQ.
           COPY HSMRSP.

       PROCEDURE DIVISION USING ISO8583-MESSAGE
                                PAYMENT-REQUEST
                                MODULE-STATUS.
       MAIN.
           INITIALIZE MODULE-STATUS
           PERFORM PARSE-MESSAGE
           IF STATUS-OK
              PERFORM VERIFY-MAC
           END-IF
           IF STATUS-OK
              PERFORM MAP-TO-CANONICAL
           END-IF
           GOBACK.

       VERIFY-MAC.
      * Assemble binary data = MTI + bitmap + data elements up to but
      * excluding the MAC field itself.
      * Call PAYHSM with CMD-MAC-VERIFY, expected MAC = DE64 or DE128.
      * On mismatch: set STATUS-BUSINESS-REJECT, REASON = MACFAIL
           .

       MAP-TO-CANONICAL.
           MOVE DE04-AMOUNT        TO AMOUNT-MINOR
           MOVE DE11-STAN          TO STAN
           MOVE DE37-RRN           TO RRN
           MOVE DE52-PIN-BLOCK     TO PIN-BLOCK
           MOVE DE53-SECURITY(1:20) TO KSN   *> KSN often in security info
           SET RAIL-CARD TO TRUE
           .