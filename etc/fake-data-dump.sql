--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2 (Debian 16.2-1.pgdg120+2)
-- Dumped by pg_dump version 16.2

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
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: dog; Type: TABLE; Schema: public; Owner: myuser
--

CREATE TABLE public.incident (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    incident_id text NOT NULL,
    description text NOT NULL,
    category text NOT NULL,
    severity text NOT NULL,
    product text NOT NULL,
    reported_by text NOT NULL,
    created_ts timestamp with time zone NOT NULL,
    status text NOT NULL
);

CREATE TABLE public.change_request (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    change_id text NOT NULL,
    description text NOT NULL,
    product text NOT NULL,
    implementation_plan text NOT NULL,
    requestor text NOT NULL,
    completion_ts timestamp with time zone NOT NULL,
    status text NOT NULL
);

ALTER TABLE public.incident OWNER TO myuser;

ALTER TABLE public.change_request OWNER TO myuser;

--ALTER TABLE public.event_publication OWNER TO myuser;

--
-- Name: vector_store; Type: TABLE; Schema: public; Owner: myuser
--

--CREATE TABLE public.vector_store (
--    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
--    content text,
--    metadata json,
--    embedding public.vector(1536)
--);


--ALTER TABLE public.vector_store OWNER TO myuser;

--
-- Data for Name: incident; Type: TABLE DATA; Schema: public; Owner: myuser. ChatGPT fake generated.
--
INSERT INTO public.incident (incident_id, description, category, severity, product, reported_by, created_ts, status) VALUES
('INC-2024-001', 'System outage affecting multiple users. Immediate attention required.', 'Outage', 'Critical', 'WebApp', 'John Doe', '2024-09-01 10:00:00+00', 'Open'),
('INC-2024-002', 'Data discrepancy in monthly report generation.', 'Data Issue', 'High', 'Reports', 'Jane Smith', '2024-09-02 11:30:00+00', 'In Progress'),
('INC-2024-003', 'Performance degradation observed in the search functionality.', 'Performance', 'Medium', 'SearchEngine', 'Alice Johnson', '2024-09-03 14:00:00+00', 'Resolved'),
('INC-2024-004', 'Security vulnerability detected in authentication module.', 'Security', 'Critical', 'AuthModule', 'Bob Brown', '2024-09-04 09:15:00+00', 'Closed'),
('INC-2024-005', 'Error in user registration process after recent update.', 'Bug', 'Low', 'UserService', 'Emily Davis', '2024-09-05 16:45:00+00', 'Open');

-- Insert additional incidents for 2023
INSERT INTO public.incident (incident_id, description, category, severity, product, reported_by, created_ts, status) VALUES
('INC-2023-001', 'Unexpected downtime of the payment gateway during peak hours.', 'Outage', 'Critical', 'PaymentGateway', 'Alice Johnson', '2023-12-01 08:30:00+00', 'Resolved'),
('INC-2023-002', 'Bug causing incorrect data in financial reports.', 'Data Issue', 'High', 'Finance', 'John Doe', '2023-11-15 10:00:00+00', 'Closed'),
('INC-2023-003', 'User interface issues in the mobile app after latest update.', 'UI Bug', 'Medium', 'MobileApp', 'Jane Smith', '2023-10-20 14:45:00+00', 'In Progress'),
('INC-2023-004', 'Security breach detected in the API service.', 'Security', 'Critical', 'API', 'Michael Brown', '2023-09-25 16:30:00+00', 'Open'),
('INC-2023-005', 'Performance issues with the new feature rollout.', 'Performance', 'Low', 'FeatureX', 'Emily Davis', '2023-08-30 11:15:00+00', 'Resolved');

-- Insert additional incidents for 2022
INSERT INTO public.incident (incident_id, description, category, severity, product, reported_by, created_ts, status) VALUES
('INC-2022-001', 'System crash due to high load during marketing campaign.', 'Outage', 'Critical', 'MarketingSystem', 'Sarah Lee', '2022-12-01 07:00:00+00', 'Closed'),
('INC-2022-002', 'Error in data synchronization between databases.', 'Data Issue', 'High', 'SyncService', 'Bob Brown', '2022-11-10 09:30:00+00', 'Resolved'),
('INC-2022-003', 'Minor bug causing layout issues on the homepage.', 'UI Bug', 'Low', 'WebApp', 'Laura Johnson', '2022-10-15 13:00:00+00', 'Closed'),
('INC-2022-004', 'Possible vulnerability in user authentication system.', 'Security', 'High', 'AuthService', 'Michael Brown', '2022-09-20 15:00:00+00', 'In Progress'),
('INC-2022-005', 'Decreased performance observed in database queries.', 'Performance', 'Medium', 'Database', 'John Doe', '2022-08-25 17:00:00+00', 'Resolved');



