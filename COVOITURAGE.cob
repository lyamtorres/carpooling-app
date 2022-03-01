       IDENTIFICATION DIVISION.
       PROGRAM-ID. COVOITURAGE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.


           SELECT futilisateur ASSIGN TO "utilisateur.dat"
           ORGANIZATION INDEXED
           ACCESS MODE is DYNAMIC
           RECORD KEY IS fu_telephone
           ALTERNATE RECORD KEY IS fu_type WITH DUPLICATES
           FILE STATUS IS cr_futilisateur.

           SELECT fvoiture ASSIGN TO "voiture.dat"
           ORGANIZATION INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS fv_immat
           ALTERNATE RECORD KEY IS fv_conducteur
           FILE STATUS IS cr_fvoiture.

           SELECT ftrajet ASSIGN TO "trajet.dat"
           ORGANIZATION INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS ftra_cle
           FILE STATUS IS cr_ftrajet.


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


       FD fvoiture.
       01 tamp_fvoiture.
           02 fv_immat PIC X(9).
           02 fv_modele PIC A(30).
           02 fv_nbplace PIC 9(2).
           02 fv_conducteur PIC A(10).
       

       FD ftrajet.
       01 tamp_ftrajet.
           02 ftra_cle.
              03 ftra_depart PIC A(30).
              03 ftra_arrive PIC A(30).
           02 ftr_duree PIC 9(2).
           02 ftr_distante PIC 9(3).

       
       FD freservation.
       01 tamp_freservation.
           02 fres_code PIC 9(6).
           02 fres_voyageur PIC A(10).
           02 fres_conducteur PIC A(10).
           02 fres_status PIC 9(1).
         *> 02 fres_date_voyage PIC 9(8).

       FD fannonce.
       01 tamp_fannonce.
           02 fa_code PIC 9(6).
           02 fa_prix PIC 9(8).
           02 fa_place_max PIC 9(1).
           02 fa_place_dispo PIC 9(1).
           02 fa_lieu_rdv PIC 9(30).
           *> 02 fa_date_dep PIC 9(8).
           02 fa_conducteur PIC A(10).
           *> fa_cle j'ai pas trop compris


       WORKING-STORAGE SECTION.
       77 cr_futilisateur PIC 9(2).
       77 cr_fvoiture PIC 9(2).
       77 cr_ftrajet PIC 9(2).
       77 cr_freservation PIC 9(2).
       77 cr_fannonce PIC 9(2).

       
       PROCEDURE DIVISION.

           OPEN I-O futilisateur
           IF cr_futilisateur=35 THEN
              OPEN OUTPUT futilisateur
           END-IF
           CLOSE futilisateur
           
           OPEN I-O fvoiture
           IF cr_fvoiture=35 THEN
              OPEN OUTPUT fvoiture
           END-IF
           CLOSE fvoiture

           OPEN I-O ftrajet
           IF cr_ftrajet=35 THEN
              OPEN OUTPUT ftrajet
           END-IF
           CLOSE ftrajet

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


           display "------------------  COVOITURAGE ------------------".

