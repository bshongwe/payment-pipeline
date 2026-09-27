       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYORCH.
      ******************************************************************
      * Authorization Orchestrator – sequencing only, no business rules
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
           COPY COMMSTAT.
           01  WS-STEP                   PIC X(20).
       LINKAGE SECTION.
           COPY PAYREQ.
           COPY PAYSTAT.

       PROCEDURE DIVISION USING PAYMENT-REQUEST MODULE-STATUS.
       MAIN-CONTROL.
           INITIALIZE MODULE-STATUS
           EVALUATE TRUE
               WHEN RAIL-CARD
                    PERFORM CARD-FLOW
               WHEN RAIL-PAYSHAP
                    PERFORM PAYSHAP-FLOW
               WHEN OTHER
                    SET STATUS-TECHNICAL-ERROR TO TRUE
                    MOVE "INVRAIL" TO REASON-CODE
           END-EVALUATE
           GOBACK.

       CARD-FLOW.
           MOVE "MSG" TO WS-STEP
           CALL "PAYMSG"  USING ... 
           IF NOT STATUS-OK GOBACK END-IF

           MOVE "HSM" TO WS-STEP
           CALL "PAYHSM"  USING HSM-REQUEST HSM-RESPONSE
           IF NOT HSM-OK
              SET STATUS-BUSINESS-REJECT TO TRUE
              MOVE "PINFAIL" TO REASON-CODE
              GOBACK
           END-IF

           MOVE "VAL" TO WS-STEP
           CALL "PAYVAL"  ...
           IF NOT STATUS-OK GOBACK END-IF

           MOVE "LEDG" TO WS-STEP
           CALL "PAYLEDG" ...
           CALL "PAYJRNL" ...
           .

       PAYSHAP-FLOW.
           MOVE "PROXY" TO WS-STEP
           CALL "PAYPROXY" ...
           IF NOT RESOLVE-OK
              SET STATUS-BUSINESS-REJECT TO TRUE
              MOVE "PROXYNF" TO REASON-CODE
              GOBACK
           END-IF
           MOVE RESOLVED-PARTICIPANT TO ...
           CALL "PAYVAL" ...
           CALL "PAYLEDG" ...
           CALL "PAYPS008" ...   *> build & send pacs.008
           CALL "PAYJRNL" ...
           .