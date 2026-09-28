IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYLEDG.
      ******************************************************************
      * Idempotent memo/hard post keyed by STAN/RRN or EndToEndId.
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY COMMSTAT.
           01  WS-DEDUPE-KEY              PIC X(35).
           01  WS-ALREADY-POSTED          PIC X(01) VALUE "N".
               88  ALREADY-POSTED         VALUE "Y".

       LINKAGE SECTION.
           COPY PAYREQ.
           COPY PAYSTAT.

       PROCEDURE DIVISION USING PAYMENT-REQUEST MODULE-STATUS.
       MAIN-CONTROL.
           INITIALIZE MODULE-STATUS
           PERFORM BUILD-DEDUPE-KEY
           PERFORM CHECK-IDEMPOTENCY

           IF ALREADY-POSTED
      *        Safe to return prior result — do NOT post twice
               SET STATUS-OK TO TRUE
               GOBACK
           END-IF

           PERFORM POST-MEMO
           IF STATUS-OK
               PERFORM POST-HARD
           END-IF

           GOBACK.

       BUILD-DEDUPE-KEY.
           IF RAIL-PAYSHAP
               MOVE END-TO-END-ID TO WS-DEDUPE-KEY
           ELSE
               STRING STAN DELIMITED BY SIZE
                      RRN  DELIMITED BY SIZE
                      INTO WS-DEDUPE-KEY
           END-IF.

       CHECK-IDEMPOTENCY.
      *    EXEC CICS READ against ledger-key index (unique constraint)
           CONTINUE.

       POST-MEMO.
      *    Insert memo-status entry using WS-DEDUPE-KEY as unique key
           CONTINUE.

       POST-HARD.
      *    Convert memo to hard post — same key, no duplicate insert
           CONTINUE.