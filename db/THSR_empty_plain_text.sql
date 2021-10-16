--
-- PostgreSQL database dump
--

-- Dumped from database version 13.3
-- Dumped by pg_dump version 13.3

-- Started on 2021-10-17 00:58:40 CST

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
-- TOC entry 4 (class 2615 OID 16982)
-- Name: THSR; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "THSR";


ALTER SCHEMA "THSR" OWNER TO postgres;

--
-- TOC entry 3341 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA "THSR"; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA "THSR" IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 16983)
-- Name: discount; Type: TABLE; Schema: THSR; Owner: postgres
--

CREATE TABLE "THSR".discount (
    discount_id integer NOT NULL,
    type text NOT NULL,
    discount_rate real
);


ALTER TABLE "THSR".discount OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16989)
-- Name: discount_discount_id_seq; Type: SEQUENCE; Schema: THSR; Owner: postgres
--

CREATE SEQUENCE "THSR".discount_discount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "THSR".discount_discount_id_seq OWNER TO postgres;

--
-- TOC entry 3342 (class 0 OID 0)
-- Dependencies: 202
-- Name: discount_discount_id_seq; Type: SEQUENCE OWNED BY; Schema: THSR; Owner: postgres
--

ALTER SEQUENCE "THSR".discount_discount_id_seq OWNED BY "THSR".discount.discount_id;


--
-- TOC entry 203 (class 1259 OID 16991)
-- Name: fare; Type: TABLE; Schema: THSR; Owner: postgres
--

CREATE TABLE "THSR".fare (
    fare_id integer NOT NULL,
    origin_station_id text NOT NULL,
    destination_station_id text NOT NULL,
    business_fare real NOT NULL,
    standard_fare real NOT NULL,
    non_reserved_fare real NOT NULL
);


ALTER TABLE "THSR".fare OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16997)
-- Name: fare_fare_id_seq; Type: SEQUENCE; Schema: THSR; Owner: postgres
--

CREATE SEQUENCE "THSR".fare_fare_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "THSR".fare_fare_id_seq OWNER TO postgres;

--
-- TOC entry 3343 (class 0 OID 0)
-- Dependencies: 204
-- Name: fare_fare_id_seq; Type: SEQUENCE OWNED BY; Schema: THSR; Owner: postgres
--

ALTER SEQUENCE "THSR".fare_fare_id_seq OWNED BY "THSR".fare.fare_id;


--
-- TOC entry 205 (class 1259 OID 16999)
-- Name: schedule; Type: TABLE; Schema: THSR; Owner: postgres
--

CREATE TABLE "THSR".schedule (
    schedule_id integer NOT NULL,
    train_id text NOT NULL,
    stop_sequence integer NOT NULL,
    station_id text NOT NULL,
    arrival_time text,
    departure_time text
);


ALTER TABLE "THSR".schedule OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 17005)
-- Name: schedule_schedule_id_seq; Type: SEQUENCE; Schema: THSR; Owner: postgres
--

CREATE SEQUENCE "THSR".schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE "THSR".schedule_schedule_id_seq OWNER TO postgres;

--
-- TOC entry 3344 (class 0 OID 0)
-- Dependencies: 206
-- Name: schedule_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: THSR; Owner: postgres
--

ALTER SEQUENCE "THSR".schedule_schedule_id_seq OWNED BY "THSR".schedule.schedule_id;


--
-- TOC entry 207 (class 1259 OID 17007)
-- Name: station; Type: TABLE; Schema: THSR; Owner: postgres
--

CREATE TABLE "THSR".station (
    station_id text NOT NULL,
    station_name text NOT NULL
);


ALTER TABLE "THSR".station OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 17013)
-- Name: train; Type: TABLE; Schema: THSR; Owner: postgres
--

CREATE TABLE "THSR".train (
    train_id text NOT NULL,
    starting_station_id text NOT NULL,
    ending_station_id text NOT NULL,
    mon boolean NOT NULL,
    tue boolean NOT NULL,
    wed boolean NOT NULL,
    thu boolean NOT NULL,
    fri boolean NOT NULL,
    sat boolean NOT NULL,
    sun boolean NOT NULL
);


ALTER TABLE "THSR".train OWNER TO postgres;

--
-- TOC entry 3179 (class 2604 OID 17019)
-- Name: discount discount_id; Type: DEFAULT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".discount ALTER COLUMN discount_id SET DEFAULT nextval('"THSR".discount_discount_id_seq'::regclass);


--
-- TOC entry 3180 (class 2604 OID 17020)
-- Name: fare fare_id; Type: DEFAULT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".fare ALTER COLUMN fare_id SET DEFAULT nextval('"THSR".fare_fare_id_seq'::regclass);


--
-- TOC entry 3181 (class 2604 OID 17021)
-- Name: schedule schedule_id; Type: DEFAULT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".schedule ALTER COLUMN schedule_id SET DEFAULT nextval('"THSR".schedule_schedule_id_seq'::regclass);


