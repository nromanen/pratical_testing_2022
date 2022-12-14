--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

-- Started on 2023-01-06 21:32:25 EET

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 214 (class 1259 OID 24905)
-- Name: category; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category (
    id integer NOT NULL,
    title character varying,
    description character varying
);


ALTER TABLE public.category OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24910)
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.category ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 24911)
-- Name: post; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post (
    id integer NOT NULL,
    user_id integer NOT NULL,
    title character varying,
    category_id integer,
    description character varying,
    created_at timestamp with time zone DEFAULT now(),
    published_at timestamp with time zone
);


ALTER TABLE public.post OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24917)
-- Name: post_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.post ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.post_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 24918)
-- Name: post_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.post_user (
    post_id integer,
    user_id integer,
    comment character varying,
    rate integer
);


ALTER TABLE public.post_user OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24923)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying,
    username character varying,
    password character varying,
    user_info character varying,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24929)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public."user" ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3610 (class 0 OID 24905)
-- Dependencies: 214
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (id, title, description) FROM stdin;
1	Health	Includes information about the state of being free from illness or injury both physically and mentally
2	Traveling	Includes information about going from one place to another, typically over a distance of some length
3	Movies	Category includes information about new and classic films of any genre, interesting facts about cast and film making process
4	Games	Category includes information about game industry latest news and exciting releases
5	Sport	San Antonio startup wins first BioFest Invest pitch competition
6	Technology	NASA selects San Antonio firm to help build lunar landing pad with moon dust
\.


--
-- TOC entry 3612 (class 0 OID 24911)
-- Dependencies: 216
-- Data for Name: post; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post (id, user_id, title, category_id, description, created_at, published_at) FROM stdin;
\.


--
-- TOC entry 3614 (class 0 OID 24918)
-- Dependencies: 218
-- Data for Name: post_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.post_user (post_id, user_id, comment, rate) FROM stdin;
\.


--
-- TOC entry 3615 (class 0 OID 24923)
-- Dependencies: 219
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (id, email, username, password, user_info, created_at) FROM stdin;
1	kudyksofa@gmail.com	SofiaKudyk	123456qs	Nationality: ukrainian, sex:female, birth date: 24.06.2004	2023-01-06 12:39:07.218002+02
2	sofiia.kudyk@lnu.edu.ua	SonyaK	sofia24	Nationality: ukrainian, sex:female, birth date: 24.06.2004	2023-01-06 12:41:18.819544+02
3	samantha123@gmail.com	sammylee	675sQ	Journalist from L. A., freelancer	2023-01-06 21:25:38.183366+02
4	kikaas@gmail.com	nastykika	tyU098	Editor, Dnipro, UA	2023-01-06 21:25:55.429703+02
5	Jan@gmail.com	Jan	1111	Nationality: ukrainian, sex:female, birth date: 01.02.91	2023-01-06 21:29:08.652011+02
6	nlotot@gmail.com	NLotot	nata	Nationality: ukrainian, sex:female, birth date: 01.01.81	2023-01-06 21:29:24.123999+02
\.


--
-- TOC entry 3622 (class 0 OID 0)
-- Dependencies: 215
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.category_id_seq', 2, true);


--
-- TOC entry 3623 (class 0 OID 0)
-- Dependencies: 217
-- Name: post_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.post_id_seq', 1, false);


--
-- TOC entry 3624 (class 0 OID 0)
-- Dependencies: 220
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 2, true);


--
-- TOC entry 3456 (class 2606 OID 24931)
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- TOC entry 3458 (class 2606 OID 24933)
-- Name: category category_title; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_title UNIQUE (title);


--
-- TOC entry 3460 (class 2606 OID 24935)
-- Name: post post_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_pkey PRIMARY KEY (id);


--
-- TOC entry 3462 (class 2606 OID 24937)
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- TOC entry 3464 (class 2606 OID 24939)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- TOC entry 3465 (class 2606 OID 24940)
-- Name: post post_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post
    ADD CONSTRAINT post_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- TOC entry 3466 (class 2606 OID 24945)
-- Name: post_user post_user_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_user
    ADD CONSTRAINT post_user_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.post(id);


--
-- TOC entry 3467 (class 2606 OID 24950)
-- Name: post_user post_user_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.post_user
    ADD CONSTRAINT post_user_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


-- Completed on 2023-01-06 21:32:26 EET

--
-- PostgreSQL database dump complete
--

