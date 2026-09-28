IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYJRNL.
      ******************************************************************
      * Append-only, hash-chained journal write.
      * Single source of truth for audit/reconciliation/POPIA evidence.
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY COMMSTAT.
           COPY JRNLREC.
           01  WS-PREV-HASH               PIC X(64).
           01  WS-NEW-HASH                PIC X(64).

       LINKAGE SECTION.
           COPY PAYREQ.
           COPY PAYSTAT.

       PROCEDURE DIVISION USING PAYMENT-REQUEST MODULE-STATUS.
       MAIN-CONTROL.
           INITIALIZE MODULE-STATUS

           PERFORM READ-LAST-HASH
           PERFORM BUILD-JOURNAL-RECORD
           PERFORM COMPUTE-CHAIN-HASH
           PERFORM APPEND-RECORD

           GOBACK.

       READ-LAST-HASH.
      *    Read most recent journal record's hash — no updates, no deletes
           CONTINUE.

       BUILD-JOURNAL-RECORD.
           MOVE PAYMENT-REQUEST TO JRNL-PAYLOAD
           MOVE WS-PREV-HASH    TO JRNL-PREV-HASH.

       COMPUTE-CHAIN-HASH.
      *    CALL "PAYHSM" or crypto service — SHA-256(prev-hash + payload)
           CONTINUE.

       APPEND-RECORD.
      *    WRITE only — never REWRITE, never DELETE on this file
           CONTINUE.