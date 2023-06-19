--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Ubuntu 14.8-0ubuntu0.22.10.1)
-- Dumped by pg_dump version 14.7 (Homebrew)

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
-- Name: user_role; Type: TYPE; Schema: public; Owner: sixguyshc
--

CREATE TYPE public.user_role AS ENUM (
    'superadmin',
    'hospitaladmin',
    'user'
);


ALTER TYPE public.user_role OWNER TO sixguyshc;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointments; Type: TABLE; Schema: public; Owner: sixguyshc
--

CREATE TABLE public.appointments (
    appointment_id integer NOT NULL,
    patient_id integer NOT NULL,
    doctor_id integer NOT NULL,
    clinic_id integer NOT NULL,
    name character varying(255) NOT NULL,
    date timestamp without time zone NOT NULL
);


ALTER TABLE public.appointments OWNER TO sixguyshc;

--
-- Name: appointment_appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: sixguyshc
--

CREATE SEQUENCE public.appointment_appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointment_appointment_id_seq OWNER TO sixguyshc;

--
-- Name: appointment_appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sixguyshc
--

ALTER SEQUENCE public.appointment_appointment_id_seq OWNED BY public.appointments.appointment_id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: sixguyshc
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO sixguyshc;

--
-- Name: clinics; Type: TABLE; Schema: public; Owner: sixguyshc
--

CREATE TABLE public.clinics (
    clinic_id integer NOT NULL,
    hospital_id integer NOT NULL,
    name character varying(255) NOT NULL,
    location character varying(255) NOT NULL
);


ALTER TABLE public.clinics OWNER TO sixguyshc;

--
-- Name: clinic_clinic_id_seq; Type: SEQUENCE; Schema: public; Owner: sixguyshc
--

CREATE SEQUENCE public.clinic_clinic_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.clinic_clinic_id_seq OWNER TO sixguyshc;

--
-- Name: clinic_clinic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sixguyshc
--

ALTER SEQUENCE public.clinic_clinic_id_seq OWNED BY public.clinics.clinic_id;


--
-- Name: doctors; Type: TABLE; Schema: public; Owner: sixguyshc
--

CREATE TABLE public.doctors (
    doctor_id integer NOT NULL,
    clinic_id integer NOT NULL,
    name character varying(255) NOT NULL,
    contact integer NOT NULL,
    email character varying(255) NOT NULL,
    role character varying(255) NOT NULL
);


ALTER TABLE public.doctors OWNER TO sixguyshc;

--
-- Name: doctor_doctor_id_seq; Type: SEQUENCE; Schema: public; Owner: sixguyshc
--

CREATE SEQUENCE public.doctor_doctor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doctor_doctor_id_seq OWNER TO sixguyshc;

--
-- Name: doctor_doctor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sixguyshc
--

ALTER SEQUENCE public.doctor_doctor_id_seq OWNED BY public.doctors.doctor_id;


--
-- Name: hospitals; Type: TABLE; Schema: public; Owner: sixguyshc
--

CREATE TABLE public.hospitals (
    hospital_id integer NOT NULL,
    name character varying(255) NOT NULL,
    location character varying(255) NOT NULL
);


ALTER TABLE public.hospitals OWNER TO sixguyshc;

--
-- Name: hospital_hospital_id_seq; Type: SEQUENCE; Schema: public; Owner: sixguyshc
--

CREATE SEQUENCE public.hospital_hospital_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hospital_hospital_id_seq OWNER TO sixguyshc;

--
-- Name: hospital_hospital_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sixguyshc
--

ALTER SEQUENCE public.hospital_hospital_id_seq OWNED BY public.hospitals.hospital_id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: sixguyshc
--

CREATE TABLE public.patients (
    patient_id integer NOT NULL,
    nric character varying(256) NOT NULL,
    fname character varying(256) NOT NULL,
    lname character varying(256) NOT NULL,
    phone integer NOT NULL,
    dob date NOT NULL,
    gender character varying(256) NOT NULL,
    race character varying(256) NOT NULL,
    vac_status character varying(256) NOT NULL,
    drug_allergy character varying(256) NOT NULL
);


ALTER TABLE public.patients OWNER TO sixguyshc;

--
-- Name: patient_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: sixguyshc
--

CREATE SEQUENCE public.patient_patient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.patient_patient_id_seq OWNER TO sixguyshc;

--
-- Name: patient_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sixguyshc
--

ALTER SEQUENCE public.patient_patient_id_seq OWNED BY public.patients.patient_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: sixguyshc
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO sixguyshc;

--
-- Name: users; Type: TABLE; Schema: public; Owner: sixguyshc
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp(6) without time zone,
    remember_created_at timestamp(6) without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    role character varying
);


ALTER TABLE public.users OWNER TO sixguyshc;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: sixguyshc
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO sixguyshc;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sixguyshc
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: appointments appointment_id; Type: DEFAULT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.appointments ALTER COLUMN appointment_id SET DEFAULT nextval('public.appointment_appointment_id_seq'::regclass);


--
-- Name: clinics clinic_id; Type: DEFAULT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.clinics ALTER COLUMN clinic_id SET DEFAULT nextval('public.clinic_clinic_id_seq'::regclass);


--
-- Name: doctors doctor_id; Type: DEFAULT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.doctors ALTER COLUMN doctor_id SET DEFAULT nextval('public.doctor_doctor_id_seq'::regclass);


--
-- Name: hospitals hospital_id; Type: DEFAULT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.hospitals ALTER COLUMN hospital_id SET DEFAULT nextval('public.hospital_hospital_id_seq'::regclass);


