--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22
-- Dumped by pg_dump version 10.22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: getdatefin(date); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getdatefin(date_debut date) RETURNS date
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN date_debut + INTERVAL '1 year - 1 day';
END;
$$;


ALTER FUNCTION getdatefin(date_debut date) OWNER TO postgres;

--
-- Name: getlast_infos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION getlast_infos() RETURNS TABLE(idinfo integer, iddescription integer, valeur text, created_at timestamp without time zone, description text)
    LANGUAGE plpgsql
    AS $$
DECLARE
    id_description INTEGER;
BEGIN
    FOR id_description IN SELECT description.iddescription FROM description LOOP
        RETURN QUERY select informations.idinfo ,
                        informations.iddescription , 
                        informations.valeur , 
                        informations.created_at , 
                        description.description 
                    from informations
                    join description
                    on informations.iddescription = description.iddescription
                    where informations.iddescription = id_description
                    order by informations.created_at desc limit 1;
    END LOOP;
END;
$$;


ALTER FUNCTION getlast_infos() OWNER TO postgres;

--
-- Name: loop_devise(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION loop_devise() RETURNS TABLE(id_devise integer, nom text, idquivalence integer, taux numeric, date date)
    LANGUAGE plpgsql
    AS $$
DECLARE
    id_devise INTEGER;
BEGIN
    FOR id_devise IN SELECT iddevise FROM devise LOOP
        RETURN QUERY SELECT id_devise ,d.nom, dq.idquivalence, dq.taux, dq.date
                     FROM devisequivalence dq
                     JOIN devise d ON dq.iddevise = d.iddevise
                     WHERE dq.iddevise = id_devise
                    order by dq.date desc limit 1;
    END LOOP;
END;
$$;


ALTER FUNCTION loop_devise() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE admin (
    idadmin integer NOT NULL,
    nom character varying,
    mdp character varying
);


ALTER TABLE admin OWNER TO postgres;

--
-- Name: admin_idadmin_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE admin_idadmin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE admin_idadmin_seq OWNER TO postgres;

--
-- Name: admin_idadmin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE admin_idadmin_seq OWNED BY admin.idadmin;


--
-- Name: compte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE compte (
    idcompte integer NOT NULL,
    numero text NOT NULL,
    libelle text NOT NULL
);


ALTER TABLE compte OWNER TO postgres;

--
-- Name: compte_idcompte_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE compte_idcompte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE compte_idcompte_seq OWNER TO postgres;

--
-- Name: compte_idcompte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE compte_idcompte_seq OWNED BY compte.idcompte;


--
-- Name: compte_trie; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW compte_trie AS
 SELECT compte.idcompte,
    compte.numero,
    compte.libelle
   FROM compte
  ORDER BY compte.numero;


ALTER TABLE compte_trie OWNER TO postgres;

--
-- Name: exercice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE exercice (
    idexercice integer NOT NULL,
    debut date
);


ALTER TABLE exercice OWNER TO postgres;

--
-- Name: date_exercice; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW date_exercice AS
 SELECT exercice.idexercice,
    exercice.debut,
    getdatefin(exercice.debut) AS fin
   FROM exercice;


ALTER TABLE date_exercice OWNER TO postgres;

--
-- Name: date_exrcice_extract; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW date_exrcice_extract AS
 SELECT date_exercice.idexercice,
    to_char((date_exercice.debut)::timestamp with time zone, 'DD '::text) AS jour_debut,
    to_char((date_exercice.debut)::timestamp with time zone, 'MM'::text) AS mois_debut,
    to_char((date_exercice.debut)::timestamp with time zone, ' YYYY'::text) AS annee_debut,
    to_char((date_exercice.fin)::timestamp with time zone, 'DD '::text) AS jour_fin,
    to_char((date_exercice.fin)::timestamp with time zone, 'MM'::text) AS mois_fin,
    to_char((date_exercice.fin)::timestamp with time zone, ' YYYY'::text) AS annee_fin
   FROM date_exercice;


ALTER TABLE date_exrcice_extract OWNER TO postgres;

--
-- Name: description; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE description (
    iddescription integer NOT NULL,
    description text
);


ALTER TABLE description OWNER TO postgres;

--
-- Name: description_iddescription_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE description_iddescription_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE description_iddescription_seq OWNER TO postgres;

--
-- Name: description_iddescription_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE description_iddescription_seq OWNED BY description.iddescription;


--
-- Name: devise; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE devise (
    iddevise integer NOT NULL,
    nom text NOT NULL
);


ALTER TABLE devise OWNER TO postgres;

--
-- Name: devise_iddevise_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE devise_iddevise_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE devise_iddevise_seq OWNER TO postgres;

--
-- Name: devise_iddevise_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE devise_iddevise_seq OWNED BY devise.iddevise;


--
-- Name: loop_devise; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW loop_devise AS
 SELECT loop_devise.id_devise,
    loop_devise.nom,
    loop_devise.idquivalence,
    loop_devise.taux,
    loop_devise.date
   FROM loop_devise() loop_devise(id_devise, nom, idquivalence, taux, date);


ALTER TABLE loop_devise OWNER TO postgres;

--
-- Name: devise_taux; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW devise_taux AS
 SELECT loop_devise.id_devise,
    loop_devise.nom,
    loop_devise.idquivalence,
    loop_devise.taux,
    loop_devise.date,
        CASE
            WHEN (loop_devise.date = CURRENT_DATE) THEN true
            ELSE false
        END AS maj
   FROM loop_devise;


ALTER TABLE devise_taux OWNER TO postgres;

--
-- Name: devisequivalence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE devisequivalence (
    idquivalence integer NOT NULL,
    iddevise integer,
    taux numeric(10,2) NOT NULL,
    date date DEFAULT now()
);


ALTER TABLE devisequivalence OWNER TO postgres;

--
-- Name: devisequivalence_idquivalence_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE devisequivalence_idquivalence_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE devisequivalence_idquivalence_seq OWNER TO postgres;

--
-- Name: devisequivalence_idquivalence_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE devisequivalence_idquivalence_seq OWNED BY devisequivalence.idquivalence;


--
-- Name: dirigeant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dirigeant (
    id integer NOT NULL,
    nom text,
    date date,
    email text
);


ALTER TABLE dirigeant OWNER TO postgres;

--
-- Name: dirigeant_date_extract; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW dirigeant_date_extract AS
 SELECT dirigeant.id,
    dirigeant.nom,
    dirigeant.email,
    to_char((dirigeant.date)::timestamp with time zone, 'DD '::text) AS jour,
    to_char((dirigeant.date)::timestamp with time zone, 'MM'::text) AS mois,
    to_char((dirigeant.date)::timestamp with time zone, ' YYYY'::text) AS annee
   FROM dirigeant;


ALTER TABLE dirigeant_date_extract OWNER TO postgres;

--
-- Name: dirigeant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dirigeant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dirigeant_id_seq OWNER TO postgres;

--
-- Name: dirigeant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE dirigeant_id_seq OWNED BY dirigeant.id;


--
-- Name: exercice_idexercice_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE exercice_idexercice_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE exercice_idexercice_seq OWNER TO postgres;

--
-- Name: exercice_idexercice_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE exercice_idexercice_seq OWNED BY exercice.idexercice;


--
-- Name: formulairesociete; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE formulairesociete (
    idform integer NOT NULL,
    nom character varying,
    valeur character varying,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE formulairesociete OWNER TO postgres;

--
-- Name: formulairesociete_idform_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE formulairesociete_idform_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE formulairesociete_idform_seq OWNER TO postgres;

--
-- Name: formulairesociete_idform_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE formulairesociete_idform_seq OWNED BY formulairesociete.idform;


--
-- Name: info_description; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW info_description AS
 SELECT getlast_infos.idinfo,
    getlast_infos.iddescription,
    getlast_infos.valeur,
    getlast_infos.created_at,
    getlast_infos.description
   FROM getlast_infos() getlast_infos(idinfo, iddescription, valeur, created_at, description);


ALTER TABLE info_description OWNER TO postgres;

--
-- Name: informations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE informations (
    idinfo integer NOT NULL,
    iddescription integer,
    valeur text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE informations OWNER TO postgres;

--
-- Name: informations_idinfo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE informations_idinfo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE informations_idinfo_seq OWNER TO postgres;

--
-- Name: informations_idinfo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE informations_idinfo_seq OWNED BY informations.idinfo;


--
-- Name: journal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE journal (
    idjournal integer NOT NULL,
    code character varying NOT NULL,
    nom character varying NOT NULL,
    date date DEFAULT now()
);


ALTER TABLE journal OWNER TO postgres;

--
-- Name: journal_idjournal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE journal_idjournal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE journal_idjournal_seq OWNER TO postgres;

--
-- Name: journal_idjournal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE journal_idjournal_seq OWNED BY journal.idjournal;


--
-- Name: mois; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE mois (
    idmois integer NOT NULL,
    mois character varying(20)
);


ALTER TABLE mois OWNER TO postgres;

--
-- Name: mois_idmois_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE mois_idmois_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE mois_idmois_seq OWNER TO postgres;

--
-- Name: mois_idmois_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE mois_idmois_seq OWNED BY mois.idmois;


--
-- Name: nbemploye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE nbemploye (
    idnbempl integer NOT NULL,
    valeur integer,
    date date DEFAULT now()
);


ALTER TABLE nbemploye OWNER TO postgres;

--
-- Name: nbemploye_idnbempl_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE nbemploye_idnbempl_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE nbemploye_idnbempl_seq OWNER TO postgres;

--
-- Name: nbemploye_idnbempl_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE nbemploye_idnbempl_seq OWNED BY nbemploye.idnbempl;


--
-- Name: tiers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE tiers (
    idtiers integer NOT NULL,
    idcompte integer,
    nom text NOT NULL
);


ALTER TABLE tiers OWNER TO postgres;

--
-- Name: tiers_alphabet; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW tiers_alphabet AS
 SELECT tiers.idtiers,
    tiers.idcompte,
    tiers.nom
   FROM tiers
  ORDER BY tiers.nom;


ALTER TABLE tiers_alphabet OWNER TO postgres;

--
-- Name: tiers_compte; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW tiers_compte AS
 SELECT tiers_alphabet.idtiers,
    tiers_alphabet.idcompte,
    tiers_alphabet.nom,
    compte.numero
   FROM (tiers_alphabet
     JOIN compte ON ((tiers_alphabet.idcompte = compte.idcompte)));


ALTER TABLE tiers_compte OWNER TO postgres;

--
-- Name: tiers_idtiers_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE tiers_idtiers_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tiers_idtiers_seq OWNER TO postgres;

--
-- Name: tiers_idtiers_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE tiers_idtiers_seq OWNED BY tiers.idtiers;


--
-- Name: verification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE verification (
    idverif integer NOT NULL,
    name character varying,
    min numeric,
    max numeric
);


ALTER TABLE verification OWNER TO postgres;

--
-- Name: verification_idverif_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE verification_idverif_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE verification_idverif_seq OWNER TO postgres;

--
-- Name: verification_idverif_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE verification_idverif_seq OWNED BY verification.idverif;


--
-- Name: admin idadmin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY admin ALTER COLUMN idadmin SET DEFAULT nextval('admin_idadmin_seq'::regclass);


--
-- Name: compte idcompte; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY compte ALTER COLUMN idcompte SET DEFAULT nextval('compte_idcompte_seq'::regclass);


--
-- Name: description iddescription; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY description ALTER COLUMN iddescription SET DEFAULT nextval('description_iddescription_seq'::regclass);


--
-- Name: devise iddevise; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY devise ALTER COLUMN iddevise SET DEFAULT nextval('devise_iddevise_seq'::regclass);


--
-- Name: devisequivalence idquivalence; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY devisequivalence ALTER COLUMN idquivalence SET DEFAULT nextval('devisequivalence_idquivalence_seq'::regclass);


--
-- Name: dirigeant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dirigeant ALTER COLUMN id SET DEFAULT nextval('dirigeant_id_seq'::regclass);


--
-- Name: exercice idexercice; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exercice ALTER COLUMN idexercice SET DEFAULT nextval('exercice_idexercice_seq'::regclass);


--
-- Name: formulairesociete idform; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY formulairesociete ALTER COLUMN idform SET DEFAULT nextval('formulairesociete_idform_seq'::regclass);


--
-- Name: informations idinfo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY informations ALTER COLUMN idinfo SET DEFAULT nextval('informations_idinfo_seq'::regclass);


--
-- Name: journal idjournal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal ALTER COLUMN idjournal SET DEFAULT nextval('journal_idjournal_seq'::regclass);


--
-- Name: mois idmois; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mois ALTER COLUMN idmois SET DEFAULT nextval('mois_idmois_seq'::regclass);


--
-- Name: nbemploye idnbempl; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nbemploye ALTER COLUMN idnbempl SET DEFAULT nextval('nbemploye_idnbempl_seq'::regclass);


--
-- Name: tiers idtiers; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiers ALTER COLUMN idtiers SET DEFAULT nextval('tiers_idtiers_seq'::regclass);


--
-- Name: verification idverif; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY verification ALTER COLUMN idverif SET DEFAULT nextval('verification_idverif_seq'::regclass);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO admin VALUES (1, 'admin', '1234');


--
-- Data for Name: compte; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO compte VALUES (605, '41100', 'clients Andoharanofotsy');
INSERT INTO compte VALUES (471, 'COMPTE', 'INTITULE');
INSERT INTO compte VALUES (472, '10100', 'CAPITAL');
INSERT INTO compte VALUES (473, '10610', 'RESERVE LEGALE');
INSERT INTO compte VALUES (474, '11000', 'REPORT A NOUVEAU');
INSERT INTO compte VALUES (475, '11010', 'REPORT A NOUVEAU SOLDE CREDITEUR');
INSERT INTO compte VALUES (476, '11200', 'AUTRES PRODUITS ET CHARGES');
INSERT INTO compte VALUES (477, '11900', 'REPORT A NOUVEAU SOLDE DEBITEUR');
INSERT INTO compte VALUES (478, '12800', 'RESULTAT EN INSTANCE');
INSERT INTO compte VALUES (479, '13300', 'IMPOTS DIFFERES ACTIFS');
INSERT INTO compte VALUES (480, '16110', 'EMPRUNT A LT');
INSERT INTO compte VALUES (481, '16510', 'ENMPRUNT A MOYEN TERME');
INSERT INTO compte VALUES (482, '20124', 'FRAIS DE REHABILITATION');
INSERT INTO compte VALUES (483, '20800', 'AUTRES IMMOB INCORPORELLES');
INSERT INTO compte VALUES (484, '21100', 'TERRAINS');
INSERT INTO compte VALUES (485, '21200', 'CONSTRUCTION');
INSERT INTO compte VALUES (486, '21300', 'MATERIEL ET OUTILLAGE');
INSERT INTO compte VALUES (487, '21510', 'MATERIEL AUTOMOBILE');
INSERT INTO compte VALUES (488, '21520', 'MATERIEL MOTO');
INSERT INTO compte VALUES (489, '21600', 'AGENCEMENT. AM .INST');
INSERT INTO compte VALUES (490, '21810', 'MATERIELS ET MOBILIERS DE BUREAU');
INSERT INTO compte VALUES (491, '21819', 'MATERIELS INFORMATIQUES ET AUTRES');
INSERT INTO compte VALUES (492, '21820', 'MAT. MOB DE LOGEMENT');
INSERT INTO compte VALUES (493, '21880', 'AUTRES IMMOBILISATIONS CORP');
INSERT INTO compte VALUES (494, '23000', 'IMMOBILISATION EN COURS');
INSERT INTO compte VALUES (495, '28000', 'AMORT IMMOB INCORP');
INSERT INTO compte VALUES (496, '28120', 'AMORTISSEMENT DES CONSTRUCTIONS');
INSERT INTO compte VALUES (497, '28130', 'AMORT MACH-MATER-OUTIL');
INSERT INTO compte VALUES (498, '28150', 'AMORT MAT DE TRANSPORT');
INSERT INTO compte VALUES (499, '28160', 'AMORT A.A.I');
INSERT INTO compte VALUES (500, '28181', 'AMORT MATERIEL&MOB');
INSERT INTO compte VALUES (501, '28182', 'AMORTISSEMENTS MATERIELS INFORMATIQ');
INSERT INTO compte VALUES (502, '28183', 'AMORT MATER & MOB LOGT');
INSERT INTO compte VALUES (503, '32110', 'STOCK MATIERES PREMIERES');
INSERT INTO compte VALUES (504, '35500', 'STOCK PRODUITS FINIS');
INSERT INTO compte VALUES (505, '37000', 'STOCK MARCHANDISES');
INSERT INTO compte VALUES (506, '39700', 'PROVISIONS/DEPRECIATIONS STOCKS');
INSERT INTO compte VALUES (507, '40110', 'FOURNISSEURS DEXPLOITATIONS LOCAUX');
INSERT INTO compte VALUES (508, '40120', 'FOURNISSEURS DEXPLOITATIONS ETRANGERS');
INSERT INTO compte VALUES (509, '40310', 'FOURNISSEURS D''IMMOBILISATION');
INSERT INTO compte VALUES (510, '40810', 'FRNS: FACTURE A RECEVOIR');
INSERT INTO compte VALUES (511, '40910', 'FRNS:AVANCES&ACOMPTES VERSER');
INSERT INTO compte VALUES (512, '40980', 'FRNS: RABAIS A OBTENIR');
INSERT INTO compte VALUES (513, '41110', 'CLIENTS LOCAUX');
INSERT INTO compte VALUES (514, '41120', 'CLIENTS ETRANGERS');
INSERT INTO compte VALUES (515, '41400', 'CLIENTS DOUTEUX');
INSERT INTO compte VALUES (516, '41800', 'CLIENTS FACTURE A RETABLIR');
INSERT INTO compte VALUES (517, '42100', 'PERSONNEL: SALAIRES A PAYER');
INSERT INTO compte VALUES (518, '42510', 'PERSONNEL: AVANCES QUINZAINES');
INSERT INTO compte VALUES (519, '42520', 'PERSONNEL: AVANCES SPECIALES');
INSERT INTO compte VALUES (520, '42860', 'PERS:CHARGES  A PAYER');
INSERT INTO compte VALUES (521, '43100', 'CNAPS ');
INSERT INTO compte VALUES (522, '43120', 'OSTIE');
INSERT INTO compte VALUES (523, '44200', 'ETAT IBS');
INSERT INTO compte VALUES (524, '44210', 'ACOMPTE IBS');
INSERT INTO compte VALUES (525, '44321', 'TVA IMPUTER:DEC ULTERIEURE');
INSERT INTO compte VALUES (526, '44500', 'ETAT:IRSA VERSER');
INSERT INTO compte VALUES (527, '44560', 'ETAT: TVA DEDUCTIBLE');
INSERT INTO compte VALUES (528, '44570', 'ETAT: TVA COLLECTEE');
INSERT INTO compte VALUES (529, '44571', 'TVA A VERSER');
INSERT INTO compte VALUES (530, '45100', 'COMPTE  COURANT ASSOC');
INSERT INTO compte VALUES (531, '46700', 'DEB/CRED DIVERS');
INSERT INTO compte VALUES (532, '46800', 'CHARGES A PAYER DEB/CRED DIVERS');
INSERT INTO compte VALUES (533, '48610', 'CHARGE CONSTATES D''AVANCE');
INSERT INTO compte VALUES (534, '49100', 'PERTE/CLIENTS');
INSERT INTO compte VALUES (535, '51200', 'BOA ANKORONDRANO');
INSERT INTO compte VALUES (536, '51201', 'BOA DOLLARS');
INSERT INTO compte VALUES (537, '51202', 'BNI MADAGASCAR');
INSERT INTO compte VALUES (538, '51203', 'BNI DOLLARS');
INSERT INTO compte VALUES (539, '53100', 'CAISSE ');
INSERT INTO compte VALUES (540, '58110', 'VIREMENTINTERNE:BANQ/CAISSE');
INSERT INTO compte VALUES (541, '58130', 'VIREMENT INTERNE:BANQ/BANQ');
INSERT INTO compte VALUES (542, '58140', 'VIREMENT INTERNE CAISSE/CAISSE');
INSERT INTO compte VALUES (543, '60100', 'ACHAT MATIERES PREMIERESS');
INSERT INTO compte VALUES (544, '60200', 'FOURNIT DE MAGASIN');
INSERT INTO compte VALUES (545, '60210', 'FOURNIT BUR ');
INSERT INTO compte VALUES (546, '60220', 'FOURNIT DE LOGT');
INSERT INTO compte VALUES (547, '60230', 'EMBALLAGES(PLAST-CARTON....');
INSERT INTO compte VALUES (548, '60240', 'PIEC RECH VOITURES ADMINISTRATIVES');
INSERT INTO compte VALUES (549, '60241', 'PIEC RECH CAMIONS');
INSERT INTO compte VALUES (550, '60242', 'PIEC RECH MOTO');
INSERT INTO compte VALUES (551, '60250', 'AUTRES ACHATS');
INSERT INTO compte VALUES (552, '60300', 'VARIATION  STOCK MAT PREM');
INSERT INTO compte VALUES (553, '60610', 'EAU ET ELECTRICITE');
INSERT INTO compte VALUES (554, '60620', 'GAZ,COMBUST,CARBURANT,LUBRIF');
INSERT INTO compte VALUES (555, '61300', 'LOC IMMOBILIERES');
INSERT INTO compte VALUES (556, '61380', 'AUTRES LOCATIONS');
INSERT INTO compte VALUES (557, '61550', 'ENTRET & REP VEHICULE');
INSERT INTO compte VALUES (558, '61560', 'MAINTENANCE');
INSERT INTO compte VALUES (559, '61610', 'ASSURANCE GLOBALE DOMMAGES');
INSERT INTO compte VALUES (560, '61611', 'ASSURANCE FLOTTE AUTOMOBILE');
INSERT INTO compte VALUES (561, '61800', 'PHOTOCOPIE ET ASSIMILES ');
INSERT INTO compte VALUES (562, '61810', 'ENVOI COLIS(LETTRE&DOC...');
INSERT INTO compte VALUES (563, '62100', 'PERSONNEL EXTER');
INSERT INTO compte VALUES (564, '62210', 'HONORAIRE');
INSERT INTO compte VALUES (565, '62220', 'REMUNERATION DES TRANSITAIRES');
INSERT INTO compte VALUES (566, '62230', 'CATALOGUES ET IMPRIMES');
INSERT INTO compte VALUES (567, '62240', 'PUBLICATION');
INSERT INTO compte VALUES (568, '62250', 'SPONSORING-MECENAT...');
INSERT INTO compte VALUES (569, '62260', 'TS DOUANE ET ASSIMILES');
INSERT INTO compte VALUES (570, '62400', 'FRAIS DE TRANSPORT');
INSERT INTO compte VALUES (571, '62510', 'VOYAGES   ET DEPLACEMENT');
INSERT INTO compte VALUES (572, '62520', 'MISSION(DEPL+HEBERGT+REST)');
INSERT INTO compte VALUES (573, '62530', 'RECEPTION');
INSERT INTO compte VALUES (574, '62610', 'SERVICES POSTAUX');
INSERT INTO compte VALUES (575, '62620', 'TEL&FAX');
INSERT INTO compte VALUES (576, '62630', 'INTERNET TANA');
INSERT INTO compte VALUES (577, '62740', 'COMMISSIONS BANCAIRE INTERNATIONALE');
INSERT INTO compte VALUES (578, '62760', 'COMMISSIONS BNI');
INSERT INTO compte VALUES (579, '62770', 'COMMISSIONS BOA');
INSERT INTO compte VALUES (580, '62880', 'AUTRES  CHARGES EXTERNES');
INSERT INTO compte VALUES (581, '63680', 'AUTRES IMPOTS/TAXES/DROITS DIV');
INSERT INTO compte VALUES (582, '64100', 'REMUNERATION PERSONNEL');
INSERT INTO compte VALUES (583, '64120', 'DROIT DE CONGES');
INSERT INTO compte VALUES (584, '64511', 'CNAPS:COTISATION  PATRONALE');
INSERT INTO compte VALUES (585, '64512', 'OSTIE : COTISATION PATRONALE');
INSERT INTO compte VALUES (586, '64750', 'MED ET ASSIM PERS');
INSERT INTO compte VALUES (587, '65800', 'AUTRES CHARGES DIVERSES');
INSERT INTO compte VALUES (588, '65810', 'ECART/PAIEMENT');
INSERT INTO compte VALUES (589, '65811', 'PERTE/TVA NON RECUPERABLE');
INSERT INTO compte VALUES (590, '66200', 'INTERETS  BANCAIRES BNI');
INSERT INTO compte VALUES (591, '66300', 'INTERETS  BANCAIRES BOA');
INSERT INTO compte VALUES (592, '66600', 'DIFFF  DE  CHANGE  PERTE');
INSERT INTO compte VALUES (593, '66680', 'AGIOS/TRAITES');
INSERT INTO compte VALUES (594, '68110', 'D.A.P  IMMO INCORPORELLES');
INSERT INTO compte VALUES (595, '68120', 'D.A.P  IMMO  CORPORELLE');
INSERT INTO compte VALUES (596, '70110', 'VENTE LOCALE');
INSERT INTO compte VALUES (597, '70120', 'VENTES  A  L EXPORTATION');
INSERT INTO compte VALUES (598, '70800', 'AUTRES PROD  DES ACT ANNEX&ACS');
INSERT INTO compte VALUES (599, '71300', 'VARIATION DE STOCK  P.F');
INSERT INTO compte VALUES (600, '75800', 'AUTRES PRODUITS D EXPLOITATION');
INSERT INTO compte VALUES (601, '75810', 'ECART/ENCAISSEMENT');
INSERT INTO compte VALUES (602, '76200', 'INTERET CREDITEUR BANQUES BNI');
INSERT INTO compte VALUES (603, '76300', 'INTERET CREDITEUR BANQUES BOA');
INSERT INTO compte VALUES (604, '76600', 'DIFFERENCE DE  CHANGE:PROFIT');


--
-- Data for Name: description; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO description VALUES (1, 'nom');
INSERT INTO description VALUES (2, 'siege');
INSERT INTO description VALUES (3, 'objet');
INSERT INTO description VALUES (4, 'telephone');
INSERT INTO description VALUES (5, 'email');
INSERT INTO description VALUES (6, 'nif');
INSERT INTO description VALUES (7, 'ns');
INSERT INTO description VALUES (8, 'rcs');
INSERT INTO description VALUES (9, 'imagenif');
INSERT INTO description VALUES (10, 'imagercs');
INSERT INTO description VALUES (11, 'imagens');
INSERT INTO description VALUES (12, 'capital');
INSERT INTO description VALUES (13, 'tenue_compte(Ariary)');
INSERT INTO description VALUES (14, 'nb_employe');
INSERT INTO description VALUES (15, 'telecopie');


--
-- Data for Name: devise; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO devise VALUES (1, 'Ariary');
INSERT INTO devise VALUES (2, 'Euros');
INSERT INTO devise VALUES (3, 'Ariary');
INSERT INTO devise VALUES (4, 'Euros');
INSERT INTO devise VALUES (5, 'Dollar');
INSERT INTO devise VALUES (6, 'Dollar');
INSERT INTO devise VALUES (7, 'Dollar');


--
-- Data for Name: devisequivalence; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO devisequivalence VALUES (1, 1, 10.00, '2023-03-15');
INSERT INTO devisequivalence VALUES (2, 2, 60.00, '2023-03-15');
INSERT INTO devisequivalence VALUES (3, 1, 10.00, '2023-03-15');
INSERT INTO devisequivalence VALUES (4, 2, 60.00, '2023-03-15');
INSERT INTO devisequivalence VALUES (5, 7, 4200.00, '2023-03-15');


--
-- Data for Name: dirigeant; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO dirigeant VALUES (1, 'Rakotomanana', '2023-03-14', 'rakotomanana@gmail.com');
INSERT INTO dirigeant VALUES (2, 'Rakotomanana', '2023-03-14', 'rakotomanana@gmail.com');


--
-- Data for Name: exercice; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO exercice VALUES (1, '2023-01-01');
INSERT INTO exercice VALUES (2, '2023-01-01');


--
-- Data for Name: formulairesociete; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: informations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO informations VALUES (1, 1, 'Dimpex', '2023-03-17 17:50:51.309791');
INSERT INTO informations VALUES (2, 2, 'Andoharanoofotsy', '2023-03-17 17:50:51.322356');
INSERT INTO informations VALUES (3, 3, 'production d articles industriels et la vente de marchandises auprŠs de ces clients locaux et ‚trangers', '2023-03-17 17:50:51.333662');
INSERT INTO informations VALUES (4, 4, '22 770 99', '2023-03-17 17:50:51.342457');
INSERT INTO informations VALUES (5, 5, 'dimpex@gmail.com', '2023-03-17 17:50:51.353116');
INSERT INTO informations VALUES (6, 6, 'nif_1234', '2023-03-17 17:50:51.359538');
INSERT INTO informations VALUES (7, 7, 'ns_1234', '2023-03-17 17:50:51.371354');
INSERT INTO informations VALUES (8, 8, 'rcs_1234', '2023-03-17 17:50:51.381242');
INSERT INTO informations VALUES (9, 9, 'test.png', '2023-03-17 17:50:51.388884');
INSERT INTO informations VALUES (10, 10, 'test.png', '2023-03-17 17:50:51.400374');
INSERT INTO informations VALUES (11, 11, 'test.png', '2023-03-17 17:50:51.410064');
INSERT INTO informations VALUES (12, 12, '5000000000', '2023-03-17 17:50:51.424665');
INSERT INTO informations VALUES (13, 13, 'Ariary', '2023-03-17 17:50:51.43895');
INSERT INTO informations VALUES (14, 14, '500', '2023-03-17 17:50:51.444789');
INSERT INTO informations VALUES (15, 15, '22 230 66', '2023-03-17 17:50:51.453574');


--
-- Data for Name: journal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO journal VALUES (1, 'AC', 'Achats', '2023-03-14');
INSERT INTO journal VALUES (2, 'AN', 'A nouveau', '2023-03-14');
INSERT INTO journal VALUES (3, 'BN', 'Banque BNI', '2023-03-14');
INSERT INTO journal VALUES (4, 'BO', 'Banque BOA', '2023-03-14');
INSERT INTO journal VALUES (5, 'CA', 'Caise', '2023-03-14');
INSERT INTO journal VALUES (6, 'OD', 'Operations diverses', '2023-03-14');
INSERT INTO journal VALUES (7, 'VL', 'Ventes locales', '2023-03-14');
INSERT INTO journal VALUES (9, 'AC', 'Achats', '2023-03-14');
INSERT INTO journal VALUES (10, 'AN', 'A nouveau', '2023-03-14');
INSERT INTO journal VALUES (11, 'BN', 'Banque BNI', '2023-03-14');
INSERT INTO journal VALUES (12, 'BO', 'Banque BOA', '2023-03-14');
INSERT INTO journal VALUES (13, 'CA', 'Caise', '2023-03-14');
INSERT INTO journal VALUES (14, 'OD', 'Operations diverses', '2023-03-14');
INSERT INTO journal VALUES (15, 'VL', 'Ventes locales', '2023-03-14');


--
-- Data for Name: mois; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO mois VALUES (1, 'Janvier');
INSERT INTO mois VALUES (2, 'Fevrier');
INSERT INTO mois VALUES (3, 'Mars');
INSERT INTO mois VALUES (4, 'Avril');
INSERT INTO mois VALUES (5, 'Mais');
INSERT INTO mois VALUES (6, 'Juin');
INSERT INTO mois VALUES (7, 'Juillet');
INSERT INTO mois VALUES (8, 'Aout');
INSERT INTO mois VALUES (9, 'Septembre');
INSERT INTO mois VALUES (10, 'Octobre');
INSERT INTO mois VALUES (11, 'Novembre');
INSERT INTO mois VALUES (12, 'Decembre');


--
-- Data for Name: nbemploye; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tiers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO tiers VALUES (10, 605, 'TOVO');
INSERT INTO tiers VALUES (11, 605, 'TAHINA');
INSERT INTO tiers VALUES (12, 605, 'BAOVOLA');
INSERT INTO tiers VALUES (13, 605, 'ROJO');


--
-- Data for Name: verification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: admin_idadmin_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('admin_idadmin_seq', 1, true);


--
-- Name: compte_idcompte_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('compte_idcompte_seq', 605, true);


--
-- Name: description_iddescription_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('description_iddescription_seq', 15, true);


--
-- Name: devise_iddevise_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('devise_iddevise_seq', 7, true);


--
-- Name: devisequivalence_idquivalence_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('devisequivalence_idquivalence_seq', 5, true);


--
-- Name: dirigeant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('dirigeant_id_seq', 2, true);


--
-- Name: exercice_idexercice_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('exercice_idexercice_seq', 2, true);


--
-- Name: formulairesociete_idform_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('formulairesociete_idform_seq', 1, false);


--
-- Name: informations_idinfo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('informations_idinfo_seq', 15, true);


--
-- Name: journal_idjournal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('journal_idjournal_seq', 16, true);


--
-- Name: mois_idmois_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('mois_idmois_seq', 1, false);


--
-- Name: nbemploye_idnbempl_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('nbemploye_idnbempl_seq', 1, false);


--
-- Name: tiers_idtiers_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('tiers_idtiers_seq', 13, true);


--
-- Name: verification_idverif_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('verification_idverif_seq', 1, false);


--
-- Name: admin admin_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY admin
    ADD CONSTRAINT admin_nom_key UNIQUE (nom);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (idadmin);


--
-- Name: compte compte_numero_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY compte
    ADD CONSTRAINT compte_numero_key UNIQUE (numero);


--
-- Name: compte compte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY compte
    ADD CONSTRAINT compte_pkey PRIMARY KEY (idcompte);


--
-- Name: description description_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY description
    ADD CONSTRAINT description_pkey PRIMARY KEY (iddescription);


--
-- Name: devise devise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY devise
    ADD CONSTRAINT devise_pkey PRIMARY KEY (iddevise);


--
-- Name: devisequivalence devisequivalence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY devisequivalence
    ADD CONSTRAINT devisequivalence_pkey PRIMARY KEY (idquivalence);


--
-- Name: dirigeant dirigeant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dirigeant
    ADD CONSTRAINT dirigeant_pkey PRIMARY KEY (id);


--
-- Name: exercice exercice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY exercice
    ADD CONSTRAINT exercice_pkey PRIMARY KEY (idexercice);


--
-- Name: formulairesociete formulairesociete_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY formulairesociete
    ADD CONSTRAINT formulairesociete_pkey PRIMARY KEY (idform);


--
-- Name: informations informations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY informations
    ADD CONSTRAINT informations_pkey PRIMARY KEY (idinfo);


--
-- Name: journal journal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY journal
    ADD CONSTRAINT journal_pkey PRIMARY KEY (idjournal);


--
-- Name: mois mois_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY mois
    ADD CONSTRAINT mois_pkey PRIMARY KEY (idmois);


--
-- Name: nbemploye nbemploye_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY nbemploye
    ADD CONSTRAINT nbemploye_pkey PRIMARY KEY (idnbempl);


--
-- Name: tiers tiers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiers
    ADD CONSTRAINT tiers_pkey PRIMARY KEY (idtiers);


--
-- Name: verification verification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY verification
    ADD CONSTRAINT verification_pkey PRIMARY KEY (idverif);


--
-- Name: devisequivalence devisequivalence_iddevise_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY devisequivalence
    ADD CONSTRAINT devisequivalence_iddevise_fkey FOREIGN KEY (iddevise) REFERENCES devise(iddevise);


--
-- Name: informations informations_iddescription_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY informations
    ADD CONSTRAINT informations_iddescription_fkey FOREIGN KEY (iddescription) REFERENCES description(iddescription);


--
-- Name: tiers tiers_idcompte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY tiers
    ADD CONSTRAINT tiers_idcompte_fkey FOREIGN KEY (idcompte) REFERENCES compte(idcompte);


--
-- PostgreSQL database dump complete
--

