<<<<<<< HEAD
      
       
=======
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


>>>>>>> a28349c29d9901681fddae244045ecef1e2ca166
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
<<<<<<< HEAD
           MOVE 1 TO wu_status

           PERFORM WITH TEST AFTER UNTIL  wu_solde  IS NUMERIC
                AND wu_solde > 9 
                    display "Saisir le montatn de recharge au moins 10€"
                    accept wu_solde 
           END-PERFORM
           
           ADD fu_solde TO wu_solde GIVING fu_solde
           
=======

>>>>>>> a28349c29d9901681fddae244045ecef1e2ca166
           MOVE wutilisateur TO TAMP_FUTILISATEUR

           OPEN I-O FUTILISATEUR

           WRITE TAMP_FUTILISATEUR
               INVALID KEY
                   DISPLAY "Impossible de vous inscrire"
               NOT INVALID KEY
                   DISPLAY "Votre compte est creer, connecter vous"
           END-WRITE
<<<<<<< HEAD
           
           CLOSE FUTILISATEUR. 

    *> connexion           
=======

           CLOSE FUTILISATEUR.

>>>>>>> a28349c29d9901681fddae244045ecef1e2ca166
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
                 PERFORM CONNEXION
           NOT INVALID KEY
                IF FU_MDP = WU_MDP THEN
                    DISPLAY "BONJOUR " FU_PRENOM
                    if fu_status = 3 THEN
                        DISPLAY "VOTRE COMPTE EST BLOQUE"
                        DISPLAY "CONTACT ADMIN"
                        PERFORM CONNEXION
                    ELSE
                        PERFORM AFFICHE_MENU
                    END-IF
                ELSE
                    display "VOTRE MOT DE PASSE INCORRECT"
                    PERFORM CONNEXION
                END-IF
           END-READ
