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
           02 fu_telephone PIC A(10).
           02 fu_nom PIC A(20).
           02 fu_prenom PIC A(30).
           02 fu_mdp PIC A(10).
           02 fu_type PIC 9(1).
           02 fu_solde PIC 9(4).
           02 fu_immatriculation PIC X(9).
           02 fu_nbplace PIC 9(5).




       FD freservation.
       01 tamp_freservation.
           02 fres_code PIC 9(6).
           02 fres_voyageur PIC A(10).
           02 fres_conducteur PIC A(10).
           02 fres_status PIC 9(1).
           02 fres_date_reservation.
               03 fres_annee  PIC  9(4).
               03 fres_mois PIC  9(2).
               03 fres_jour PIC  9(2).
           02 fres_statut_reservation PIC 9(2).

       FD fannonce.
       01 tamp_fannonce.
           02 fa_code PIC 9(6).
           02 fa_prix PIC 9(8).
           02 fa_place_max PIC 9(1).
           02 fa_lieudepart PIC X(30).
           02 fa_lieudarrive PIC X(30).
           02 fa_lieu_rdv PIC X(30).
           02 fa_date_depart.
              03 fa_annee  PIC  9(4).
              03 fa_mois PIC  9(2).
              03 fa_jour  PIC  9(2).
           02 fa_conducteur PIC A(10).
           *> fa_cle j'ai pas trop compris


       WORKING-STORAGE SECTION.
       77 cr_futilisateur PIC 9(2).
       77 cr_freservation PIC 9(2).
       77 cr_fannonce PIC 9(2).


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


           *> Accueil
