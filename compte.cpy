    *> page identification et connexion


       AFFICHE_PAGE_CONNEXION.

           PERFORM WITH TEST AFTER UNTIL w_test > 0 AND w_test < 4
           
                DISPLAY "------------ GESTION COVOITURAGE ------------"
                DISPLAY "1.   INSCRIPTION"
                DISPLAY "2.   CONNEXION"
                DISPLAY "3.   QUITTER"
                ACCEPT w_test
           END-PERFORM

           EVALUATE w_test
           WHEN 1
                PERFORM INSCRIPTION
           WHEN 2
                PERFORM CONNEXION
           WHEN 3
                DISPLAY "A TRES BIENTOT"

           END-EVALUATE.
       
       
       INSCRIPTION.
           DISPLAY "------------ INSCRIPTION ------------"
           PERFORM WITH TEST AFTER UNTIL NOT wu_nom = SPACE 
           AND wu_nom is ALPHABETIC AND w_test = 0
                MOVE 0 TO w_test
                display "saisir votre nom"
                accept wu_nom
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL NOT wu_prenom = SPACE 
           AND wu_prenom is ALPHABETIC
                display "saisir votre prenom"
                accept wu_prenom 
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL wu_type > 0 AND wu_type < 3
           
                DISPLAY "TYPE UTILISATEUR"
                DISPLAY "1.   VOYAGEUR"
                DISPLAY "2.   VOYAGEUR ET CONDUCTEUR"
                ACCEPT wu_type
           END-PERFORM

           IF wu_type = 2 THEN
                PERFORM WITH TEST AFTER UNTIL 
                NOT wu_immatriculation = SPACE 
                    display "saisir l'immatriculation du vehicule"
                    accept wu_immatriculation 
                END-PERFORM
                PERFORM WITH TEST AFTER UNTIL  wu_nbplace  IS NUMERIC
                AND wu_nbplace > 0 AND wu_nbplace < 10
                    display "Nombre de place "
                    accept wu_nbplace 
                END-PERFORM
           END-IF

           PERFORM WITH TEST AFTER UNTIL  wu_telephone  IS NUMERIC
               display "VOTRE NUMERO DE TELEPHONE "
               accept wu_telephone 
           END-PERFORM

           PERFORM WITH TEST AFTER UNTIL FUNCTION LENGTH(wu_mdp) > 4
           AND FUNCTION LENGTH(wu_mdp) < 11
               display "SAISIR UN MOT DE PASSE"
               accept wu_mdp 
           END-PERFORM
           
           MOVE wutilisateur TO TAMP_FUTILISATEUR

           OPEN I-O FUTILISATEUR

           WRITE TAMP_FUTILISATEUR
               INVALID KEY
                   DISPLAY "Impossible de vous inscrire"
               NOT INVALID KEY
                   DISPLAY "Votre compte est creer, connecter vous"
           END-WRITE
           
           CLOSE FUTILISATEUR. 
           
       CONNEXION.
           DISPLAY "------------ CONNEXION ------------"
           display "VOTRE NUMERO DE TELEPHONE "
           accept wu_telephone
           display "SAISIR UN MOT DE PASSE"
           accept wu_mdp

           OPEN INPUT FUTILISATEUR

           MOVE WU_TELEPHONE TO FU_TELEPHONE
           READ FUTILISATEUR KEY IS FU_TELEPHONE
           INVALID KEY 
                 display "VOTRE IDENTIFIANT INCORRECT"
           NOT INVALID KEY
                IF FU_MDP = WU_MDP THEN
                    DISPLAY "BONJOUR " FU_PRENOM " " FU_NOM
                ELSE
                    display "VOTRE MOT DE PASSE INCORRECT"
                END-IF
           END-READ
           
           
           CLOSE FUTILISATEUR.