INSERT INTO public.change_request (change_id, description, product, implementation_plan, requestor, completion_ts, status) VALUES
('CR-2024-001', 'Upgrade database schema to improve performance.', 'Database', 'Apply schema changes during scheduled maintenance window. Verify performance improvements post-deployment.', 'Michael Brown', '2024-09-10 12:00:00+00', 'Completed'),
('CR-2024-002', 'Implement new user interface for the main dashboard.', 'WebApp', 'Develop UI changes in staging environment. Conduct user acceptance testing before deployment.', 'Sarah Lee', '2024-09-12 15:30:00+00', 'In Progress'),
('CR-2024-003', 'Deploy new API endpoints for enhanced functionality.', 'API', 'Deploy in phased manner. Monitor for issues and gather user feedback.', 'David Wilson', '2024-09-15 09:00:00+00', 'Pending'),
('CR-2024-004', 'Refactor authentication module to improve security.', 'AuthModule', 'Refactor code, test in sandbox, and roll out changes during off-peak hours.', 'Laura Johnson', '2024-09-18 14:30:00+00', 'Completed'),
('CR-2024-005', 'Add new reporting features to the analytics tool.', 'Reports', 'Develop features, perform integration tests, and deploy during next release cycle.', 'John Doe', '2024-09-20 11:00:00+00', 'Pending');

-- Insert additional change requests for 2023
INSERT INTO public.change_request (change_id, description, product, implementation_plan, requestor, completion_ts, status) VALUES
('CR-2023-001', 'Upgrade server infrastructure to handle increased traffic.', 'Server', 'Plan and execute hardware upgrades during off-peak hours. Test for stability.', 'Emily Davis', '2023-12-10 14:00:00+00', 'Completed'),
('CR-2023-002', 'Redesign login page for improved user experience.', 'WebApp', 'Design and implement new UI elements. Conduct A/B testing before rollout.', 'Sarah Lee', '2023-11-05 16:30:00+00', 'In Progress'),
('CR-2023-003', 'Enhance logging and monitoring for better issue tracking.', 'Monitoring', 'Implement enhanced logging features and set up monitoring dashboards.', 'Alice Johnson', '2023-10-15 11:00:00+00', 'Pending'),
('CR-2023-004', 'Integrate new payment gateway for online transactions.', 'PaymentGateway', 'Integrate and test new payment gateway. Update documentation and user guides.', 'John Doe', '2023-09-20 09:00:00+00', 'Completed'),
('CR-2023-005', 'Refactor legacy codebase to improve maintainability.', 'Codebase', 'Refactor and document legacy code. Conduct code reviews and unit testing.', 'Michael Brown', '2023-08-25 13:30:00+00', 'In Progress');

-- Insert additional change requests for 2022
INSERT INTO public.change_request (change_id, description, product, implementation_plan, requestor, completion_ts, status) VALUES
('CR-2022-001', 'Migrate database to a new cloud provider.', 'Database', 'Plan migration steps, execute during low traffic, and validate post-migration.', 'Laura Johnson', '2022-12-05 10:00:00+00', 'Completed'),
('CR-2022-002', 'Deploy new security patches for existing software.', 'Security', 'Apply patches during maintenance window. Ensure system stability and security.', 'Jane Smith', '2022-11-10 12:30:00+00', 'Completed'),
('CR-2022-003', 'Add support for additional payment methods.', 'PaymentSystem', 'Implement and test new payment methods. Update user documentation.', 'Emily Davis', '2022-10-15 08:45:00+00', 'In Progress'),
('CR-2022-004', 'Optimize search algorithms for improved performance.', 'SearchEngine', 'Refactor search algorithms and test performance improvements.', 'Bob Brown', '2022-09-20 14:00:00+00', 'Pending'),
('CR-2022-005', 'Implement new features for customer feedback module.', 'FeedbackModule', 'Design and deploy new features. Conduct user acceptance testing.', 'Michael Brown', '2022-08-25 11:00:00+00', 'Completed');

--COPY public.incident (incident_id, description, created_ts) FROM stdin;
--INC1	Outage on X service.	2020-01-07	\N
--\.


--
-- Name: incident incident_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

ALTER TABLE ONLY public.incident
    ADD CONSTRAINT incident_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.change_request
    ADD CONSTRAINT change_request_pkey PRIMARY KEY (id);


--
-- Name: vector_store vector_store_pkey; Type: CONSTRAINT; Schema: public; Owner: myuser
--

--ALTER TABLE ONLY public.vector_store
--    ADD CONSTRAINT vector_store_pkey PRIMARY KEY (id);


--
-- Name: event_publication_by_completion_date_idx; Type: INDEX; Schema: public; Owner: myuser
--

CREATE INDEX incident_by_created_ts_idx ON public.incident USING btree (created_ts);

CREATE INDEX change_request_by_completion_ts_idx ON public.change_request USING btree (completion_ts);


--
-- Name: spring_ai_vector_index; Type: INDEX; Schema: public; Owner: myuser
--

--CREATE INDEX spring_ai_vector_index ON public.vector_store USING hnsw (embedding public.vector_cosine_ops);


--
-- PostgreSQL database dump complete
--