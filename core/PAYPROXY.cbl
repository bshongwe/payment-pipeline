       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYPROXY.
      ******************************************************************
      * Proxy resolution – MSISDN / ShapID → participant + account token
      * Calls PayInc proxy directory (or local cache with strict TTL)
      ******************************************************************
       DATA DIVISION.
       LINKAGE SECTION.
           COPY PROXYREQ.
           COPY PAYSTAT.

       PROCEDURE DIVISION USING PROXY-RESOLVE-REQUEST
                                PROXY-RESOLVE-RESPONSE
                                MODULE-STATUS.
       MAIN.
           INITIALIZE PROXY-RESOLVE-RESPONSE MODULE-STATUS
           EVALUATE PROXY-TYPE
               WHEN "MSISDN"
               WHEN "SHAPID"
                    PERFORM RESOLVE-VIA-PAYINC
               WHEN "ACCOUNT"
                    PERFORM RESOLVE-ACCOUNT-DIRECT
               WHEN OTHER
                    SET RESOLVE-NOT-FOUND TO TRUE
                    SET STATUS-BUSINESS-REJECT TO TRUE
                    MOVE "PROXYNF" TO REASON-CODE
           END-EVALUATE
           GOBACK.

       RESOLVE-VIA-PAYINC.
      * Secure call to PayInc proxy service.
      * On success populate RESOLVED-PARTICIPANT, ACCOUNT-TOKEN,
      * DISPLAY-NAME and generate EVIDENCE-ID for journal.
      * Protect against enumeration (rate limit, evidence only).
           .