--
-- Name: patients patient_id; Type: DEFAULT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.patients ALTER COLUMN patient_id SET DEFAULT nextval('public.patient_patient_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: sixguyshc
--

COPY public.appointments (appointment_id, patient_id, doctor_id, clinic_id, name, date) FROM stdin;
\.


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: sixguyshc
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2023-05-19 14:01:20.464873	2023-05-19 14:01:20.464873
\.


--
-- Data for Name: clinics; Type: TABLE DATA; Schema: public; Owner: sixguyshc
--

COPY public.clinics (clinic_id, hospital_id, name, location) FROM stdin;
2	1	Hospital For Elites	Heaven
3	2	Eye Clinic	Mount Elizabeth
\.


--
-- Data for Name: doctors; Type: TABLE DATA; Schema: public; Owner: sixguyshc
--

COPY public.doctors (doctor_id, clinic_id, name, contact, email, role) FROM stdin;
3	2	Dr GodOfFortune	180999999	gof@god.com	Calculate your fortune
5	2	Dr Tom Lim	12345678	tomlim@gmail.com	Eye Specialist
\.


--
-- Data for Name: hospitals; Type: TABLE DATA; Schema: public; Owner: sixguyshc
--

COPY public.hospitals (hospital_id, name, location) FROM stdin;
1	Khoo Tech Puat Hospital	90 Yishun Central, Singapore 768828
2	Alexandra Hospital	378 Alexandra Road, Singapore 159964
3	Changi General Hospital	2 Simei Street 3, Singapore 529889
4	Institute of Mental Health	10 Buangkok View, Singapore 539747
5	KK Women's and Children's Hospital	100 Bukit Timah Road, Singapore 229899
6	National University Hospital	5 Lower Kent Ridge Road, Singapore 119074
7	Ng Teng Fong General Hospital	1 Jurong East Street 21, Singapore 609606
8	Sengkang General Hospital	110 Sengkang East Way, Singapore 544886
9	Singapore General Hospital	Outram Road, Singapore 169608
10	Tan Tock Seng Hospital	11 Jalan Tan Tock Seng, Singapore 308433
11	Yishun Community Hospital	2 Yishun Central 2, Singapore 768024
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: sixguyshc
--

COPY public.patients (patient_id, nric, fname, lname, phone, dob, gender, race, vac_status, drug_allergy) FROM stdin;
8	S1234567A	tom	tom	12345678	2023-05-01	m	chinese	test	test
9	s1234567a	Tom	Tan	12345678	2023-05-15	Male	Chinese	Vaccinated	Nil
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: sixguyshc
--

COPY public.schema_migrations (version) FROM stdin;
20230610170829
20230616054445
20230616073608
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sixguyshc
--

COPY public.users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, created_at, updated_at, role) FROM stdin;
1	a@a.com	$2a$12$DuFFHYp/ch18/ltgkLypMeNso8bHdljuxpmDzEb338HwOGyJZxahW	\N	\N	\N	2023-06-10 17:14:25.005408	2023-06-10 17:14:25.005408	\N
8	b@b.com	$2a$12$/7T5GBR60DVxgSh5v7xwxuXZQ86gIeSiz6CoF86u0eW4yxV.1/2jS	\N	\N	\N	2023-06-16 07:39:27.828349	2023-06-16 07:39:27.828349	\N
\.


--
-- Name: appointment_appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sixguyshc
--

SELECT pg_catalog.setval('public.appointment_appointment_id_seq', 1, false);


--
-- Name: clinic_clinic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sixguyshc
--

SELECT pg_catalog.setval('public.clinic_clinic_id_seq', 3, true);


--
-- Name: doctor_doctor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sixguyshc
--

SELECT pg_catalog.setval('public.doctor_doctor_id_seq', 5, true);


--
-- Name: hospital_hospital_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sixguyshc
--

SELECT pg_catalog.setval('public.hospital_hospital_id_seq', 11, true);


--
-- Name: patient_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sixguyshc
--

SELECT pg_catalog.setval('public.patient_patient_id_seq', 9, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sixguyshc
--

SELECT pg_catalog.setval('public.users_id_seq', 8, true);


--
-- Name: appointments appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (appointment_id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: clinics clinic_pkey; Type: CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.clinics
    ADD CONSTRAINT clinic_pkey PRIMARY KEY (clinic_id);


--
-- Name: doctors doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (doctor_id);


--
-- Name: hospitals hospital_pkey; Type: CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.hospitals
    ADD CONSTRAINT hospital_pkey PRIMARY KEY (hospital_id);


--
-- Name: patients patient_nric_key; Type: CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patient_nric_key UNIQUE (nric);


--
-- Name: patients patient_pkey; Type: CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patient_pkey PRIMARY KEY (patient_id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: sixguyshc
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: sixguyshc
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: doctors clinic_id; Type: FK CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.doctors
    ADD CONSTRAINT clinic_id FOREIGN KEY (clinic_id) REFERENCES public.clinics(clinic_id);


--
-- Name: appointments clinic_id; Type: FK CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT clinic_id FOREIGN KEY (clinic_id) REFERENCES public.clinics(clinic_id);


--
-- Name: appointments doctor_id; Type: FK CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT doctor_id FOREIGN KEY (doctor_id) REFERENCES public.doctors(doctor_id);


--
-- Name: clinics hospital_id; Type: FK CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.clinics
    ADD CONSTRAINT hospital_id FOREIGN KEY (hospital_id) REFERENCES public.hospitals(hospital_id);


--
-- Name: appointments patient_id; Type: FK CONSTRAINT; Schema: public; Owner: sixguyshc
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT patient_id FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- PostgreSQL database dump complete
--