<<<<<<< HEAD
           
           
           CLOSE FUTILISATEUR.


    *> voir_profil
       VOIR_PROFIL.

           MOVE wu_telephone TO fu_telephone
           OPEN INPUT FUTILISATEUR
           READ FUTILISATEUR
           NOT INVALID KEY

                DISPLAY "---------------------------------------------"
                DISPLAY "|               MON PROFIL                  |"
                DISPLAY "---------------------------------------------"
                DISPLAY "NOM               : " fu_nom
                DISPLAY "PRENOM            : " fu_prenom
                DISPLAY "SOLDE             : " fu_solde " €"

                EVALUATE fu_status
                    WHEN 1
                        DISPLAY "STATUS            : COMPTE ACTIF "
                    WHEN 2
                        DISPLAY "STATUS            : COMPTE SUSPENDU"
                    WHEN 3
                        DISPLAY "STATUS            : COMPTE BLOQUER"
                END-EVALUATE
                
                
                EVALUATE fu_type
                WHEN 1 
                    DISPLAY "TYPE              : VOYAGEUR"
                WHEN 2
                    DISPLAY "TYPE              : VOYAGEUR ET CONDUCTEUR"
                    DISPLAY "IMMATRICULATION   : " fu_immatriculation
                    DISPLAY "PLACE MAXIMALE    : " fu_nbplace
                END-EVALUATE
           END-READ

           CLOSE FUTILISATEUR
           

           ACCEPT w_test

           
           PERFORM PAGE_PROFIL.

    *> recharge compte
       RECHARGE_COMPTE.
           DISPLAY "Votre solde est de " fu_solde
           
           PERFORM WITH TEST AFTER UNTIL  wu_solde  IS NUMERIC
                AND wu_solde > 9 
                    display "Saisir le montatn de recharge au moins 10€"
                    accept wu_solde 
           END-PERFORM
           
           

           OPEN I-O FUTILISATEUR
            ADD fu_solde TO wu_solde GIVING w_prix
            
           READ FUTILISATEUR KEY IS FU_TELEPHONE
           
           INVALID KEY 
                 display "IMPOSSIBLE DE RECHARGER VOTRE COMPTE"
           NOT INVALID KEY
                MOVE w_prix TO fu_solde
                REWRITE TAMP_FUTILISATEUR
                DISPLAY "Nouveau Solde : " fu_solde
           END-READ
           
           CLOSE FUTILISATEUR

           ACCEPT w_test

           
           PERFORM PAGE_PROFIL.

    *> supprimer compte
        SUPPRIME_COMPTE.
            PERFORM WITH TEST AFTER UNTIL  w_rep IS EQUAL TO "NON" OR
                w_rep IS EQUAL TO "OUI"
                    display "Voulez-vous supprimer votre compte 'OUI/NON'"
                    accept w_rep 
           END-PERFORM

           IF w_rep IS EQUAL TO "OUI" THEN
                DISPLAY "SUPPRESSION COMPTE"
                OPEN I-O FUTILISATEUR
                    
            
                    READ FUTILISATEUR KEY IS FU_TELEPHONE
           
                    NOT INVALID KEY
                        DELETE FUTILISATEUR RECORD
                    END-READ
           
                CLOSE FUTILISATEUR
                PERFORM AFFICHE_PAGE_CONNEXION
           ELSE
                PERFORM PAGE_PROFIL
           END-IF.

    *> change mot de passe
       CHANGE_MPD.
           
           
           
           PERFORM WITH TEST AFTER UNTIL fu_mdp = wu_mdp
               display "SAISIR MOT DE PASSE ACTUEL"
               accept wu_mdp
           END-PERFORM

           MOVE 0 TO w_test

           PERFORM WITH TEST AFTER UNTIL w_test = 1

               PERFORM WITH TEST AFTER UNTIL FUNCTION LENGTH(wu_mdp) > 4
                  AND FUNCTION LENGTH(wu_mdp) < 11
                      display "NOUVEAU MOT DE PASSE"
                      accept wu_mdp 
               END-PERFORM
               
               
                display "CONFIRMATION MOT DE PASSE"
                accept w_text
                IF wu_mdp = w_text THEN
                   
                    OPEN I-O FUTILISATEUR
                    
            
                    READ FUTILISATEUR KEY IS FU_TELEPHONE
           
                    INVALID KEY 
                        display "IMPOSSIBLE DE MODIFIER LE MOT DE PASSE"
                    NOT INVALID KEY
                         MOVE wu_mdp TO fu_mdp
                         REWRITE TAMP_FUTILISATEUR
                         DISPLAY "MOT DE PASSE MIS A JOUR"
                    END-READ
           
                    CLOSE FUTILISATEUR
                    MOVE 1 TO w_test
                ELSE
                   DISPLAY "Mot de passse confirmation incorret"
                END-IF
           END-PERFORM

           ACCEPT w_test

           
           PERFORM PAGE_PROFIL.


    *> change mot de passe
       CHANGE_STATUS.
           
           
           
           EVALUATE fu_status
                WHEN 1
                    DISPLAY "STATUS            : COMPTE ACTIF "
                    MOVE "SUSPENDRE" TO w_text
                WHEN 2
                    DISPLAY "STATUS            : COMPTE SUSPENDU"
                    MOVE "ACTIVER" TO w_text
            END-EVALUATE
            

           MOVE 0 TO w_test

           PERFORM WITH TEST AFTER UNTIL w_rep = "OUI" OR w_rep="NON"
                display "VOUELEZ-VOUS " w_text "VOTRE COMPTE 'OUI/NON'"
                accept w_rep
           END-PERFORM
           IF w_rep = "OUI" THEN
                   
                OPEN I-O FUTILISATEUR
                
        
                READ FUTILISATEUR KEY IS FU_TELEPHONE
        
                NOT INVALID KEY
                        EVALUATE fu_status
                            WHEN 1
                                MOVE 2 TO fu_status
                            WHEN 2
                                MOVE 1 TO fu_status
                        END-EVALUATE
                        
                        REWRITE TAMP_FUTILISATEUR
                        DISPLAY "STATUS MIS A JOUR"

                        ACCEPT w_test
                END-READ
        
                CLOSE FUTILISATEUR
            END-IF


           
           PERFORM PAGE_PROFIL.
=======
>>>>>>> a28349c29d9901681fddae244045ecef1e2ca166


           CLOSE FUTILISATEUR.
