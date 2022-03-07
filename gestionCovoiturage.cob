       IDENTIFICATION DIVISION.
       PROGRAM-ID. gestionCovoiturage.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.


           SELECT futilisateur ASSIGN TO "utilisateur.dat"
           ORGANIZATION INDEXED
           ACCESS MODE is DYNAMIC
           RECORD KEY IS fu_telephone
           ALTERNATE RECORD KEY IS fu_type WITH DUPLICATES
           ALTERNATE RECORD KEY IS fu_immatriculation
           FILE STATUS IS cr_futilisateur.



           SELECT freservation ASSIGN TO "reservation.dat"
           ORGANIZATION SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS cr_freservation.


           SELECT fannonce ASSIGN TO "annonce.dat"
           ORGANIZATION INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS fa_code
           ALTERNATE RECORD KEY IS fa_lieu_rdv WITH DUPLICATES
           FILE STATUS IS cr_fannonce.

       DATA DIVISION.

       FILE SECTION.

       FD futilisateur.
       01 tamp_futilisateur.
           02 fu_telephone PIC 9(10).
           02 fu_nom PIC A(20).
           02 fu_prenom PIC A(30).
           02 fu_mdp PIC X(10).
           02 fu_type PIC 9(1).
           02 fu_solde PIC 9(4).
           02 fu_immatriculation PIC X(9).
           02 fu_nbplace PIC 9(5).




       FD freservation.
       01 tamp_freservation.
           02 fres_code PIC 9(6).
           02 fres_voyageur PIC 9(10).
           02 fres_conducteur PIC 9(10).
           02 fres_status PIC 9(1).
           02 fres_date_reservation.
             03 WS-CURRENT-YEAR  PIC  9(4).
              03 WS-CURRENT-MONTH PIC  9(2).
              03 WS-CURRENT-DAY   PIC  9(2).
           02 fres_statut_reservation PIC 9(2).

       FD fannonce.
       01 tamp_fannonce.
           02 fa_code PIC 9(6).
           02 fa_prix PIC 9(8).
           02 fa_place_max PIC 9(1).
           02 fa_place_dispo PIC 9(1).
           02 fa_lieu_rdv PIC 9(30).
           02 fa_depart PIC 9(30).
           02 fa_arrive PIC 9(30).
           02 fra_date_dep.
             03 WS-CURRENT-YEAR  PIC  9(4).
              03 WS-CURRENT-MONTH PIC  9(2).
              03 WS-CURRENT-DAY   PIC  9(2).
           02 fa_conducteur PIC 9(10).


       WORKING-STORAGE SECTION.
       77 cr_futilisateur PIC 9(2).
       77 cr_fvoiture PIC 9(2).
       77 cr_ftrajet PIC 9(2).
       77 cr_freservation PIC 9(2).
       77 cr_fannonce PIC 9(2).


           *> toure
       01 wutilisateur.
           02 wu_telephone PIC 9(10).
           02 wu_nom PIC A(20).
           02 wu_prenom PIC A(30).
           02 wu_mdp PIC X(10).
           02 wu_type PIC 9(1).
           02 wu_solde PIC 9(4).
           02 wu_immatriculation PIC X(9).
           02 wu_nbplace PIC 9(5).
       77 w_teluser PIC 9(10).
       77 w_text PIC 9(30).
       77 w_test PIC 9(1).


       PROCEDURE DIVISION.

           OPEN I-O futilisateur
           IF cr_futilisateur=35 THEN
              OPEN OUTPUT futilisateur
           END-IF
           CLOSE futilisateur




           OPEN I-O freservation
           IF cr_freservation=35 THEN
              OPEN OUTPUT freservation
           END-IF
           CLOSE freservation

           OPEN I-O fannonce
           IF cr_fannonce=35 THEN
              OPEN OUTPUT fannonce
           END-IF
           CLOSE fannonce

           
           
           *> Affiche la page de connexion
           PERFORM AFFICHE_PAGE_CONNEXION.
           
           
           

           STOP RUN.
           
           copy "compte.cpy".