--
-- TOC entry 3328 (class 0 OID 16983)
-- Dependencies: 201
-- Data for Name: discount; Type: TABLE DATA; Schema: THSR; Owner: postgres
--

COPY "THSR".discount (discount_id, type, discount_rate) FROM stdin;
\.


--
-- TOC entry 3330 (class 0 OID 16991)
-- Dependencies: 203
-- Data for Name: fare; Type: TABLE DATA; Schema: THSR; Owner: postgres
--

COPY "THSR".fare (fare_id, origin_station_id, destination_station_id, business_fare, standard_fare, non_reserved_fare) FROM stdin;
\.


--
-- TOC entry 3332 (class 0 OID 16999)
-- Dependencies: 205
-- Data for Name: schedule; Type: TABLE DATA; Schema: THSR; Owner: postgres
--

COPY "THSR".schedule (schedule_id, train_id, stop_sequence, station_id, arrival_time, departure_time) FROM stdin;
\.


--
-- TOC entry 3334 (class 0 OID 17007)
-- Dependencies: 207
-- Data for Name: station; Type: TABLE DATA; Schema: THSR; Owner: postgres
--

COPY "THSR".station (station_id, station_name) FROM stdin;
\.


--
-- TOC entry 3335 (class 0 OID 17013)
-- Dependencies: 208
-- Data for Name: train; Type: TABLE DATA; Schema: THSR; Owner: postgres
--

COPY "THSR".train (train_id, starting_station_id, ending_station_id, mon, tue, wed, thu, fri, sat, sun) FROM stdin;
\.


--
-- TOC entry 3345 (class 0 OID 0)
-- Dependencies: 202
-- Name: discount_discount_id_seq; Type: SEQUENCE SET; Schema: THSR; Owner: postgres
--

SELECT pg_catalog.setval('"THSR".discount_discount_id_seq', 12, true);


--
-- TOC entry 3346 (class 0 OID 0)
-- Dependencies: 204
-- Name: fare_fare_id_seq; Type: SEQUENCE SET; Schema: THSR; Owner: postgres
--

SELECT pg_catalog.setval('"THSR".fare_fare_id_seq', 396, true);


--
-- TOC entry 3347 (class 0 OID 0)
-- Dependencies: 206
-- Name: schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: THSR; Owner: postgres
--

SELECT pg_catalog.setval('"THSR".schedule_schedule_id_seq', 3337, true);


--
-- TOC entry 3183 (class 2606 OID 17023)
-- Name: discount discount_pkey; Type: CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".discount
    ADD CONSTRAINT discount_pkey PRIMARY KEY (discount_id);


--
-- TOC entry 3185 (class 2606 OID 17025)
-- Name: fare fare_pkey; Type: CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".fare
    ADD CONSTRAINT fare_pkey PRIMARY KEY (fare_id);


--
-- TOC entry 3187 (class 2606 OID 17027)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 3189 (class 2606 OID 17029)
-- Name: station station_pkey; Type: CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".station
    ADD CONSTRAINT station_pkey PRIMARY KEY (station_id);


--
-- TOC entry 3191 (class 2606 OID 17031)
-- Name: train train_pkey; Type: CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".train
    ADD CONSTRAINT train_pkey PRIMARY KEY (train_id);


--
-- TOC entry 3192 (class 2606 OID 17032)
-- Name: fare fare_fkey1; Type: FK CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".fare
    ADD CONSTRAINT fare_fkey1 FOREIGN KEY (origin_station_id) REFERENCES "THSR".station(station_id);


--
-- TOC entry 3193 (class 2606 OID 17037)
-- Name: fare fare_fkey2; Type: FK CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".fare
    ADD CONSTRAINT fare_fkey2 FOREIGN KEY (destination_station_id) REFERENCES "THSR".station(station_id);


--
-- TOC entry 3194 (class 2606 OID 17042)
-- Name: schedule schedule_fkey1; Type: FK CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".schedule
    ADD CONSTRAINT schedule_fkey1 FOREIGN KEY (train_id) REFERENCES "THSR".train(train_id);


--
-- TOC entry 3195 (class 2606 OID 17047)
-- Name: schedule schedule_fkey2; Type: FK CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".schedule
    ADD CONSTRAINT schedule_fkey2 FOREIGN KEY (station_id) REFERENCES "THSR".station(station_id);


--
-- TOC entry 3196 (class 2606 OID 17052)
-- Name: train train_fkey1; Type: FK CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".train
    ADD CONSTRAINT train_fkey1 FOREIGN KEY (starting_station_id) REFERENCES "THSR".station(station_id);


--
-- TOC entry 3197 (class 2606 OID 17057)
-- Name: train train_fkey2; Type: FK CONSTRAINT; Schema: THSR; Owner: postgres
--

ALTER TABLE ONLY "THSR".train
    ADD CONSTRAINT train_fkey2 FOREIGN KEY (ending_station_id) REFERENCES "THSR".station(station_id);


-- Completed on 2021-10-17 00:58:40 CST

--
-- PostgreSQL database dump complete
--

