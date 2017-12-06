--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.6
-- Dumped by pg_dump version 9.6.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
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


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: transaction; Type: TABLE; Schema: public; Owner: etherslam
--

CREATE TABLE transaction (
    id integer NOT NULL,
    hash character varying(66) NOT NULL,
    block integer NOT NULL,
    utctime timestamp without time zone NOT NULL,
    fromaddress character varying(42) NOT NULL,
    toaddress character varying(42) NOT NULL,
    value numeric NOT NULL,
    fee numeric NOT NULL
);


ALTER TABLE transaction OWNER TO etherslam;

--
-- Name: transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: etherslam
--

CREATE SEQUENCE transaction_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE transaction_id_seq OWNER TO etherslam;

--
-- Name: transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: etherslam
--

ALTER SEQUENCE transaction_id_seq OWNED BY transaction.id;


--
-- Name: transaction id; Type: DEFAULT; Schema: public; Owner: etherslam
--

ALTER TABLE ONLY transaction ALTER COLUMN id SET DEFAULT nextval('transaction_id_seq'::regclass);


--
-- Name: transaction transaction_hash_key; Type: CONSTRAINT; Schema: public; Owner: etherslam
--

ALTER TABLE ONLY transaction
    ADD CONSTRAINT transaction_hash_key UNIQUE (hash);


--
-- PostgreSQL database dump complete
--

