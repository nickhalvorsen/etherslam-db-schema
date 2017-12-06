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

--
-- Name: update_dateupdated_column(); Type: FUNCTION; Schema: public; Owner: etherslam
--

CREATE FUNCTION update_dateupdated_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
 NEW.dateUpdated = current_timestamp;
 return NEW;
END;
$$;


ALTER FUNCTION public.update_dateupdated_column() OWNER TO etherslam;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: token; Type: TABLE; Schema: public; Owner: etherslam
--

CREATE TABLE token (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    symbol character varying(10) NOT NULL
);


ALTER TABLE token OWNER TO etherslam;

--
-- Name: token_id_seq; Type: SEQUENCE; Schema: public; Owner: etherslam
--

CREATE SEQUENCE token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE token_id_seq OWNER TO etherslam;

--
-- Name: token_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: etherslam
--

ALTER SEQUENCE token_id_seq OWNED BY token.id;


--
-- Name: tokensupply; Type: TABLE; Schema: public; Owner: etherslam
--

CREATE TABLE tokensupply (
    id integer NOT NULL,
    tokenid integer NOT NULL,
    totalsupply numeric NOT NULL,
    dateupdated timestamp without time zone DEFAULT now() NOT NULL,
    istotalsupplystatic boolean DEFAULT false NOT NULL
);


ALTER TABLE tokensupply OWNER TO etherslam;

--
-- Name: tokensupply_id_seq; Type: SEQUENCE; Schema: public; Owner: etherslam
--

CREATE SEQUENCE tokensupply_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tokensupply_id_seq OWNER TO etherslam;

--
-- Name: tokensupply_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: etherslam
--

ALTER SEQUENCE tokensupply_id_seq OWNED BY tokensupply.id;


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
-- Name: token id; Type: DEFAULT; Schema: public; Owner: etherslam
--

ALTER TABLE ONLY token ALTER COLUMN id SET DEFAULT nextval('token_id_seq'::regclass);


--
-- Name: tokensupply id; Type: DEFAULT; Schema: public; Owner: etherslam
--

ALTER TABLE ONLY tokensupply ALTER COLUMN id SET DEFAULT nextval('tokensupply_id_seq'::regclass);


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
-- Name: tokensupply update_tokensupply_dateupdated; Type: TRIGGER; Schema: public; Owner: etherslam
--

CREATE TRIGGER update_tokensupply_dateupdated BEFORE UPDATE ON tokensupply FOR EACH ROW EXECUTE PROCEDURE update_dateupdated_column();


--
-- PostgreSQL database dump complete
--
