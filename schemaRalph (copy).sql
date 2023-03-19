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

CREATE FUNCTION public.getdatefin(date_debut date) RETURNS date
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN date_debut + INTERVAL '1 year - 1 day';
END;
$$;


ALTER FUNCTION public.getdatefin(date_debut date) OWNER TO postgres;

--
-- Name: getlast_infos(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getlast_infos() RETURNS TABLE(idinfo integer, iddescription integer, valeur text, created_at timestamp without time zone, description text)
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


ALTER FUNCTION public.getlast_infos() OWNER TO postgres;

--
-- Name: loop_devise(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.loop_devise() RETURNS TABLE(id_devise integer, nom text, idquivalence integer, taux numeric, date date)
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


ALTER FUNCTION public.loop_devise() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin (
    idadmin integer NOT NULL,
    nom character varying,
    mdp character varying
);


ALTER TABLE public.admin OWNER TO postgres;

--
-- Name: admin_idadmin_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_idadmin_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.admin_idadmin_seq OWNER TO postgres;

--
-- Name: admin_idadmin_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_idadmin_seq OWNED BY public.admin.idadmin;


--
-- Name: compte; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compte (
    idcompte integer NOT NULL,
    numero text NOT NULL,
    libelle text NOT NULL
);


ALTER TABLE public.compte OWNER TO postgres;

--
-- Name: compte_idcompte_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compte_idcompte_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.compte_idcompte_seq OWNER TO postgres;

--
-- Name: compte_idcompte_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compte_idcompte_seq OWNED BY public.compte.idcompte;


--
-- Name: compte_trie; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.compte_trie AS
 SELECT compte.idcompte,
    compte.numero,
    compte.libelle
   FROM public.compte
  ORDER BY compte.numero;


ALTER TABLE public.compte_trie OWNER TO postgres;

--
-- Name: exercice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercice (
    idexercice integer NOT NULL,
    debut date
);


ALTER TABLE public.exercice OWNER TO postgres;

--
-- Name: date_exercice; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.date_exercice AS
 SELECT exercice.idexercice,
    exercice.debut,
    public.getdatefin(exercice.debut) AS fin
   FROM public.exercice;


ALTER TABLE public.date_exercice OWNER TO postgres;

--
-- Name: date_exrcice_extract; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.date_exrcice_extract AS
 SELECT date_exercice.idexercice,
    to_char((date_exercice.debut)::timestamp with time zone, 'DD '::text) AS jour_debut,
    to_char((date_exercice.debut)::timestamp with time zone, 'MM'::text) AS mois_debut,
    to_char((date_exercice.debut)::timestamp with time zone, ' YYYY'::text) AS annee_debut,
    to_char((date_exercice.fin)::timestamp with time zone, 'DD '::text) AS jour_fin,
    to_char((date_exercice.fin)::timestamp with time zone, 'MM'::text) AS mois_fin,
    to_char((date_exercice.fin)::timestamp with time zone, ' YYYY'::text) AS annee_fin
   FROM public.date_exercice;


ALTER TABLE public.date_exrcice_extract OWNER TO postgres;

--
-- Name: description; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.description (
    iddescription integer NOT NULL,
    description text
);


ALTER TABLE public.description OWNER TO postgres;

--
-- Name: description_iddescription_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.description_iddescription_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.description_iddescription_seq OWNER TO postgres;

--
-- Name: description_iddescription_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.description_iddescription_seq OWNED BY public.description.iddescription;


--
-- Name: devise; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devise (
    iddevise integer NOT NULL,
    nom text NOT NULL
);


ALTER TABLE public.devise OWNER TO postgres;

--
-- Name: devise_iddevise_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.devise_iddevise_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.devise_iddevise_seq OWNER TO postgres;

--
-- Name: devise_iddevise_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.devise_iddevise_seq OWNED BY public.devise.iddevise;


--
-- Name: loop_devise; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.loop_devise AS
 SELECT loop_devise.id_devise,
    loop_devise.nom,
    loop_devise.idquivalence,
    loop_devise.taux,
    loop_devise.date
   FROM public.loop_devise() loop_devise(id_devise, nom, idquivalence, taux, date);


ALTER TABLE public.loop_devise OWNER TO postgres;

--
-- Name: devise_taux; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.devise_taux AS
 SELECT loop_devise.id_devise,
    loop_devise.nom,
    loop_devise.idquivalence,
    loop_devise.taux,
    loop_devise.date,
        CASE
            WHEN (loop_devise.date = CURRENT_DATE) THEN true
            ELSE false
        END AS maj
   FROM public.loop_devise;


ALTER TABLE public.devise_taux OWNER TO postgres;

--
-- Name: devisequivalence; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.devisequivalence (
    idquivalence integer NOT NULL,
    iddevise integer,
    taux numeric(10,2) NOT NULL,
    date date DEFAULT now()
);


ALTER TABLE public.devisequivalence OWNER TO postgres;

--
-- Name: devisequivalence_idquivalence_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.devisequivalence_idquivalence_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.devisequivalence_idquivalence_seq OWNER TO postgres;

--
-- Name: devisequivalence_idquivalence_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.devisequivalence_idquivalence_seq OWNED BY public.devisequivalence.idquivalence;


--
-- Name: dirigeant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dirigeant (
    id integer NOT NULL,
    nom text,
    date date,
    email text
);


ALTER TABLE public.dirigeant OWNER TO postgres;

--
-- Name: dirigeant_date_extract; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.dirigeant_date_extract AS
 SELECT dirigeant.id,
    dirigeant.nom,
    dirigeant.email,
    to_char((dirigeant.date)::timestamp with time zone, 'DD '::text) AS jour,
    to_char((dirigeant.date)::timestamp with time zone, 'MM'::text) AS mois,
    to_char((dirigeant.date)::timestamp with time zone, ' YYYY'::text) AS annee
   FROM public.dirigeant;


ALTER TABLE public.dirigeant_date_extract OWNER TO postgres;

--
-- Name: dirigeant_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dirigeant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dirigeant_id_seq OWNER TO postgres;

--
-- Name: dirigeant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dirigeant_id_seq OWNED BY public.dirigeant.id;


--
-- Name: exercice_idexercice_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exercice_idexercice_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.exercice_idexercice_seq OWNER TO postgres;

--
-- Name: exercice_idexercice_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exercice_idexercice_seq OWNED BY public.exercice.idexercice;


--
-- Name: formulairesociete; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.formulairesociete (
    idform integer NOT NULL,
    nom character varying,
    valeur character varying,
    date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.formulairesociete OWNER TO postgres;

--
-- Name: formulairesociete_idform_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.formulairesociete_idform_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.formulairesociete_idform_seq OWNER TO postgres;

--
-- Name: formulairesociete_idform_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.formulairesociete_idform_seq OWNED BY public.formulairesociete.idform;


--
-- Name: info_description; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.info_description AS
 SELECT getlast_infos.idinfo,
    getlast_infos.iddescription,
    getlast_infos.valeur,
    getlast_infos.created_at,
    getlast_infos.description
   FROM public.getlast_infos() getlast_infos(idinfo, iddescription, valeur, created_at, description);


ALTER TABLE public.info_description OWNER TO postgres;

--
-- Name: informations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.informations (
    idinfo integer NOT NULL,
    iddescription integer,
    valeur text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.informations OWNER TO postgres;

--
-- Name: informations_idinfo_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.informations_idinfo_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.informations_idinfo_seq OWNER TO postgres;

--
-- Name: informations_idinfo_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.informations_idinfo_seq OWNED BY public.informations.idinfo;


--
-- Name: journal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.journal (
    idjournal integer NOT NULL,
    code character varying NOT NULL,
    nom character varying NOT NULL,
    date date DEFAULT now()
);


ALTER TABLE public.journal OWNER TO postgres;

--
-- Name: journal_idjournal_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.journal_idjournal_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.journal_idjournal_seq OWNER TO postgres;

--
-- Name: journal_idjournal_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.journal_idjournal_seq OWNED BY public.journal.idjournal;


--
-- Name: mois; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mois (
    idmois integer NOT NULL,
    mois character varying(20)
);


ALTER TABLE public.mois OWNER TO postgres;

--
-- Name: mois_idmois_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.mois_idmois_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mois_idmois_seq OWNER TO postgres;

--
-- Name: mois_idmois_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.mois_idmois_seq OWNED BY public.mois.idmois;


--
-- Name: nbemploye; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nbemploye (
    idnbempl integer NOT NULL,
    valeur integer,
    date date DEFAULT now()
);


ALTER TABLE public.nbemploye OWNER TO postgres;

--
-- Name: nbemploye_idnbempl_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nbemploye_idnbempl_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.nbemploye_idnbempl_seq OWNER TO postgres;

--
-- Name: nbemploye_idnbempl_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nbemploye_idnbempl_seq OWNED BY public.nbemploye.idnbempl;


--
-- Name: tiers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tiers (
    idtiers integer NOT NULL,
    idcompte integer,
    nom text NOT NULL
);


ALTER TABLE public.tiers OWNER TO postgres;

--
-- Name: tiers_alphabet; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.tiers_alphabet AS
 SELECT tiers.idtiers,
    tiers.idcompte,
    tiers.nom
   FROM public.tiers
  ORDER BY tiers.nom;


ALTER TABLE public.tiers_alphabet OWNER TO postgres;

--
-- Name: tiers_compte; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.tiers_compte AS
 SELECT tiers_alphabet.idtiers,
    tiers_alphabet.idcompte,
    tiers_alphabet.nom,
    compte.numero
   FROM (public.tiers_alphabet
     JOIN public.compte ON ((tiers_alphabet.idcompte = compte.idcompte)));


ALTER TABLE public.tiers_compte OWNER TO postgres;

--
-- Name: tiers_idtiers_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tiers_idtiers_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tiers_idtiers_seq OWNER TO postgres;

--
-- Name: tiers_idtiers_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tiers_idtiers_seq OWNED BY public.tiers.idtiers;


--
-- Name: verification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification (
    idverif integer NOT NULL,
    name character varying,
    min numeric,
    max numeric
);


ALTER TABLE public.verification OWNER TO postgres;

--
-- Name: verification_idverif_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.verification_idverif_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.verification_idverif_seq OWNER TO postgres;

--
-- Name: verification_idverif_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.verification_idverif_seq OWNED BY public.verification.idverif;


--
-- Name: admin idadmin; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin ALTER COLUMN idadmin SET DEFAULT nextval('public.admin_idadmin_seq'::regclass);


--
-- Name: compte idcompte; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compte ALTER COLUMN idcompte SET DEFAULT nextval('public.compte_idcompte_seq'::regclass);


--
-- Name: description iddescription; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.description ALTER COLUMN iddescription SET DEFAULT nextval('public.description_iddescription_seq'::regclass);


--
-- Name: devise iddevise; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devise ALTER COLUMN iddevise SET DEFAULT nextval('public.devise_iddevise_seq'::regclass);


--
-- Name: devisequivalence idquivalence; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devisequivalence ALTER COLUMN idquivalence SET DEFAULT nextval('public.devisequivalence_idquivalence_seq'::regclass);


--
-- Name: dirigeant id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dirigeant ALTER COLUMN id SET DEFAULT nextval('public.dirigeant_id_seq'::regclass);


--
-- Name: exercice idexercice; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercice ALTER COLUMN idexercice SET DEFAULT nextval('public.exercice_idexercice_seq'::regclass);


--
-- Name: formulairesociete idform; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formulairesociete ALTER COLUMN idform SET DEFAULT nextval('public.formulairesociete_idform_seq'::regclass);


--
-- Name: informations idinfo; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.informations ALTER COLUMN idinfo SET DEFAULT nextval('public.informations_idinfo_seq'::regclass);


--
-- Name: journal idjournal; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.journal ALTER COLUMN idjournal SET DEFAULT nextval('public.journal_idjournal_seq'::regclass);


--
-- Name: mois idmois; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mois ALTER COLUMN idmois SET DEFAULT nextval('public.mois_idmois_seq'::regclass);


--
-- Name: nbemploye idnbempl; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nbemploye ALTER COLUMN idnbempl SET DEFAULT nextval('public.nbemploye_idnbempl_seq'::regclass);


--
-- Name: tiers idtiers; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiers ALTER COLUMN idtiers SET DEFAULT nextval('public.tiers_idtiers_seq'::regclass);


--
-- Name: verification idverif; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification ALTER COLUMN idverif SET DEFAULT nextval('public.verification_idverif_seq'::regclass);


--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.admin VALUES (1, 'admin', '1234');


--
-- Data for Name: compte; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.compte VALUES (605, '41100', 'clients Andoharanofotsy');
INSERT INTO public.compte VALUES (471, 'COMPTE', 'INTITULE');
INSERT INTO public.compte VALUES (472, '10100', 'CAPITAL');
INSERT INTO public.compte VALUES (473, '10610', 'RESERVE LEGALE');
INSERT INTO public.compte VALUES (474, '11000', 'REPORT A NOUVEAU');
INSERT INTO public.compte VALUES (475, '11010', 'REPORT A NOUVEAU SOLDE CREDITEUR');
INSERT INTO public.compte VALUES (476, '11200', 'AUTRES PRODUITS ET CHARGES');
INSERT INTO public.compte VALUES (477, '11900', 'REPORT A NOUVEAU SOLDE DEBITEUR');
INSERT INTO public.compte VALUES (478, '12800', 'RESULTAT EN INSTANCE');
INSERT INTO public.compte VALUES (479, '13300', 'IMPOTS DIFFERES ACTIFS');
INSERT INTO public.compte VALUES (480, '16110', 'EMPRUNT A LT');
INSERT INTO public.compte VALUES (481, '16510', 'ENMPRUNT A MOYEN TERME');
INSERT INTO public.compte VALUES (482, '20124', 'FRAIS DE REHABILITATION');
INSERT INTO public.compte VALUES (483, '20800', 'AUTRES IMMOB INCORPORELLES');
INSERT INTO public.compte VALUES (484, '21100', 'TERRAINS');
INSERT INTO public.compte VALUES (485, '21200', 'CONSTRUCTION');
INSERT INTO public.compte VALUES (486, '21300', 'MATERIEL ET OUTILLAGE');
INSERT INTO public.compte VALUES (487, '21510', 'MATERIEL AUTOMOBILE');
INSERT INTO public.compte VALUES (488, '21520', 'MATERIEL MOTO');
INSERT INTO public.compte VALUES (489, '21600', 'AGENCEMENT. AM .INST');
INSERT INTO public.compte VALUES (490, '21810', 'MATERIELS ET MOBILIERS DE BUREAU');
INSERT INTO public.compte VALUES (491, '21819', 'MATERIELS INFORMATIQUES ET AUTRES');
INSERT INTO public.compte VALUES (492, '21820', 'MAT. MOB DE LOGEMENT');
INSERT INTO public.compte VALUES (493, '21880', 'AUTRES IMMOBILISATIONS CORP');
INSERT INTO public.compte VALUES (494, '23000', 'IMMOBILISATION EN COURS');
INSERT INTO public.compte VALUES (495, '28000', 'AMORT IMMOB INCORP');
INSERT INTO public.compte VALUES (496, '28120', 'AMORTISSEMENT DES CONSTRUCTIONS');
INSERT INTO public.compte VALUES (497, '28130', 'AMORT MACH-MATER-OUTIL');
INSERT INTO public.compte VALUES (498, '28150', 'AMORT MAT DE TRANSPORT');
INSERT INTO public.compte VALUES (499, '28160', 'AMORT A.A.I');
INSERT INTO public.compte VALUES (500, '28181', 'AMORT MATERIEL&MOB');
INSERT INTO public.compte VALUES (501, '28182', 'AMORTISSEMENTS MATERIELS INFORMATIQ');
INSERT INTO public.compte VALUES (502, '28183', 'AMORT MATER & MOB LOGT');
INSERT INTO public.compte VALUES (503, '32110', 'STOCK MATIERES PREMIERES');
INSERT INTO public.compte VALUES (504, '35500', 'STOCK PRODUITS FINIS');
INSERT INTO public.compte VALUES (505, '37000', 'STOCK MARCHANDISES');
INSERT INTO public.compte VALUES (506, '39700', 'PROVISIONS/DEPRECIATIONS STOCKS');
INSERT INTO public.compte VALUES (507, '40110', 'FOURNISSEURS DEXPLOITATIONS LOCAUX');
INSERT INTO public.compte VALUES (508, '40120', 'FOURNISSEURS DEXPLOITATIONS ETRANGERS');
INSERT INTO public.compte VALUES (509, '40310', 'FOURNISSEURS D''IMMOBILISATION');
INSERT INTO public.compte VALUES (510, '40810', 'FRNS: FACTURE A RECEVOIR');
INSERT INTO public.compte VALUES (511, '40910', 'FRNS:AVANCES&ACOMPTES VERSER');
INSERT INTO public.compte VALUES (512, '40980', 'FRNS: RABAIS A OBTENIR');
INSERT INTO public.compte VALUES (513, '41110', 'CLIENTS LOCAUX');
INSERT INTO public.compte VALUES (514, '41120', 'CLIENTS ETRANGERS');
INSERT INTO public.compte VALUES (515, '41400', 'CLIENTS DOUTEUX');
INSERT INTO public.compte VALUES (516, '41800', 'CLIENTS FACTURE A RETABLIR');
INSERT INTO public.compte VALUES (517, '42100', 'PERSONNEL: SALAIRES A PAYER');
INSERT INTO public.compte VALUES (518, '42510', 'PERSONNEL: AVANCES QUINZAINES');
INSERT INTO public.compte VALUES (519, '42520', 'PERSONNEL: AVANCES SPECIALES');
INSERT INTO public.compte VALUES (520, '42860', 'PERS:CHARGES  A PAYER');
INSERT INTO public.compte VALUES (521, '43100', 'CNAPS ');
INSERT INTO public.compte VALUES (522, '43120', 'OSTIE');
INSERT INTO public.compte VALUES (523, '44200', 'ETAT IBS');
INSERT INTO public.compte VALUES (524, '44210', 'ACOMPTE IBS');
INSERT INTO public.compte VALUES (525, '44321', 'TVA IMPUTER:DEC ULTERIEURE');
INSERT INTO public.compte VALUES (526, '44500', 'ETAT:IRSA VERSER');
INSERT INTO public.compte VALUES (527, '44560', 'ETAT: TVA DEDUCTIBLE');
INSERT INTO public.compte VALUES (528, '44570', 'ETAT: TVA COLLECTEE');
INSERT INTO public.compte VALUES (529, '44571', 'TVA A VERSER');
INSERT INTO public.compte VALUES (530, '45100', 'COMPTE  COURANT ASSOC');
INSERT INTO public.compte VALUES (531, '46700', 'DEB/CRED DIVERS');
INSERT INTO public.compte VALUES (532, '46800', 'CHARGES A PAYER DEB/CRED DIVERS');
INSERT INTO public.compte VALUES (533, '48610', 'CHARGE CONSTATES D''AVANCE');
INSERT INTO public.compte VALUES (534, '49100', 'PERTE/CLIENTS');
INSERT INTO public.compte VALUES (535, '51200', 'BOA ANKORONDRANO');
INSERT INTO public.compte VALUES (536, '51201', 'BOA DOLLARS');
INSERT INTO public.compte VALUES (537, '51202', 'BNI MADAGASCAR');
INSERT INTO public.compte VALUES (538, '51203', 'BNI DOLLARS');
INSERT INTO public.compte VALUES (539, '53100', 'CAISSE ');
INSERT INTO public.compte VALUES (540, '58110', 'VIREMENTINTERNE:BANQ/CAISSE');
INSERT INTO public.compte VALUES (541, '58130', 'VIREMENT INTERNE:BANQ/BANQ');
INSERT INTO public.compte VALUES (542, '58140', 'VIREMENT INTERNE CAISSE/CAISSE');
INSERT INTO public.compte VALUES (543, '60100', 'ACHAT MATIERES PREMIERESS');
INSERT INTO public.compte VALUES (544, '60200', 'FOURNIT DE MAGASIN');
INSERT INTO public.compte VALUES (545, '60210', 'FOURNIT BUR ');
INSERT INTO public.compte VALUES (546, '60220', 'FOURNIT DE LOGT');
INSERT INTO public.compte VALUES (547, '60230', 'EMBALLAGES(PLAST-CARTON....');
INSERT INTO public.compte VALUES (548, '60240', 'PIEC RECH VOITURES ADMINISTRATIVES');
INSERT INTO public.compte VALUES (549, '60241', 'PIEC RECH CAMIONS');
INSERT INTO public.compte VALUES (550, '60242', 'PIEC RECH MOTO');
INSERT INTO public.compte VALUES (551, '60250', 'AUTRES ACHATS');
INSERT INTO public.compte VALUES (552, '60300', 'VARIATION  STOCK MAT PREM');
INSERT INTO public.compte VALUES (553, '60610', 'EAU ET ELECTRICITE');
INSERT INTO public.compte VALUES (554, '60620', 'GAZ,COMBUST,CARBURANT,LUBRIF');
INSERT INTO public.compte VALUES (555, '61300', 'LOC IMMOBILIERES');
INSERT INTO public.compte VALUES (556, '61380', 'AUTRES LOCATIONS');
INSERT INTO public.compte VALUES (557, '61550', 'ENTRET & REP VEHICULE');
INSERT INTO public.compte VALUES (558, '61560', 'MAINTENANCE');
INSERT INTO public.compte VALUES (559, '61610', 'ASSURANCE GLOBALE DOMMAGES');
INSERT INTO public.compte VALUES (560, '61611', 'ASSURANCE FLOTTE AUTOMOBILE');
INSERT INTO public.compte VALUES (561, '61800', 'PHOTOCOPIE ET ASSIMILES ');
INSERT INTO public.compte VALUES (562, '61810', 'ENVOI COLIS(LETTRE&DOC...');
INSERT INTO public.compte VALUES (563, '62100', 'PERSONNEL EXTER');
INSERT INTO public.compte VALUES (564, '62210', 'HONORAIRE');
INSERT INTO public.compte VALUES (565, '62220', 'REMUNERATION DES TRANSITAIRES');
INSERT INTO public.compte VALUES (566, '62230', 'CATALOGUES ET IMPRIMES');
INSERT INTO public.compte VALUES (567, '62240', 'PUBLICATION');
INSERT INTO public.compte VALUES (568, '62250', 'SPONSORING-MECENAT...');
INSERT INTO public.compte VALUES (569, '62260', 'TS DOUANE ET ASSIMILES');
INSERT INTO public.compte VALUES (570, '62400', 'FRAIS DE TRANSPORT');
INSERT INTO public.compte VALUES (571, '62510', 'VOYAGES   ET DEPLACEMENT');
INSERT INTO public.compte VALUES (572, '62520', 'MISSION(DEPL+HEBERGT+REST)');
INSERT INTO public.compte VALUES (573, '62530', 'RECEPTION');
INSERT INTO public.compte VALUES (574, '62610', 'SERVICES POSTAUX');
INSERT INTO public.compte VALUES (575, '62620', 'TEL&FAX');
INSERT INTO public.compte VALUES (576, '62630', 'INTERNET TANA');
INSERT INTO public.compte VALUES (577, '62740', 'COMMISSIONS BANCAIRE INTERNATIONALE');
INSERT INTO public.compte VALUES (578, '62760', 'COMMISSIONS BNI');
INSERT INTO public.compte VALUES (579, '62770', 'COMMISSIONS BOA');
INSERT INTO public.compte VALUES (580, '62880', 'AUTRES  CHARGES EXTERNES');
INSERT INTO public.compte VALUES (581, '63680', 'AUTRES IMPOTS/TAXES/DROITS DIV');
INSERT INTO public.compte VALUES (582, '64100', 'REMUNERATION PERSONNEL');
INSERT INTO public.compte VALUES (583, '64120', 'DROIT DE CONGES');
INSERT INTO public.compte VALUES (584, '64511', 'CNAPS:COTISATION  PATRONALE');
INSERT INTO public.compte VALUES (585, '64512', 'OSTIE : COTISATION PATRONALE');
INSERT INTO public.compte VALUES (586, '64750', 'MED ET ASSIM PERS');
INSERT INTO public.compte VALUES (587, '65800', 'AUTRES CHARGES DIVERSES');
INSERT INTO public.compte VALUES (588, '65810', 'ECART/PAIEMENT');
INSERT INTO public.compte VALUES (589, '65811', 'PERTE/TVA NON RECUPERABLE');
INSERT INTO public.compte VALUES (590, '66200', 'INTERETS  BANCAIRES BNI');
INSERT INTO public.compte VALUES (591, '66300', 'INTERETS  BANCAIRES BOA');
INSERT INTO public.compte VALUES (592, '66600', 'DIFFF  DE  CHANGE  PERTE');
INSERT INTO public.compte VALUES (593, '66680', 'AGIOS/TRAITES');
INSERT INTO public.compte VALUES (594, '68110', 'D.A.P  IMMO INCORPORELLES');
INSERT INTO public.compte VALUES (595, '68120', 'D.A.P  IMMO  CORPORELLE');
INSERT INTO public.compte VALUES (596, '70110', 'VENTE LOCALE');
INSERT INTO public.compte VALUES (597, '70120', 'VENTES  A  L EXPORTATION');
INSERT INTO public.compte VALUES (598, '70800', 'AUTRES PROD  DES ACT ANNEX&ACS');
INSERT INTO public.compte VALUES (599, '71300', 'VARIATION DE STOCK  P.F');
INSERT INTO public.compte VALUES (600, '75800', 'AUTRES PRODUITS D EXPLOITATION');
INSERT INTO public.compte VALUES (601, '75810', 'ECART/ENCAISSEMENT');
INSERT INTO public.compte VALUES (602, '76200', 'INTERET CREDITEUR BANQUES BNI');
INSERT INTO public.compte VALUES (603, '76300', 'INTERET CREDITEUR BANQUES BOA');
INSERT INTO public.compte VALUES (604, '76600', 'DIFFERENCE DE  CHANGE:PROFIT');


--
-- Data for Name: description; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.description VALUES (1, 'nom');
INSERT INTO public.description VALUES (2, 'siege');
INSERT INTO public.description VALUES (3, 'objet');
INSERT INTO public.description VALUES (4, 'telephone');
INSERT INTO public.description VALUES (5, 'email');
INSERT INTO public.description VALUES (6, 'nif');
INSERT INTO public.description VALUES (7, 'ns');
INSERT INTO public.description VALUES (8, 'rcs');
INSERT INTO public.description VALUES (9, 'imagenif');
INSERT INTO public.description VALUES (10, 'imagercs');
INSERT INTO public.description VALUES (11, 'imagens');
INSERT INTO public.description VALUES (12, 'capital');
INSERT INTO public.description VALUES (13, 'tenue_compte(Ariary)');
INSERT INTO public.description VALUES (14, 'nb_employe');
INSERT INTO public.description VALUES (15, 'telecopie');


--
-- Data for Name: devise; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.devise VALUES (1, 'Ariary');
INSERT INTO public.devise VALUES (2, 'Euros');
INSERT INTO public.devise VALUES (3, 'Ariary');
INSERT INTO public.devise VALUES (4, 'Euros');
INSERT INTO public.devise VALUES (5, 'Dollar');
INSERT INTO public.devise VALUES (6, 'Dollar');
INSERT INTO public.devise VALUES (7, 'Dollar');


--
-- Data for Name: devisequivalence; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.devisequivalence VALUES (1, 1, 10.00, '2023-03-15');
INSERT INTO public.devisequivalence VALUES (2, 2, 60.00, '2023-03-15');
INSERT INTO public.devisequivalence VALUES (3, 1, 10.00, '2023-03-15');
INSERT INTO public.devisequivalence VALUES (4, 2, 60.00, '2023-03-15');
INSERT INTO public.devisequivalence VALUES (5, 7, 4200.00, '2023-03-15');


--
-- Data for Name: dirigeant; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.dirigeant VALUES (1, 'Rakotomanana', '2023-03-14', 'rakotomanana@gmail.com');
INSERT INTO public.dirigeant VALUES (2, 'Rakotomanana', '2023-03-14', 'rakotomanana@gmail.com');


--
-- Data for Name: exercice; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.exercice VALUES (1, '2023-01-01');
INSERT INTO public.exercice VALUES (2, '2023-01-01');


--
-- Data for Name: formulairesociete; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: informations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.informations VALUES (1, 1, 'Dimpex', '2023-03-17 17:50:51.309791');
INSERT INTO public.informations VALUES (2, 2, 'Andoharanoofotsy', '2023-03-17 17:50:51.322356');
INSERT INTO public.informations VALUES (3, 3, 'production d articles industriels et la vente de marchandises auprŠs de ces clients locaux et ‚trangers', '2023-03-17 17:50:51.333662');
INSERT INTO public.informations VALUES (4, 4, '22 770 99', '2023-03-17 17:50:51.342457');
INSERT INTO public.informations VALUES (5, 5, 'dimpex@gmail.com', '2023-03-17 17:50:51.353116');
INSERT INTO public.informations VALUES (6, 6, 'nif_1234', '2023-03-17 17:50:51.359538');
INSERT INTO public.informations VALUES (7, 7, 'ns_1234', '2023-03-17 17:50:51.371354');
INSERT INTO public.informations VALUES (8, 8, 'rcs_1234', '2023-03-17 17:50:51.381242');
INSERT INTO public.informations VALUES (9, 9, 'test.png', '2023-03-17 17:50:51.388884');
INSERT INTO public.informations VALUES (10, 10, 'test.png', '2023-03-17 17:50:51.400374');
INSERT INTO public.informations VALUES (11, 11, 'test.png', '2023-03-17 17:50:51.410064');
INSERT INTO public.informations VALUES (12, 12, '5000000000', '2023-03-17 17:50:51.424665');
INSERT INTO public.informations VALUES (13, 13, 'Ariary', '2023-03-17 17:50:51.43895');
INSERT INTO public.informations VALUES (14, 14, '500', '2023-03-17 17:50:51.444789');
INSERT INTO public.informations VALUES (15, 15, '22 230 66', '2023-03-17 17:50:51.453574');


--
-- Data for Name: journal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.journal VALUES (1, 'AC', 'Achats', '2023-03-14');
INSERT INTO public.journal VALUES (2, 'AN', 'A nouveau', '2023-03-14');
INSERT INTO public.journal VALUES (3, 'BN', 'Banque BNI', '2023-03-14');
INSERT INTO public.journal VALUES (4, 'BO', 'Banque BOA', '2023-03-14');
INSERT INTO public.journal VALUES (5, 'CA', 'Caise', '2023-03-14');
INSERT INTO public.journal VALUES (6, 'OD', 'Operations diverses', '2023-03-14');
INSERT INTO public.journal VALUES (7, 'VL', 'Ventes locales', '2023-03-14');
INSERT INTO public.journal VALUES (9, 'AC', 'Achats', '2023-03-14');
INSERT INTO public.journal VALUES (10, 'AN', 'A nouveau', '2023-03-14');
INSERT INTO public.journal VALUES (11, 'BN', 'Banque BNI', '2023-03-14');
INSERT INTO public.journal VALUES (12, 'BO', 'Banque BOA', '2023-03-14');
INSERT INTO public.journal VALUES (13, 'CA', 'Caise', '2023-03-14');
INSERT INTO public.journal VALUES (14, 'OD', 'Operations diverses', '2023-03-14');
INSERT INTO public.journal VALUES (15, 'VL', 'Ventes locales', '2023-03-14');


--
-- Data for Name: mois; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.mois VALUES (1, 'Janvier');
INSERT INTO public.mois VALUES (2, 'Fevrier');
INSERT INTO public.mois VALUES (3, 'Mars');
INSERT INTO public.mois VALUES (4, 'Avril');
INSERT INTO public.mois VALUES (5, 'Mais');
INSERT INTO public.mois VALUES (6, 'Juin');
INSERT INTO public.mois VALUES (7, 'Juillet');
INSERT INTO public.mois VALUES (8, 'Aout');
INSERT INTO public.mois VALUES (9, 'Septembre');
INSERT INTO public.mois VALUES (10, 'Octobre');
INSERT INTO public.mois VALUES (11, 'Novembre');
INSERT INTO public.mois VALUES (12, 'Decembre');


--
-- Data for Name: nbemploye; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tiers; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tiers VALUES (10, 605, 'TOVO');
INSERT INTO public.tiers VALUES (11, 605, 'TAHINA');
INSERT INTO public.tiers VALUES (12, 605, 'BAOVOLA');
INSERT INTO public.tiers VALUES (13, 605, 'ROJO');


--
-- Data for Name: verification; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: admin_idadmin_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_idadmin_seq', 1, true);


--
-- Name: compte_idcompte_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compte_idcompte_seq', 605, true);


--
-- Name: description_iddescription_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.description_iddescription_seq', 15, true);


--
-- Name: devise_iddevise_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.devise_iddevise_seq', 7, true);


--
-- Name: devisequivalence_idquivalence_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.devisequivalence_idquivalence_seq', 5, true);


--
-- Name: dirigeant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dirigeant_id_seq', 2, true);


--
-- Name: exercice_idexercice_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exercice_idexercice_seq', 2, true);


--
-- Name: formulairesociete_idform_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.formulairesociete_idform_seq', 1, false);


--
-- Name: informations_idinfo_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.informations_idinfo_seq', 15, true);


--
-- Name: journal_idjournal_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.journal_idjournal_seq', 16, true);


--
-- Name: mois_idmois_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.mois_idmois_seq', 1, false);


--
-- Name: nbemploye_idnbempl_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nbemploye_idnbempl_seq', 1, false);


--
-- Name: tiers_idtiers_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tiers_idtiers_seq', 13, true);


--
-- Name: verification_idverif_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.verification_idverif_seq', 1, false);


--
-- Name: admin admin_nom_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_nom_key UNIQUE (nom);


--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (idadmin);


--
-- Name: compte compte_numero_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compte
    ADD CONSTRAINT compte_numero_key UNIQUE (numero);


--
-- Name: compte compte_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compte
    ADD CONSTRAINT compte_pkey PRIMARY KEY (idcompte);


--
-- Name: description description_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.description
    ADD CONSTRAINT description_pkey PRIMARY KEY (iddescription);


--
-- Name: devise devise_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devise
    ADD CONSTRAINT devise_pkey PRIMARY KEY (iddevise);


--
-- Name: devisequivalence devisequivalence_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devisequivalence
    ADD CONSTRAINT devisequivalence_pkey PRIMARY KEY (idquivalence);


--
-- Name: dirigeant dirigeant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dirigeant
    ADD CONSTRAINT dirigeant_pkey PRIMARY KEY (id);


--
-- Name: exercice exercice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercice
    ADD CONSTRAINT exercice_pkey PRIMARY KEY (idexercice);


--
-- Name: formulairesociete formulairesociete_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.formulairesociete
    ADD CONSTRAINT formulairesociete_pkey PRIMARY KEY (idform);


--
-- Name: informations informations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.informations
    ADD CONSTRAINT informations_pkey PRIMARY KEY (idinfo);


--
-- Name: journal journal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.journal
    ADD CONSTRAINT journal_pkey PRIMARY KEY (idjournal);


--
-- Name: mois mois_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mois
    ADD CONSTRAINT mois_pkey PRIMARY KEY (idmois);


--
-- Name: nbemploye nbemploye_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nbemploye
    ADD CONSTRAINT nbemploye_pkey PRIMARY KEY (idnbempl);


--
-- Name: tiers tiers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiers
    ADD CONSTRAINT tiers_pkey PRIMARY KEY (idtiers);


--
-- Name: verification verification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification
    ADD CONSTRAINT verification_pkey PRIMARY KEY (idverif);


--
-- Name: devisequivalence devisequivalence_iddevise_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.devisequivalence
    ADD CONSTRAINT devisequivalence_iddevise_fkey FOREIGN KEY (iddevise) REFERENCES public.devise(iddevise);


--
-- Name: informations informations_iddescription_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.informations
    ADD CONSTRAINT informations_iddescription_fkey FOREIGN KEY (iddescription) REFERENCES public.description(iddescription);


--
-- Name: tiers tiers_idcompte_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tiers
    ADD CONSTRAINT tiers_idcompte_fkey FOREIGN KEY (idcompte) REFERENCES public.compte(idcompte);


--
-- PostgreSQL database dump complete
--

