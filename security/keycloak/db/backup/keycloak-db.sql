--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

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
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO postgres;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- Name: org; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO postgres;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO postgres;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO postgres;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
cfb3c9bf-ad9f-41b5-b371-1619970b4ff1	651e2728-1029-499b-bdd1-b8d455ddf86e
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
c0b7b543-beeb-4f5e-863b-bbc39491fd18	\N	auth-cookie	9810599f-a32f-4d69-893a-d08f7209a282	4ad25181-d2a5-4979-b7b2-a60b4790eb17	2	10	f	\N	\N
6bb0b9fb-2875-4507-9a1c-083544c0edae	\N	auth-spnego	9810599f-a32f-4d69-893a-d08f7209a282	4ad25181-d2a5-4979-b7b2-a60b4790eb17	3	20	f	\N	\N
78f4189d-6631-4072-8bb8-517f3e19dfb4	\N	identity-provider-redirector	9810599f-a32f-4d69-893a-d08f7209a282	4ad25181-d2a5-4979-b7b2-a60b4790eb17	2	25	f	\N	\N
34e93a4c-017a-46ed-80f9-83711cb6e1ee	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	4ad25181-d2a5-4979-b7b2-a60b4790eb17	2	30	t	ed2264a2-63f8-44a2-a3e6-19fc431e679a	\N
558fbcce-3587-4134-98d7-a88df0e1a589	\N	auth-username-password-form	9810599f-a32f-4d69-893a-d08f7209a282	ed2264a2-63f8-44a2-a3e6-19fc431e679a	0	10	f	\N	\N
7409fec3-fd8c-464f-b227-6dcc51943796	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	ed2264a2-63f8-44a2-a3e6-19fc431e679a	1	20	t	a76e53b4-8b11-4f5c-b03e-dfd14b5117ee	\N
a623e1e6-d5bf-48aa-b89f-865efdcfaf67	\N	conditional-user-configured	9810599f-a32f-4d69-893a-d08f7209a282	a76e53b4-8b11-4f5c-b03e-dfd14b5117ee	0	10	f	\N	\N
59755dd1-fe74-46ea-84d0-e448d7604e06	\N	auth-otp-form	9810599f-a32f-4d69-893a-d08f7209a282	a76e53b4-8b11-4f5c-b03e-dfd14b5117ee	0	20	f	\N	\N
dcfaa3c1-cad2-4166-9e9e-3c261507f1ac	\N	direct-grant-validate-username	9810599f-a32f-4d69-893a-d08f7209a282	b64a8500-a3d8-48be-8fc3-7a70ef74790a	0	10	f	\N	\N
9fafa6c9-c064-47bd-b2a4-fc86b7fac2f9	\N	direct-grant-validate-password	9810599f-a32f-4d69-893a-d08f7209a282	b64a8500-a3d8-48be-8fc3-7a70ef74790a	0	20	f	\N	\N
7068917a-c7ca-4de1-b232-56831179bc0e	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	b64a8500-a3d8-48be-8fc3-7a70ef74790a	1	30	t	91098938-0716-45c0-bcfd-aceade57ac28	\N
f5c67386-3178-4077-8f67-d428bef760ba	\N	conditional-user-configured	9810599f-a32f-4d69-893a-d08f7209a282	91098938-0716-45c0-bcfd-aceade57ac28	0	10	f	\N	\N
b4d13d63-f945-458b-a17b-e401dea18c1f	\N	direct-grant-validate-otp	9810599f-a32f-4d69-893a-d08f7209a282	91098938-0716-45c0-bcfd-aceade57ac28	0	20	f	\N	\N
1f4a2cc5-dade-4b69-988e-fee7ed712afe	\N	registration-page-form	9810599f-a32f-4d69-893a-d08f7209a282	0d44f40b-036c-4368-954a-6881374181e3	0	10	t	8eec654e-a3cb-45e8-aeee-3a4e2944023e	\N
8b1602dc-e3a9-473c-adcf-3d919e38a150	\N	registration-user-creation	9810599f-a32f-4d69-893a-d08f7209a282	8eec654e-a3cb-45e8-aeee-3a4e2944023e	0	20	f	\N	\N
b41391a7-c5a0-43a4-822f-82690f430976	\N	registration-password-action	9810599f-a32f-4d69-893a-d08f7209a282	8eec654e-a3cb-45e8-aeee-3a4e2944023e	0	50	f	\N	\N
de6a85e2-e0b2-4e2d-869b-211fc08c4068	\N	registration-recaptcha-action	9810599f-a32f-4d69-893a-d08f7209a282	8eec654e-a3cb-45e8-aeee-3a4e2944023e	3	60	f	\N	\N
51d23309-b495-496d-871f-ef69ee563fdd	\N	registration-terms-and-conditions	9810599f-a32f-4d69-893a-d08f7209a282	8eec654e-a3cb-45e8-aeee-3a4e2944023e	3	70	f	\N	\N
981f4a97-521d-4c99-acdb-303ec7fdd14c	\N	reset-credentials-choose-user	9810599f-a32f-4d69-893a-d08f7209a282	90308637-d161-4ecb-8fe3-f8a72c6568f2	0	10	f	\N	\N
f42ae633-6e12-46c4-a6a8-395f3c8ca820	\N	reset-credential-email	9810599f-a32f-4d69-893a-d08f7209a282	90308637-d161-4ecb-8fe3-f8a72c6568f2	0	20	f	\N	\N
3a951aee-03b3-41ac-982e-5e1f1a2a326a	\N	reset-password	9810599f-a32f-4d69-893a-d08f7209a282	90308637-d161-4ecb-8fe3-f8a72c6568f2	0	30	f	\N	\N
ce6a7352-e010-41d4-985e-6e53af41002c	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	90308637-d161-4ecb-8fe3-f8a72c6568f2	1	40	t	c789dd7a-19b2-4d17-a28c-3cac2e4eae5b	\N
71fae493-9bd3-492d-a1ae-892899be6b75	\N	conditional-user-configured	9810599f-a32f-4d69-893a-d08f7209a282	c789dd7a-19b2-4d17-a28c-3cac2e4eae5b	0	10	f	\N	\N
8b9707bc-c02e-4376-870c-2c7dfdaf3356	\N	reset-otp	9810599f-a32f-4d69-893a-d08f7209a282	c789dd7a-19b2-4d17-a28c-3cac2e4eae5b	0	20	f	\N	\N
8e88d318-2bd3-4910-b02c-7e052d3f63f5	\N	client-secret	9810599f-a32f-4d69-893a-d08f7209a282	d4da58e8-894f-46fe-bff6-be2a5113a26b	2	10	f	\N	\N
219f6725-2bd1-4f61-a0bc-09d0bf96eaf5	\N	client-jwt	9810599f-a32f-4d69-893a-d08f7209a282	d4da58e8-894f-46fe-bff6-be2a5113a26b	2	20	f	\N	\N
84e951e4-971b-4daa-b575-58ea7e91ac3a	\N	client-secret-jwt	9810599f-a32f-4d69-893a-d08f7209a282	d4da58e8-894f-46fe-bff6-be2a5113a26b	2	30	f	\N	\N
dd8ea6fe-270b-40dd-b671-bbd43fef4290	\N	client-x509	9810599f-a32f-4d69-893a-d08f7209a282	d4da58e8-894f-46fe-bff6-be2a5113a26b	2	40	f	\N	\N
8fdbea7a-6ff2-4f60-a7a7-3c784d23d5df	\N	idp-review-profile	9810599f-a32f-4d69-893a-d08f7209a282	5c4623b3-25bc-4d04-83af-660bb9566e06	0	10	f	\N	879c95ae-a860-447e-8309-1ca9b7d36b24
45fb6d0b-4c65-4c9d-ad58-93e85a126ab6	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	5c4623b3-25bc-4d04-83af-660bb9566e06	0	20	t	5741bab0-8adf-4606-8a53-bd187fc39d09	\N
d1f30e76-0dd4-46d6-8fd2-d7e2e60cc079	\N	idp-create-user-if-unique	9810599f-a32f-4d69-893a-d08f7209a282	5741bab0-8adf-4606-8a53-bd187fc39d09	2	10	f	\N	60387db2-056a-4244-9575-60a55a61b195
0975ed61-03cf-4c3c-bfbf-2e4931b07dfb	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	5741bab0-8adf-4606-8a53-bd187fc39d09	2	20	t	e65cf846-1924-4092-9cbf-48b433d38a90	\N
fcc1427f-ff56-4ecf-8707-4ebe840e1e49	\N	idp-confirm-link	9810599f-a32f-4d69-893a-d08f7209a282	e65cf846-1924-4092-9cbf-48b433d38a90	0	10	f	\N	\N
3b4f0e90-4fee-4e2e-93fd-5e79ed5a0bd0	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	e65cf846-1924-4092-9cbf-48b433d38a90	0	20	t	90292e9a-01ef-4b55-a260-b11a9fb2e0d5	\N
2f1da5a3-d110-440c-b3f4-a2035c6fb140	\N	idp-email-verification	9810599f-a32f-4d69-893a-d08f7209a282	90292e9a-01ef-4b55-a260-b11a9fb2e0d5	2	10	f	\N	\N
d1ee4795-e356-4dd1-ae45-eb20efbdde13	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	90292e9a-01ef-4b55-a260-b11a9fb2e0d5	2	20	t	002dc004-2c89-4dba-8bb5-85586b3a2170	\N
fea2537d-4cdb-4a63-9a09-574e10a2bd84	\N	idp-username-password-form	9810599f-a32f-4d69-893a-d08f7209a282	002dc004-2c89-4dba-8bb5-85586b3a2170	0	10	f	\N	\N
a7e53762-425b-4710-8d05-2c872730bd3a	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	002dc004-2c89-4dba-8bb5-85586b3a2170	1	20	t	1ed8ff86-606f-428d-b2f1-02d9f0a285d5	\N
bb40ba0d-3df2-4cf7-ad3e-1013d004b955	\N	conditional-user-configured	9810599f-a32f-4d69-893a-d08f7209a282	1ed8ff86-606f-428d-b2f1-02d9f0a285d5	0	10	f	\N	\N
b1637e37-35fe-408c-bb8b-9a671703a8c6	\N	auth-otp-form	9810599f-a32f-4d69-893a-d08f7209a282	1ed8ff86-606f-428d-b2f1-02d9f0a285d5	0	20	f	\N	\N
7169541b-1cc5-48fa-8818-61f031f912b1	\N	http-basic-authenticator	9810599f-a32f-4d69-893a-d08f7209a282	e90a355f-d77c-461b-a1b2-8fa744e30c99	0	10	f	\N	\N
ec781410-9f0f-4063-b66a-7f69ff69e5c9	\N	docker-http-basic-authenticator	9810599f-a32f-4d69-893a-d08f7209a282	b04b5094-9e27-418d-93fa-49af30201a5c	0	10	f	\N	\N
dd9a59e0-853f-4b2a-9054-08b40fbcfb81	\N	auth-cookie	c46dc488-1d5b-449e-886b-6024480d4e83	7cafe6d9-4426-404a-854f-212d8928855b	2	10	f	\N	\N
dcde220e-6f15-416e-800a-ffe96e554160	\N	auth-spnego	c46dc488-1d5b-449e-886b-6024480d4e83	7cafe6d9-4426-404a-854f-212d8928855b	3	20	f	\N	\N
92153da4-5698-4fc6-b858-f577c46778f9	\N	identity-provider-redirector	c46dc488-1d5b-449e-886b-6024480d4e83	7cafe6d9-4426-404a-854f-212d8928855b	2	25	f	\N	\N
cc106c1e-8be4-42ca-b005-967ab259c2d2	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	7cafe6d9-4426-404a-854f-212d8928855b	2	30	t	3cd7ef40-f72a-461a-ac93-8ca0a120b74a	\N
2690a10c-5c43-49e0-80c5-9cd59e461160	\N	auth-username-password-form	c46dc488-1d5b-449e-886b-6024480d4e83	3cd7ef40-f72a-461a-ac93-8ca0a120b74a	0	10	f	\N	\N
8111e357-ae52-4bc4-b277-72f43b250de8	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	3cd7ef40-f72a-461a-ac93-8ca0a120b74a	1	20	t	a6d5e1ad-7ff6-43c0-b9ed-4c524676aa42	\N
15c91242-7d20-477d-99de-64467fdddeca	\N	conditional-user-configured	c46dc488-1d5b-449e-886b-6024480d4e83	a6d5e1ad-7ff6-43c0-b9ed-4c524676aa42	0	10	f	\N	\N
cd998a3f-f481-4dac-9310-1a5fcb317dd9	\N	auth-otp-form	c46dc488-1d5b-449e-886b-6024480d4e83	a6d5e1ad-7ff6-43c0-b9ed-4c524676aa42	0	20	f	\N	\N
d557b3ad-ed02-40a3-a833-c039fe4a3547	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	7cafe6d9-4426-404a-854f-212d8928855b	2	26	t	ba4f0709-b183-420d-984e-617c2d569d18	\N
ee65c730-958f-40f9-8348-d247fc185283	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	ba4f0709-b183-420d-984e-617c2d569d18	1	10	t	f3ed592f-5777-47c5-993a-449a4468309e	\N
2de9942f-e42f-4790-8dcc-be64552fa7a1	\N	conditional-user-configured	c46dc488-1d5b-449e-886b-6024480d4e83	f3ed592f-5777-47c5-993a-449a4468309e	0	10	f	\N	\N
5010e9d1-d21d-4193-881b-56e0d36e0206	\N	organization	c46dc488-1d5b-449e-886b-6024480d4e83	f3ed592f-5777-47c5-993a-449a4468309e	2	20	f	\N	\N
f9f546d0-c0f9-4142-ad79-ab86e11455ff	\N	direct-grant-validate-username	c46dc488-1d5b-449e-886b-6024480d4e83	faf98d32-9a03-42d4-b85f-2e9e73836316	0	10	f	\N	\N
e0ff20b1-2f70-45fc-9f8d-34c2ed757fcf	\N	direct-grant-validate-password	c46dc488-1d5b-449e-886b-6024480d4e83	faf98d32-9a03-42d4-b85f-2e9e73836316	0	20	f	\N	\N
5b0de08b-a555-4e1e-a338-2cd8567e2fac	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	faf98d32-9a03-42d4-b85f-2e9e73836316	1	30	t	81099cca-6d5c-4968-b192-d033c008d454	\N
364f7539-0445-4580-b992-4c49263648da	\N	conditional-user-configured	c46dc488-1d5b-449e-886b-6024480d4e83	81099cca-6d5c-4968-b192-d033c008d454	0	10	f	\N	\N
d1ba6c12-5848-43e4-807f-455b66e3e3ae	\N	direct-grant-validate-otp	c46dc488-1d5b-449e-886b-6024480d4e83	81099cca-6d5c-4968-b192-d033c008d454	0	20	f	\N	\N
b2a6855b-cd95-4773-a2df-100dcf51b0a6	\N	registration-page-form	c46dc488-1d5b-449e-886b-6024480d4e83	fae5a460-39c0-4db4-b696-42041df68e23	0	10	t	8e352459-df16-4d33-8a1c-eec25d3aa663	\N
ebff9f11-9b3f-42b2-bd48-c852822a191f	\N	registration-user-creation	c46dc488-1d5b-449e-886b-6024480d4e83	8e352459-df16-4d33-8a1c-eec25d3aa663	0	20	f	\N	\N
61121954-2b10-424b-945b-e6ec62b216af	\N	registration-password-action	c46dc488-1d5b-449e-886b-6024480d4e83	8e352459-df16-4d33-8a1c-eec25d3aa663	0	50	f	\N	\N
bb12416e-2373-4bb6-9801-71b0445ce6e0	\N	registration-recaptcha-action	c46dc488-1d5b-449e-886b-6024480d4e83	8e352459-df16-4d33-8a1c-eec25d3aa663	3	60	f	\N	\N
6498588c-82c2-44b8-9cb7-974ac959c9e5	\N	registration-terms-and-conditions	c46dc488-1d5b-449e-886b-6024480d4e83	8e352459-df16-4d33-8a1c-eec25d3aa663	3	70	f	\N	\N
733c91fc-e3ed-4b64-bc99-65a0a9c341cb	\N	reset-credentials-choose-user	c46dc488-1d5b-449e-886b-6024480d4e83	42aa3994-fee4-4614-818d-5a262a4cf323	0	10	f	\N	\N
357077de-7304-473b-9064-36f76caf2758	\N	reset-credential-email	c46dc488-1d5b-449e-886b-6024480d4e83	42aa3994-fee4-4614-818d-5a262a4cf323	0	20	f	\N	\N
1a454462-2593-4a66-a2ca-77de3678c85f	\N	reset-password	c46dc488-1d5b-449e-886b-6024480d4e83	42aa3994-fee4-4614-818d-5a262a4cf323	0	30	f	\N	\N
6d25b618-83c1-4d80-b84d-c9a42e7b416d	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	42aa3994-fee4-4614-818d-5a262a4cf323	1	40	t	a83d61f9-b871-489c-97c2-3b2c6d9b9a47	\N
3a0c092d-14d3-482e-ae75-8416ae197bd9	\N	conditional-user-configured	c46dc488-1d5b-449e-886b-6024480d4e83	a83d61f9-b871-489c-97c2-3b2c6d9b9a47	0	10	f	\N	\N
1f66b3c3-f521-4c07-9d6e-bd9da81616aa	\N	reset-otp	c46dc488-1d5b-449e-886b-6024480d4e83	a83d61f9-b871-489c-97c2-3b2c6d9b9a47	0	20	f	\N	\N
61489b2b-0fde-45c4-92bb-0d76cc97a95e	\N	client-secret	c46dc488-1d5b-449e-886b-6024480d4e83	ee4a8493-bc20-4b12-b475-eefa2498904d	2	10	f	\N	\N
e8a37f4e-25d7-48fc-b5c9-b338b5fc8d5a	\N	client-jwt	c46dc488-1d5b-449e-886b-6024480d4e83	ee4a8493-bc20-4b12-b475-eefa2498904d	2	20	f	\N	\N
0ea609ac-767e-444d-9440-4c80ae3ab22a	\N	client-secret-jwt	c46dc488-1d5b-449e-886b-6024480d4e83	ee4a8493-bc20-4b12-b475-eefa2498904d	2	30	f	\N	\N
08ea1f0a-499a-4a97-bb21-bbd070daafda	\N	client-x509	c46dc488-1d5b-449e-886b-6024480d4e83	ee4a8493-bc20-4b12-b475-eefa2498904d	2	40	f	\N	\N
edd5b638-cc54-4873-96a7-af5a61004532	\N	idp-review-profile	c46dc488-1d5b-449e-886b-6024480d4e83	7ad11612-484f-4eac-8fdd-d8421e97bac9	0	10	f	\N	a3e00ac4-eaa6-4cec-92b6-8c8cc26181e4
cdaf8779-f1a0-4b96-adcb-5009ec3de04d	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	7ad11612-484f-4eac-8fdd-d8421e97bac9	0	20	t	d0e49fd0-9454-422a-9175-342123817d78	\N
2b80d4d8-b42a-4edf-8f9a-fd38b7c3225f	\N	idp-create-user-if-unique	c46dc488-1d5b-449e-886b-6024480d4e83	d0e49fd0-9454-422a-9175-342123817d78	2	10	f	\N	e2f1b654-88bf-47eb-9661-85d986e7f2a0
1cc4c014-e73e-4ea0-9956-ffe19107862b	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	d0e49fd0-9454-422a-9175-342123817d78	2	20	t	74d700f7-bb0e-4ef3-a09d-c3e64d769a5b	\N
ae6d0b9d-bc20-4bb3-ad5c-28cf41d073b6	\N	idp-confirm-link	c46dc488-1d5b-449e-886b-6024480d4e83	74d700f7-bb0e-4ef3-a09d-c3e64d769a5b	0	10	f	\N	\N
f141de0b-2ab7-497c-bf46-c0e99835000e	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	74d700f7-bb0e-4ef3-a09d-c3e64d769a5b	0	20	t	031e83bd-1f8d-4c81-b1d3-cb8ce444f984	\N
403a9633-aedc-41e9-9076-0ae52782d836	\N	idp-email-verification	c46dc488-1d5b-449e-886b-6024480d4e83	031e83bd-1f8d-4c81-b1d3-cb8ce444f984	2	10	f	\N	\N
6940f8d5-a856-4cb6-9a91-cfe7211cf377	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	031e83bd-1f8d-4c81-b1d3-cb8ce444f984	2	20	t	510d1b1a-9064-44ef-b28e-f536b7be4d80	\N
075dbe0e-c9c0-4367-ad45-a5a974ec59f1	\N	idp-username-password-form	c46dc488-1d5b-449e-886b-6024480d4e83	510d1b1a-9064-44ef-b28e-f536b7be4d80	0	10	f	\N	\N
621a3bf7-39d9-4a74-b957-ed6558683acb	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	510d1b1a-9064-44ef-b28e-f536b7be4d80	1	20	t	9e15b360-83f2-4415-90f4-3d4b0a59ef3f	\N
22ec0413-bca4-40c3-8cd6-08128cfd9d76	\N	conditional-user-configured	c46dc488-1d5b-449e-886b-6024480d4e83	9e15b360-83f2-4415-90f4-3d4b0a59ef3f	0	10	f	\N	\N
572b69be-cccb-44ae-a59f-7f48b1d820cc	\N	auth-otp-form	c46dc488-1d5b-449e-886b-6024480d4e83	9e15b360-83f2-4415-90f4-3d4b0a59ef3f	0	20	f	\N	\N
0000a550-4c6c-4efb-a5db-abcd1ae9a779	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	7ad11612-484f-4eac-8fdd-d8421e97bac9	1	50	t	cfd21b69-5cd4-4495-9a39-e31c8d321bd4	\N
44e47285-11e1-46bf-b156-0a5aa53412e2	\N	conditional-user-configured	c46dc488-1d5b-449e-886b-6024480d4e83	cfd21b69-5cd4-4495-9a39-e31c8d321bd4	0	10	f	\N	\N
12d5a4c3-9291-4e11-8582-8dd7dfa92529	\N	idp-add-organization-member	c46dc488-1d5b-449e-886b-6024480d4e83	cfd21b69-5cd4-4495-9a39-e31c8d321bd4	0	20	f	\N	\N
1a70603a-6294-433e-ac4d-5fb4c120a484	\N	http-basic-authenticator	c46dc488-1d5b-449e-886b-6024480d4e83	2e94db89-6a97-4010-a5f2-1116f13e63cb	0	10	f	\N	\N
37b64416-ddd3-45c5-a49c-c12404867978	\N	docker-http-basic-authenticator	c46dc488-1d5b-449e-886b-6024480d4e83	8d9c781c-e648-4939-9a2d-5886358d5405	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
4ad25181-d2a5-4979-b7b2-a60b4790eb17	browser	Browser based authentication	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	t	t
ed2264a2-63f8-44a2-a3e6-19fc431e679a	forms	Username, password, otp and other auth forms.	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	f	t
a76e53b4-8b11-4f5c-b03e-dfd14b5117ee	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	f	t
b64a8500-a3d8-48be-8fc3-7a70ef74790a	direct grant	OpenID Connect Resource Owner Grant	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	t	t
91098938-0716-45c0-bcfd-aceade57ac28	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	f	t
0d44f40b-036c-4368-954a-6881374181e3	registration	Registration flow	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	t	t
8eec654e-a3cb-45e8-aeee-3a4e2944023e	registration form	Registration form	9810599f-a32f-4d69-893a-d08f7209a282	form-flow	f	t
90308637-d161-4ecb-8fe3-f8a72c6568f2	reset credentials	Reset credentials for a user if they forgot their password or something	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	t	t
c789dd7a-19b2-4d17-a28c-3cac2e4eae5b	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	f	t
d4da58e8-894f-46fe-bff6-be2a5113a26b	clients	Base authentication for clients	9810599f-a32f-4d69-893a-d08f7209a282	client-flow	t	t
5c4623b3-25bc-4d04-83af-660bb9566e06	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	t	t
5741bab0-8adf-4606-8a53-bd187fc39d09	User creation or linking	Flow for the existing/non-existing user alternatives	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	f	t
e65cf846-1924-4092-9cbf-48b433d38a90	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	f	t
90292e9a-01ef-4b55-a260-b11a9fb2e0d5	Account verification options	Method with which to verity the existing account	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	f	t
002dc004-2c89-4dba-8bb5-85586b3a2170	Verify Existing Account by Re-authentication	Reauthentication of existing account	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	f	t
1ed8ff86-606f-428d-b2f1-02d9f0a285d5	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	f	t
e90a355f-d77c-461b-a1b2-8fa744e30c99	saml ecp	SAML ECP Profile Authentication Flow	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	t	t
b04b5094-9e27-418d-93fa-49af30201a5c	docker auth	Used by Docker clients to authenticate against the IDP	9810599f-a32f-4d69-893a-d08f7209a282	basic-flow	t	t
7cafe6d9-4426-404a-854f-212d8928855b	browser	Browser based authentication	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	t	t
3cd7ef40-f72a-461a-ac93-8ca0a120b74a	forms	Username, password, otp and other auth forms.	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
a6d5e1ad-7ff6-43c0-b9ed-4c524676aa42	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
ba4f0709-b183-420d-984e-617c2d569d18	Organization	\N	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
f3ed592f-5777-47c5-993a-449a4468309e	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
faf98d32-9a03-42d4-b85f-2e9e73836316	direct grant	OpenID Connect Resource Owner Grant	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	t	t
81099cca-6d5c-4968-b192-d033c008d454	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
fae5a460-39c0-4db4-b696-42041df68e23	registration	Registration flow	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	t	t
8e352459-df16-4d33-8a1c-eec25d3aa663	registration form	Registration form	c46dc488-1d5b-449e-886b-6024480d4e83	form-flow	f	t
42aa3994-fee4-4614-818d-5a262a4cf323	reset credentials	Reset credentials for a user if they forgot their password or something	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	t	t
a83d61f9-b871-489c-97c2-3b2c6d9b9a47	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
ee4a8493-bc20-4b12-b475-eefa2498904d	clients	Base authentication for clients	c46dc488-1d5b-449e-886b-6024480d4e83	client-flow	t	t
7ad11612-484f-4eac-8fdd-d8421e97bac9	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	t	t
d0e49fd0-9454-422a-9175-342123817d78	User creation or linking	Flow for the existing/non-existing user alternatives	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
74d700f7-bb0e-4ef3-a09d-c3e64d769a5b	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
031e83bd-1f8d-4c81-b1d3-cb8ce444f984	Account verification options	Method with which to verity the existing account	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
510d1b1a-9064-44ef-b28e-f536b7be4d80	Verify Existing Account by Re-authentication	Reauthentication of existing account	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
9e15b360-83f2-4415-90f4-3d4b0a59ef3f	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
cfd21b69-5cd4-4495-9a39-e31c8d321bd4	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	f	t
2e94db89-6a97-4010-a5f2-1116f13e63cb	saml ecp	SAML ECP Profile Authentication Flow	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	t	t
8d9c781c-e648-4939-9a2d-5886358d5405	docker auth	Used by Docker clients to authenticate against the IDP	c46dc488-1d5b-449e-886b-6024480d4e83	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
879c95ae-a860-447e-8309-1ca9b7d36b24	review profile config	9810599f-a32f-4d69-893a-d08f7209a282
60387db2-056a-4244-9575-60a55a61b195	create unique user config	9810599f-a32f-4d69-893a-d08f7209a282
a3e00ac4-eaa6-4cec-92b6-8c8cc26181e4	review profile config	c46dc488-1d5b-449e-886b-6024480d4e83
e2f1b654-88bf-47eb-9661-85d986e7f2a0	create unique user config	c46dc488-1d5b-449e-886b-6024480d4e83
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
60387db2-056a-4244-9575-60a55a61b195	false	require.password.update.after.registration
879c95ae-a860-447e-8309-1ca9b7d36b24	missing	update.profile.on.first.login
a3e00ac4-eaa6-4cec-92b6-8c8cc26181e4	missing	update.profile.on.first.login
e2f1b654-88bf-47eb-9661-85d986e7f2a0	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	f	master-realm	0	f	\N	\N	t	\N	f	9810599f-a32f-4d69-893a-d08f7209a282	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
3c64e277-a482-44d8-a8cf-0d4122b11488	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	9810599f-a32f-4d69-893a-d08f7209a282	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
afba78af-48c0-47e4-b27e-53b0e5ae124d	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	9810599f-a32f-4d69-893a-d08f7209a282	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
e396082f-9a9c-41ab-8f49-8f4534bc785c	t	f	broker	0	f	\N	\N	t	\N	f	9810599f-a32f-4d69-893a-d08f7209a282	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
78c987d9-7aa8-4bb4-a795-3c9e6e998201	t	t	admin-cli	0	t	\N	\N	f	\N	f	9810599f-a32f-4d69-893a-d08f7209a282	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
8442a0ac-6e22-400c-8522-4ec51b254d40	t	f	my-realm-realm	0	f	\N	\N	t	\N	f	9810599f-a32f-4d69-893a-d08f7209a282	\N	0	f	f	my-realm Realm	f	client-secret	\N	\N	\N	t	f	f	f
57d25610-4002-4b7a-8aae-9a82e0979e29	t	f	realm-management	0	f	\N	\N	t	\N	f	c46dc488-1d5b-449e-886b-6024480d4e83	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	t	f	account	0	t	\N	/realms/my-realm/account/	f	\N	f	c46dc488-1d5b-449e-886b-6024480d4e83	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
72dc3713-9065-401e-821e-3e0d9c21f6ac	t	f	account-console	0	t	\N	/realms/my-realm/account/	f	\N	f	c46dc488-1d5b-449e-886b-6024480d4e83	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
692745f4-b7aa-4718-bd28-3283052b2136	t	f	broker	0	f	\N	\N	t	\N	f	c46dc488-1d5b-449e-886b-6024480d4e83	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
e3714741-c112-48ae-9166-c99d9b25a174	t	t	security-admin-console	0	t	\N	/admin/my-realm/console/	f	\N	f	c46dc488-1d5b-449e-886b-6024480d4e83	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
f3dd3080-e904-45f2-984b-3d38aceee633	t	t	admin-cli	0	t	\N	\N	f	\N	f	c46dc488-1d5b-449e-886b-6024480d4e83	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
419c054d-a05a-4d5f-8f3b-8654f86d8a82	t	t	kong	0	f	cmuXF8jHhTyjyVv2H2CoYrX9fwTZSQVc		f		f	c46dc488-1d5b-449e-886b-6024480d4e83	openid-connect	-1	t	f	Kong Client	t	client-secret		Client for Kong API Gateway	\N	t	f	t	t
c204d56a-263a-4c50-8489-45a040774637	t	t	security-admin-console	0	t	\N	/admin/master/console/	f		f	9810599f-a32f-4d69-893a-d08f7209a282	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}		\N	t	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
3c64e277-a482-44d8-a8cf-0d4122b11488	post.logout.redirect.uris	+
afba78af-48c0-47e4-b27e-53b0e5ae124d	post.logout.redirect.uris	+
afba78af-48c0-47e4-b27e-53b0e5ae124d	pkce.code.challenge.method	S256
c204d56a-263a-4c50-8489-45a040774637	post.logout.redirect.uris	+
c204d56a-263a-4c50-8489-45a040774637	pkce.code.challenge.method	S256
c204d56a-263a-4c50-8489-45a040774637	client.use.lightweight.access.token.enabled	true
78c987d9-7aa8-4bb4-a795-3c9e6e998201	client.use.lightweight.access.token.enabled	true
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	post.logout.redirect.uris	+
72dc3713-9065-401e-821e-3e0d9c21f6ac	post.logout.redirect.uris	+
72dc3713-9065-401e-821e-3e0d9c21f6ac	pkce.code.challenge.method	S256
e3714741-c112-48ae-9166-c99d9b25a174	post.logout.redirect.uris	+
e3714741-c112-48ae-9166-c99d9b25a174	pkce.code.challenge.method	S256
e3714741-c112-48ae-9166-c99d9b25a174	client.use.lightweight.access.token.enabled	true
f3dd3080-e904-45f2-984b-3d38aceee633	client.use.lightweight.access.token.enabled	true
419c054d-a05a-4d5f-8f3b-8654f86d8a82	oauth2.device.authorization.grant.enabled	true
419c054d-a05a-4d5f-8f3b-8654f86d8a82	oidc.ciba.grant.enabled	true
419c054d-a05a-4d5f-8f3b-8654f86d8a82	backchannel.logout.session.required	true
419c054d-a05a-4d5f-8f3b-8654f86d8a82	backchannel.logout.revoke.offline.tokens	false
419c054d-a05a-4d5f-8f3b-8654f86d8a82	client.secret.creation.time	1739166373
419c054d-a05a-4d5f-8f3b-8654f86d8a82	realm_client	false
419c054d-a05a-4d5f-8f3b-8654f86d8a82	display.on.consent.screen	false
419c054d-a05a-4d5f-8f3b-8654f86d8a82	frontchannel.logout.session.required	true
c204d56a-263a-4c50-8489-45a040774637	realm_client	false
c204d56a-263a-4c50-8489-45a040774637	oauth2.device.authorization.grant.enabled	false
c204d56a-263a-4c50-8489-45a040774637	oidc.ciba.grant.enabled	false
c204d56a-263a-4c50-8489-45a040774637	display.on.consent.screen	false
c204d56a-263a-4c50-8489-45a040774637	backchannel.logout.session.required	true
c204d56a-263a-4c50-8489-45a040774637	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
18eb89a9-b7a8-4518-9dbd-8240931c3d9d	offline_access	9810599f-a32f-4d69-893a-d08f7209a282	OpenID Connect built-in scope: offline_access	openid-connect
7e276f44-70c2-43b4-b7d3-6006d02172d0	role_list	9810599f-a32f-4d69-893a-d08f7209a282	SAML role list	saml
814b13c0-2255-4349-af70-6aba614d88c5	saml_organization	9810599f-a32f-4d69-893a-d08f7209a282	Organization Membership	saml
8d7bb5c2-46c3-4c37-b40a-743233979570	profile	9810599f-a32f-4d69-893a-d08f7209a282	OpenID Connect built-in scope: profile	openid-connect
68ccda09-ea26-483c-aa4f-5306a7a5992c	email	9810599f-a32f-4d69-893a-d08f7209a282	OpenID Connect built-in scope: email	openid-connect
91507df5-a08c-4080-b0f7-124725f50ccc	address	9810599f-a32f-4d69-893a-d08f7209a282	OpenID Connect built-in scope: address	openid-connect
02a40f0f-bdfb-4e90-b0f0-e154f8766787	phone	9810599f-a32f-4d69-893a-d08f7209a282	OpenID Connect built-in scope: phone	openid-connect
17bae105-a391-475e-b0fb-1acf39f46d58	roles	9810599f-a32f-4d69-893a-d08f7209a282	OpenID Connect scope for add user roles to the access token	openid-connect
8da2d223-4297-4166-a405-f9c0c2eda3b1	web-origins	9810599f-a32f-4d69-893a-d08f7209a282	OpenID Connect scope for add allowed web origins to the access token	openid-connect
12a9978c-7fdd-4e1c-8100-07e091808057	microprofile-jwt	9810599f-a32f-4d69-893a-d08f7209a282	Microprofile - JWT built-in scope	openid-connect
7930caf8-10ea-45f1-957e-6a51a69f4b09	acr	9810599f-a32f-4d69-893a-d08f7209a282	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
8588d757-d109-48c3-93b4-63698fb9e81a	basic	9810599f-a32f-4d69-893a-d08f7209a282	OpenID Connect scope for add all basic claims to the token	openid-connect
5d173d26-5c29-4af4-a1dc-98e1919f5128	service_account	9810599f-a32f-4d69-893a-d08f7209a282	Specific scope for a client enabled for service accounts	openid-connect
0b6d4d44-f036-4bda-ada1-972bb59f6e95	organization	9810599f-a32f-4d69-893a-d08f7209a282	Additional claims about the organization a subject belongs to	openid-connect
18ab70d0-6dde-4668-b396-abd0e0f4f23d	offline_access	c46dc488-1d5b-449e-886b-6024480d4e83	OpenID Connect built-in scope: offline_access	openid-connect
6c28a83f-f09f-494f-9346-671c09f29e3c	role_list	c46dc488-1d5b-449e-886b-6024480d4e83	SAML role list	saml
c53da4fb-8a5e-47ec-80af-7de31bcb55ab	saml_organization	c46dc488-1d5b-449e-886b-6024480d4e83	Organization Membership	saml
7a0f36cf-7639-434d-96ee-516ee53a3898	profile	c46dc488-1d5b-449e-886b-6024480d4e83	OpenID Connect built-in scope: profile	openid-connect
a8e5898b-5cb9-4a82-8383-578023a151b4	email	c46dc488-1d5b-449e-886b-6024480d4e83	OpenID Connect built-in scope: email	openid-connect
80c84187-d24a-4e47-8a85-e3142c0a3648	address	c46dc488-1d5b-449e-886b-6024480d4e83	OpenID Connect built-in scope: address	openid-connect
f90b816a-f494-4892-b766-df4e9af30098	phone	c46dc488-1d5b-449e-886b-6024480d4e83	OpenID Connect built-in scope: phone	openid-connect
dd5e2866-7793-4660-b5b3-1249286e8373	roles	c46dc488-1d5b-449e-886b-6024480d4e83	OpenID Connect scope for add user roles to the access token	openid-connect
fdeed3b7-ccf7-4403-a037-5c1be5abc614	web-origins	c46dc488-1d5b-449e-886b-6024480d4e83	OpenID Connect scope for add allowed web origins to the access token	openid-connect
5d43cdea-1f20-4887-950b-cf4417eca5da	microprofile-jwt	c46dc488-1d5b-449e-886b-6024480d4e83	Microprofile - JWT built-in scope	openid-connect
19a2c512-9ff9-473c-8735-097b1802a7f1	acr	c46dc488-1d5b-449e-886b-6024480d4e83	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
479b9395-bfcd-492f-b8fe-4c24f9175226	basic	c46dc488-1d5b-449e-886b-6024480d4e83	OpenID Connect scope for add all basic claims to the token	openid-connect
633f4bb0-74eb-45cb-90c2-f3b1d125f49a	service_account	c46dc488-1d5b-449e-886b-6024480d4e83	Specific scope for a client enabled for service accounts	openid-connect
aea5b7f9-a949-46d6-8478-26ee49ad6edc	organization	c46dc488-1d5b-449e-886b-6024480d4e83	Additional claims about the organization a subject belongs to	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
18eb89a9-b7a8-4518-9dbd-8240931c3d9d	true	display.on.consent.screen
18eb89a9-b7a8-4518-9dbd-8240931c3d9d	${offlineAccessScopeConsentText}	consent.screen.text
7e276f44-70c2-43b4-b7d3-6006d02172d0	true	display.on.consent.screen
7e276f44-70c2-43b4-b7d3-6006d02172d0	${samlRoleListScopeConsentText}	consent.screen.text
814b13c0-2255-4349-af70-6aba614d88c5	false	display.on.consent.screen
8d7bb5c2-46c3-4c37-b40a-743233979570	true	display.on.consent.screen
8d7bb5c2-46c3-4c37-b40a-743233979570	${profileScopeConsentText}	consent.screen.text
8d7bb5c2-46c3-4c37-b40a-743233979570	true	include.in.token.scope
68ccda09-ea26-483c-aa4f-5306a7a5992c	true	display.on.consent.screen
68ccda09-ea26-483c-aa4f-5306a7a5992c	${emailScopeConsentText}	consent.screen.text
68ccda09-ea26-483c-aa4f-5306a7a5992c	true	include.in.token.scope
91507df5-a08c-4080-b0f7-124725f50ccc	true	display.on.consent.screen
91507df5-a08c-4080-b0f7-124725f50ccc	${addressScopeConsentText}	consent.screen.text
91507df5-a08c-4080-b0f7-124725f50ccc	true	include.in.token.scope
02a40f0f-bdfb-4e90-b0f0-e154f8766787	true	display.on.consent.screen
02a40f0f-bdfb-4e90-b0f0-e154f8766787	${phoneScopeConsentText}	consent.screen.text
02a40f0f-bdfb-4e90-b0f0-e154f8766787	true	include.in.token.scope
17bae105-a391-475e-b0fb-1acf39f46d58	true	display.on.consent.screen
17bae105-a391-475e-b0fb-1acf39f46d58	${rolesScopeConsentText}	consent.screen.text
17bae105-a391-475e-b0fb-1acf39f46d58	false	include.in.token.scope
8da2d223-4297-4166-a405-f9c0c2eda3b1	false	display.on.consent.screen
8da2d223-4297-4166-a405-f9c0c2eda3b1		consent.screen.text
8da2d223-4297-4166-a405-f9c0c2eda3b1	false	include.in.token.scope
12a9978c-7fdd-4e1c-8100-07e091808057	false	display.on.consent.screen
12a9978c-7fdd-4e1c-8100-07e091808057	true	include.in.token.scope
7930caf8-10ea-45f1-957e-6a51a69f4b09	false	display.on.consent.screen
7930caf8-10ea-45f1-957e-6a51a69f4b09	false	include.in.token.scope
8588d757-d109-48c3-93b4-63698fb9e81a	false	display.on.consent.screen
8588d757-d109-48c3-93b4-63698fb9e81a	false	include.in.token.scope
5d173d26-5c29-4af4-a1dc-98e1919f5128	false	display.on.consent.screen
5d173d26-5c29-4af4-a1dc-98e1919f5128	false	include.in.token.scope
0b6d4d44-f036-4bda-ada1-972bb59f6e95	true	display.on.consent.screen
0b6d4d44-f036-4bda-ada1-972bb59f6e95	${organizationScopeConsentText}	consent.screen.text
0b6d4d44-f036-4bda-ada1-972bb59f6e95	true	include.in.token.scope
18ab70d0-6dde-4668-b396-abd0e0f4f23d	true	display.on.consent.screen
18ab70d0-6dde-4668-b396-abd0e0f4f23d	${offlineAccessScopeConsentText}	consent.screen.text
6c28a83f-f09f-494f-9346-671c09f29e3c	true	display.on.consent.screen
6c28a83f-f09f-494f-9346-671c09f29e3c	${samlRoleListScopeConsentText}	consent.screen.text
c53da4fb-8a5e-47ec-80af-7de31bcb55ab	false	display.on.consent.screen
7a0f36cf-7639-434d-96ee-516ee53a3898	true	display.on.consent.screen
7a0f36cf-7639-434d-96ee-516ee53a3898	${profileScopeConsentText}	consent.screen.text
7a0f36cf-7639-434d-96ee-516ee53a3898	true	include.in.token.scope
a8e5898b-5cb9-4a82-8383-578023a151b4	true	display.on.consent.screen
a8e5898b-5cb9-4a82-8383-578023a151b4	${emailScopeConsentText}	consent.screen.text
a8e5898b-5cb9-4a82-8383-578023a151b4	true	include.in.token.scope
80c84187-d24a-4e47-8a85-e3142c0a3648	true	display.on.consent.screen
80c84187-d24a-4e47-8a85-e3142c0a3648	${addressScopeConsentText}	consent.screen.text
80c84187-d24a-4e47-8a85-e3142c0a3648	true	include.in.token.scope
f90b816a-f494-4892-b766-df4e9af30098	true	display.on.consent.screen
f90b816a-f494-4892-b766-df4e9af30098	${phoneScopeConsentText}	consent.screen.text
f90b816a-f494-4892-b766-df4e9af30098	true	include.in.token.scope
dd5e2866-7793-4660-b5b3-1249286e8373	true	display.on.consent.screen
dd5e2866-7793-4660-b5b3-1249286e8373	${rolesScopeConsentText}	consent.screen.text
dd5e2866-7793-4660-b5b3-1249286e8373	false	include.in.token.scope
fdeed3b7-ccf7-4403-a037-5c1be5abc614	false	display.on.consent.screen
fdeed3b7-ccf7-4403-a037-5c1be5abc614		consent.screen.text
fdeed3b7-ccf7-4403-a037-5c1be5abc614	false	include.in.token.scope
5d43cdea-1f20-4887-950b-cf4417eca5da	false	display.on.consent.screen
5d43cdea-1f20-4887-950b-cf4417eca5da	true	include.in.token.scope
19a2c512-9ff9-473c-8735-097b1802a7f1	false	display.on.consent.screen
19a2c512-9ff9-473c-8735-097b1802a7f1	false	include.in.token.scope
479b9395-bfcd-492f-b8fe-4c24f9175226	false	display.on.consent.screen
479b9395-bfcd-492f-b8fe-4c24f9175226	false	include.in.token.scope
633f4bb0-74eb-45cb-90c2-f3b1d125f49a	false	display.on.consent.screen
633f4bb0-74eb-45cb-90c2-f3b1d125f49a	false	include.in.token.scope
aea5b7f9-a949-46d6-8478-26ee49ad6edc	true	display.on.consent.screen
aea5b7f9-a949-46d6-8478-26ee49ad6edc	${organizationScopeConsentText}	consent.screen.text
aea5b7f9-a949-46d6-8478-26ee49ad6edc	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
3c64e277-a482-44d8-a8cf-0d4122b11488	8588d757-d109-48c3-93b4-63698fb9e81a	t
3c64e277-a482-44d8-a8cf-0d4122b11488	68ccda09-ea26-483c-aa4f-5306a7a5992c	t
3c64e277-a482-44d8-a8cf-0d4122b11488	8da2d223-4297-4166-a405-f9c0c2eda3b1	t
3c64e277-a482-44d8-a8cf-0d4122b11488	7930caf8-10ea-45f1-957e-6a51a69f4b09	t
3c64e277-a482-44d8-a8cf-0d4122b11488	8d7bb5c2-46c3-4c37-b40a-743233979570	t
3c64e277-a482-44d8-a8cf-0d4122b11488	17bae105-a391-475e-b0fb-1acf39f46d58	t
3c64e277-a482-44d8-a8cf-0d4122b11488	91507df5-a08c-4080-b0f7-124725f50ccc	f
3c64e277-a482-44d8-a8cf-0d4122b11488	02a40f0f-bdfb-4e90-b0f0-e154f8766787	f
3c64e277-a482-44d8-a8cf-0d4122b11488	18eb89a9-b7a8-4518-9dbd-8240931c3d9d	f
3c64e277-a482-44d8-a8cf-0d4122b11488	12a9978c-7fdd-4e1c-8100-07e091808057	f
3c64e277-a482-44d8-a8cf-0d4122b11488	0b6d4d44-f036-4bda-ada1-972bb59f6e95	f
afba78af-48c0-47e4-b27e-53b0e5ae124d	8588d757-d109-48c3-93b4-63698fb9e81a	t
afba78af-48c0-47e4-b27e-53b0e5ae124d	68ccda09-ea26-483c-aa4f-5306a7a5992c	t
afba78af-48c0-47e4-b27e-53b0e5ae124d	8da2d223-4297-4166-a405-f9c0c2eda3b1	t
afba78af-48c0-47e4-b27e-53b0e5ae124d	7930caf8-10ea-45f1-957e-6a51a69f4b09	t
afba78af-48c0-47e4-b27e-53b0e5ae124d	8d7bb5c2-46c3-4c37-b40a-743233979570	t
afba78af-48c0-47e4-b27e-53b0e5ae124d	17bae105-a391-475e-b0fb-1acf39f46d58	t
afba78af-48c0-47e4-b27e-53b0e5ae124d	91507df5-a08c-4080-b0f7-124725f50ccc	f
afba78af-48c0-47e4-b27e-53b0e5ae124d	02a40f0f-bdfb-4e90-b0f0-e154f8766787	f
afba78af-48c0-47e4-b27e-53b0e5ae124d	18eb89a9-b7a8-4518-9dbd-8240931c3d9d	f
afba78af-48c0-47e4-b27e-53b0e5ae124d	12a9978c-7fdd-4e1c-8100-07e091808057	f
afba78af-48c0-47e4-b27e-53b0e5ae124d	0b6d4d44-f036-4bda-ada1-972bb59f6e95	f
78c987d9-7aa8-4bb4-a795-3c9e6e998201	8588d757-d109-48c3-93b4-63698fb9e81a	t
78c987d9-7aa8-4bb4-a795-3c9e6e998201	68ccda09-ea26-483c-aa4f-5306a7a5992c	t
78c987d9-7aa8-4bb4-a795-3c9e6e998201	8da2d223-4297-4166-a405-f9c0c2eda3b1	t
78c987d9-7aa8-4bb4-a795-3c9e6e998201	7930caf8-10ea-45f1-957e-6a51a69f4b09	t
78c987d9-7aa8-4bb4-a795-3c9e6e998201	8d7bb5c2-46c3-4c37-b40a-743233979570	t
78c987d9-7aa8-4bb4-a795-3c9e6e998201	17bae105-a391-475e-b0fb-1acf39f46d58	t
78c987d9-7aa8-4bb4-a795-3c9e6e998201	91507df5-a08c-4080-b0f7-124725f50ccc	f
78c987d9-7aa8-4bb4-a795-3c9e6e998201	02a40f0f-bdfb-4e90-b0f0-e154f8766787	f
78c987d9-7aa8-4bb4-a795-3c9e6e998201	18eb89a9-b7a8-4518-9dbd-8240931c3d9d	f
78c987d9-7aa8-4bb4-a795-3c9e6e998201	12a9978c-7fdd-4e1c-8100-07e091808057	f
78c987d9-7aa8-4bb4-a795-3c9e6e998201	0b6d4d44-f036-4bda-ada1-972bb59f6e95	f
e396082f-9a9c-41ab-8f49-8f4534bc785c	8588d757-d109-48c3-93b4-63698fb9e81a	t
e396082f-9a9c-41ab-8f49-8f4534bc785c	68ccda09-ea26-483c-aa4f-5306a7a5992c	t
e396082f-9a9c-41ab-8f49-8f4534bc785c	8da2d223-4297-4166-a405-f9c0c2eda3b1	t
e396082f-9a9c-41ab-8f49-8f4534bc785c	7930caf8-10ea-45f1-957e-6a51a69f4b09	t
e396082f-9a9c-41ab-8f49-8f4534bc785c	8d7bb5c2-46c3-4c37-b40a-743233979570	t
e396082f-9a9c-41ab-8f49-8f4534bc785c	17bae105-a391-475e-b0fb-1acf39f46d58	t
e396082f-9a9c-41ab-8f49-8f4534bc785c	91507df5-a08c-4080-b0f7-124725f50ccc	f
e396082f-9a9c-41ab-8f49-8f4534bc785c	02a40f0f-bdfb-4e90-b0f0-e154f8766787	f
e396082f-9a9c-41ab-8f49-8f4534bc785c	18eb89a9-b7a8-4518-9dbd-8240931c3d9d	f
e396082f-9a9c-41ab-8f49-8f4534bc785c	12a9978c-7fdd-4e1c-8100-07e091808057	f
e396082f-9a9c-41ab-8f49-8f4534bc785c	0b6d4d44-f036-4bda-ada1-972bb59f6e95	f
e781c0bf-0ec5-4947-b7c3-9112207b95ac	8588d757-d109-48c3-93b4-63698fb9e81a	t
e781c0bf-0ec5-4947-b7c3-9112207b95ac	68ccda09-ea26-483c-aa4f-5306a7a5992c	t
e781c0bf-0ec5-4947-b7c3-9112207b95ac	8da2d223-4297-4166-a405-f9c0c2eda3b1	t
e781c0bf-0ec5-4947-b7c3-9112207b95ac	7930caf8-10ea-45f1-957e-6a51a69f4b09	t
e781c0bf-0ec5-4947-b7c3-9112207b95ac	8d7bb5c2-46c3-4c37-b40a-743233979570	t
e781c0bf-0ec5-4947-b7c3-9112207b95ac	17bae105-a391-475e-b0fb-1acf39f46d58	t
e781c0bf-0ec5-4947-b7c3-9112207b95ac	91507df5-a08c-4080-b0f7-124725f50ccc	f
e781c0bf-0ec5-4947-b7c3-9112207b95ac	02a40f0f-bdfb-4e90-b0f0-e154f8766787	f
e781c0bf-0ec5-4947-b7c3-9112207b95ac	18eb89a9-b7a8-4518-9dbd-8240931c3d9d	f
e781c0bf-0ec5-4947-b7c3-9112207b95ac	12a9978c-7fdd-4e1c-8100-07e091808057	f
e781c0bf-0ec5-4947-b7c3-9112207b95ac	0b6d4d44-f036-4bda-ada1-972bb59f6e95	f
c204d56a-263a-4c50-8489-45a040774637	8588d757-d109-48c3-93b4-63698fb9e81a	t
c204d56a-263a-4c50-8489-45a040774637	68ccda09-ea26-483c-aa4f-5306a7a5992c	t
c204d56a-263a-4c50-8489-45a040774637	8da2d223-4297-4166-a405-f9c0c2eda3b1	t
c204d56a-263a-4c50-8489-45a040774637	7930caf8-10ea-45f1-957e-6a51a69f4b09	t
c204d56a-263a-4c50-8489-45a040774637	8d7bb5c2-46c3-4c37-b40a-743233979570	t
c204d56a-263a-4c50-8489-45a040774637	17bae105-a391-475e-b0fb-1acf39f46d58	t
c204d56a-263a-4c50-8489-45a040774637	91507df5-a08c-4080-b0f7-124725f50ccc	f
c204d56a-263a-4c50-8489-45a040774637	02a40f0f-bdfb-4e90-b0f0-e154f8766787	f
c204d56a-263a-4c50-8489-45a040774637	18eb89a9-b7a8-4518-9dbd-8240931c3d9d	f
c204d56a-263a-4c50-8489-45a040774637	12a9978c-7fdd-4e1c-8100-07e091808057	f
c204d56a-263a-4c50-8489-45a040774637	0b6d4d44-f036-4bda-ada1-972bb59f6e95	f
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	a8e5898b-5cb9-4a82-8383-578023a151b4	t
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	fdeed3b7-ccf7-4403-a037-5c1be5abc614	t
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	479b9395-bfcd-492f-b8fe-4c24f9175226	t
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	dd5e2866-7793-4660-b5b3-1249286e8373	t
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	7a0f36cf-7639-434d-96ee-516ee53a3898	t
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	19a2c512-9ff9-473c-8735-097b1802a7f1	t
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	aea5b7f9-a949-46d6-8478-26ee49ad6edc	f
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	5d43cdea-1f20-4887-950b-cf4417eca5da	f
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	80c84187-d24a-4e47-8a85-e3142c0a3648	f
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	18ab70d0-6dde-4668-b396-abd0e0f4f23d	f
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	f90b816a-f494-4892-b766-df4e9af30098	f
72dc3713-9065-401e-821e-3e0d9c21f6ac	a8e5898b-5cb9-4a82-8383-578023a151b4	t
72dc3713-9065-401e-821e-3e0d9c21f6ac	fdeed3b7-ccf7-4403-a037-5c1be5abc614	t
72dc3713-9065-401e-821e-3e0d9c21f6ac	479b9395-bfcd-492f-b8fe-4c24f9175226	t
72dc3713-9065-401e-821e-3e0d9c21f6ac	dd5e2866-7793-4660-b5b3-1249286e8373	t
72dc3713-9065-401e-821e-3e0d9c21f6ac	7a0f36cf-7639-434d-96ee-516ee53a3898	t
72dc3713-9065-401e-821e-3e0d9c21f6ac	19a2c512-9ff9-473c-8735-097b1802a7f1	t
72dc3713-9065-401e-821e-3e0d9c21f6ac	aea5b7f9-a949-46d6-8478-26ee49ad6edc	f
72dc3713-9065-401e-821e-3e0d9c21f6ac	5d43cdea-1f20-4887-950b-cf4417eca5da	f
72dc3713-9065-401e-821e-3e0d9c21f6ac	80c84187-d24a-4e47-8a85-e3142c0a3648	f
72dc3713-9065-401e-821e-3e0d9c21f6ac	18ab70d0-6dde-4668-b396-abd0e0f4f23d	f
72dc3713-9065-401e-821e-3e0d9c21f6ac	f90b816a-f494-4892-b766-df4e9af30098	f
f3dd3080-e904-45f2-984b-3d38aceee633	a8e5898b-5cb9-4a82-8383-578023a151b4	t
f3dd3080-e904-45f2-984b-3d38aceee633	fdeed3b7-ccf7-4403-a037-5c1be5abc614	t
f3dd3080-e904-45f2-984b-3d38aceee633	479b9395-bfcd-492f-b8fe-4c24f9175226	t
f3dd3080-e904-45f2-984b-3d38aceee633	dd5e2866-7793-4660-b5b3-1249286e8373	t
f3dd3080-e904-45f2-984b-3d38aceee633	7a0f36cf-7639-434d-96ee-516ee53a3898	t
f3dd3080-e904-45f2-984b-3d38aceee633	19a2c512-9ff9-473c-8735-097b1802a7f1	t
f3dd3080-e904-45f2-984b-3d38aceee633	aea5b7f9-a949-46d6-8478-26ee49ad6edc	f
f3dd3080-e904-45f2-984b-3d38aceee633	5d43cdea-1f20-4887-950b-cf4417eca5da	f
f3dd3080-e904-45f2-984b-3d38aceee633	80c84187-d24a-4e47-8a85-e3142c0a3648	f
f3dd3080-e904-45f2-984b-3d38aceee633	18ab70d0-6dde-4668-b396-abd0e0f4f23d	f
f3dd3080-e904-45f2-984b-3d38aceee633	f90b816a-f494-4892-b766-df4e9af30098	f
692745f4-b7aa-4718-bd28-3283052b2136	a8e5898b-5cb9-4a82-8383-578023a151b4	t
692745f4-b7aa-4718-bd28-3283052b2136	fdeed3b7-ccf7-4403-a037-5c1be5abc614	t
692745f4-b7aa-4718-bd28-3283052b2136	479b9395-bfcd-492f-b8fe-4c24f9175226	t
692745f4-b7aa-4718-bd28-3283052b2136	dd5e2866-7793-4660-b5b3-1249286e8373	t
692745f4-b7aa-4718-bd28-3283052b2136	7a0f36cf-7639-434d-96ee-516ee53a3898	t
692745f4-b7aa-4718-bd28-3283052b2136	19a2c512-9ff9-473c-8735-097b1802a7f1	t
692745f4-b7aa-4718-bd28-3283052b2136	aea5b7f9-a949-46d6-8478-26ee49ad6edc	f
692745f4-b7aa-4718-bd28-3283052b2136	5d43cdea-1f20-4887-950b-cf4417eca5da	f
692745f4-b7aa-4718-bd28-3283052b2136	80c84187-d24a-4e47-8a85-e3142c0a3648	f
692745f4-b7aa-4718-bd28-3283052b2136	18ab70d0-6dde-4668-b396-abd0e0f4f23d	f
692745f4-b7aa-4718-bd28-3283052b2136	f90b816a-f494-4892-b766-df4e9af30098	f
57d25610-4002-4b7a-8aae-9a82e0979e29	a8e5898b-5cb9-4a82-8383-578023a151b4	t
57d25610-4002-4b7a-8aae-9a82e0979e29	fdeed3b7-ccf7-4403-a037-5c1be5abc614	t
57d25610-4002-4b7a-8aae-9a82e0979e29	479b9395-bfcd-492f-b8fe-4c24f9175226	t
57d25610-4002-4b7a-8aae-9a82e0979e29	dd5e2866-7793-4660-b5b3-1249286e8373	t
57d25610-4002-4b7a-8aae-9a82e0979e29	7a0f36cf-7639-434d-96ee-516ee53a3898	t
57d25610-4002-4b7a-8aae-9a82e0979e29	19a2c512-9ff9-473c-8735-097b1802a7f1	t
57d25610-4002-4b7a-8aae-9a82e0979e29	aea5b7f9-a949-46d6-8478-26ee49ad6edc	f
57d25610-4002-4b7a-8aae-9a82e0979e29	5d43cdea-1f20-4887-950b-cf4417eca5da	f
57d25610-4002-4b7a-8aae-9a82e0979e29	80c84187-d24a-4e47-8a85-e3142c0a3648	f
57d25610-4002-4b7a-8aae-9a82e0979e29	18ab70d0-6dde-4668-b396-abd0e0f4f23d	f
57d25610-4002-4b7a-8aae-9a82e0979e29	f90b816a-f494-4892-b766-df4e9af30098	f
e3714741-c112-48ae-9166-c99d9b25a174	a8e5898b-5cb9-4a82-8383-578023a151b4	t
e3714741-c112-48ae-9166-c99d9b25a174	fdeed3b7-ccf7-4403-a037-5c1be5abc614	t
e3714741-c112-48ae-9166-c99d9b25a174	479b9395-bfcd-492f-b8fe-4c24f9175226	t
e3714741-c112-48ae-9166-c99d9b25a174	dd5e2866-7793-4660-b5b3-1249286e8373	t
e3714741-c112-48ae-9166-c99d9b25a174	7a0f36cf-7639-434d-96ee-516ee53a3898	t
e3714741-c112-48ae-9166-c99d9b25a174	19a2c512-9ff9-473c-8735-097b1802a7f1	t
e3714741-c112-48ae-9166-c99d9b25a174	aea5b7f9-a949-46d6-8478-26ee49ad6edc	f
e3714741-c112-48ae-9166-c99d9b25a174	5d43cdea-1f20-4887-950b-cf4417eca5da	f
e3714741-c112-48ae-9166-c99d9b25a174	80c84187-d24a-4e47-8a85-e3142c0a3648	f
e3714741-c112-48ae-9166-c99d9b25a174	18ab70d0-6dde-4668-b396-abd0e0f4f23d	f
e3714741-c112-48ae-9166-c99d9b25a174	f90b816a-f494-4892-b766-df4e9af30098	f
419c054d-a05a-4d5f-8f3b-8654f86d8a82	a8e5898b-5cb9-4a82-8383-578023a151b4	t
419c054d-a05a-4d5f-8f3b-8654f86d8a82	fdeed3b7-ccf7-4403-a037-5c1be5abc614	t
419c054d-a05a-4d5f-8f3b-8654f86d8a82	479b9395-bfcd-492f-b8fe-4c24f9175226	t
419c054d-a05a-4d5f-8f3b-8654f86d8a82	dd5e2866-7793-4660-b5b3-1249286e8373	t
419c054d-a05a-4d5f-8f3b-8654f86d8a82	7a0f36cf-7639-434d-96ee-516ee53a3898	t
419c054d-a05a-4d5f-8f3b-8654f86d8a82	19a2c512-9ff9-473c-8735-097b1802a7f1	t
419c054d-a05a-4d5f-8f3b-8654f86d8a82	aea5b7f9-a949-46d6-8478-26ee49ad6edc	f
419c054d-a05a-4d5f-8f3b-8654f86d8a82	5d43cdea-1f20-4887-950b-cf4417eca5da	f
419c054d-a05a-4d5f-8f3b-8654f86d8a82	80c84187-d24a-4e47-8a85-e3142c0a3648	f
419c054d-a05a-4d5f-8f3b-8654f86d8a82	18ab70d0-6dde-4668-b396-abd0e0f4f23d	f
419c054d-a05a-4d5f-8f3b-8654f86d8a82	f90b816a-f494-4892-b766-df4e9af30098	f
419c054d-a05a-4d5f-8f3b-8654f86d8a82	633f4bb0-74eb-45cb-90c2-f3b1d125f49a	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
18eb89a9-b7a8-4518-9dbd-8240931c3d9d	d3012426-111a-41dd-8adf-e3a626a1d0cd
18ab70d0-6dde-4668-b396-abd0e0f4f23d	e9cfac0d-f3b0-4441-8ad7-fea724371b05
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
6fcd3a26-4d9c-4b69-8ad8-ce532e33390b	Trusted Hosts	9810599f-a32f-4d69-893a-d08f7209a282	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9810599f-a32f-4d69-893a-d08f7209a282	anonymous
3049e0b8-df73-4b89-ad8a-19880e1a4d75	Consent Required	9810599f-a32f-4d69-893a-d08f7209a282	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9810599f-a32f-4d69-893a-d08f7209a282	anonymous
32e65327-10ae-45c1-9754-3b15ae976916	Full Scope Disabled	9810599f-a32f-4d69-893a-d08f7209a282	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9810599f-a32f-4d69-893a-d08f7209a282	anonymous
af636e05-6f77-4406-8e2a-db1c45273fd4	Max Clients Limit	9810599f-a32f-4d69-893a-d08f7209a282	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9810599f-a32f-4d69-893a-d08f7209a282	anonymous
4b4e0f5d-519a-46ec-b9c9-b79c1a3af491	Allowed Protocol Mapper Types	9810599f-a32f-4d69-893a-d08f7209a282	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9810599f-a32f-4d69-893a-d08f7209a282	anonymous
a68207be-88a4-49e9-918f-03685d1777ab	Allowed Client Scopes	9810599f-a32f-4d69-893a-d08f7209a282	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9810599f-a32f-4d69-893a-d08f7209a282	anonymous
bbbabc75-11e2-4fb3-8f48-7bf472907d44	Allowed Protocol Mapper Types	9810599f-a32f-4d69-893a-d08f7209a282	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9810599f-a32f-4d69-893a-d08f7209a282	authenticated
bfbae768-ff2d-4dc5-b738-1ab050ae948a	Allowed Client Scopes	9810599f-a32f-4d69-893a-d08f7209a282	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	9810599f-a32f-4d69-893a-d08f7209a282	authenticated
7e5bc1e5-3e23-43cd-9cdc-e4b50cf5b87d	rsa-generated	9810599f-a32f-4d69-893a-d08f7209a282	rsa-generated	org.keycloak.keys.KeyProvider	9810599f-a32f-4d69-893a-d08f7209a282	\N
117bb7d2-4474-49c7-ae04-310209f2ede4	rsa-enc-generated	9810599f-a32f-4d69-893a-d08f7209a282	rsa-enc-generated	org.keycloak.keys.KeyProvider	9810599f-a32f-4d69-893a-d08f7209a282	\N
79e83cde-2575-4ba4-9f4d-db1be79b2185	hmac-generated-hs512	9810599f-a32f-4d69-893a-d08f7209a282	hmac-generated	org.keycloak.keys.KeyProvider	9810599f-a32f-4d69-893a-d08f7209a282	\N
e61e3278-afcc-4369-bc01-fea004558bf5	aes-generated	9810599f-a32f-4d69-893a-d08f7209a282	aes-generated	org.keycloak.keys.KeyProvider	9810599f-a32f-4d69-893a-d08f7209a282	\N
8bfe14e6-0592-4405-bf72-46aa92ca171a	\N	9810599f-a32f-4d69-893a-d08f7209a282	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	9810599f-a32f-4d69-893a-d08f7209a282	\N
b6a9dd6f-7de2-4d68-a03c-6e27b8f83843	rsa-generated	c46dc488-1d5b-449e-886b-6024480d4e83	rsa-generated	org.keycloak.keys.KeyProvider	c46dc488-1d5b-449e-886b-6024480d4e83	\N
d8e3815c-d7b2-47b1-8dc3-841f5277bac0	rsa-enc-generated	c46dc488-1d5b-449e-886b-6024480d4e83	rsa-enc-generated	org.keycloak.keys.KeyProvider	c46dc488-1d5b-449e-886b-6024480d4e83	\N
1668b931-5c04-4e06-b7c8-7c702188a794	hmac-generated-hs512	c46dc488-1d5b-449e-886b-6024480d4e83	hmac-generated	org.keycloak.keys.KeyProvider	c46dc488-1d5b-449e-886b-6024480d4e83	\N
f71ad7a8-08d1-4c9c-8d14-10d47becd126	aes-generated	c46dc488-1d5b-449e-886b-6024480d4e83	aes-generated	org.keycloak.keys.KeyProvider	c46dc488-1d5b-449e-886b-6024480d4e83	\N
ad44d1a6-c47d-4254-a75c-8a4ffccfe5b7	Trusted Hosts	c46dc488-1d5b-449e-886b-6024480d4e83	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	anonymous
2d6a76fd-face-442a-beb6-b1753a9b3b2d	Consent Required	c46dc488-1d5b-449e-886b-6024480d4e83	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	anonymous
5be33d23-c7cf-4d69-84c5-ec3a2a5abcaf	Full Scope Disabled	c46dc488-1d5b-449e-886b-6024480d4e83	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	anonymous
b508f35c-daae-4505-a933-763df3ff90be	Max Clients Limit	c46dc488-1d5b-449e-886b-6024480d4e83	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	anonymous
994b13d7-a7d8-4e93-bf03-20e8d2971df8	Allowed Protocol Mapper Types	c46dc488-1d5b-449e-886b-6024480d4e83	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	anonymous
dbf342a6-3709-4776-b9c9-52f5356e9223	Allowed Client Scopes	c46dc488-1d5b-449e-886b-6024480d4e83	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	anonymous
8aa55f5a-bc69-436d-ab2b-847fe19956be	Allowed Protocol Mapper Types	c46dc488-1d5b-449e-886b-6024480d4e83	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	authenticated
e2125110-869f-4886-96ce-f80670db0336	Allowed Client Scopes	c46dc488-1d5b-449e-886b-6024480d4e83	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
62448534-84a0-4eab-9b17-78062a01c32b	a68207be-88a4-49e9-918f-03685d1777ab	allow-default-scopes	true
89dd7bb8-a95f-40ca-9ce2-c2638125306f	bbbabc75-11e2-4fb3-8f48-7bf472907d44	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
63cf8696-5406-4b9a-8c78-901ba0fb84eb	bbbabc75-11e2-4fb3-8f48-7bf472907d44	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
c2614f6d-a4fa-4720-8d3d-7483f3f1ff23	bbbabc75-11e2-4fb3-8f48-7bf472907d44	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
2ec33195-93a4-47b5-9acf-1cf55c16177b	bbbabc75-11e2-4fb3-8f48-7bf472907d44	allowed-protocol-mapper-types	saml-user-property-mapper
24300ee4-3dbd-4655-8a7e-5357f0069af9	bbbabc75-11e2-4fb3-8f48-7bf472907d44	allowed-protocol-mapper-types	saml-role-list-mapper
0f2ab5e8-b4f0-4e7c-924f-357ba1b84e0d	bbbabc75-11e2-4fb3-8f48-7bf472907d44	allowed-protocol-mapper-types	saml-user-attribute-mapper
6fb24966-1242-477f-9dac-89d955de3458	bbbabc75-11e2-4fb3-8f48-7bf472907d44	allowed-protocol-mapper-types	oidc-full-name-mapper
b82e4129-701d-4318-846e-d5c28d8782b1	bbbabc75-11e2-4fb3-8f48-7bf472907d44	allowed-protocol-mapper-types	oidc-address-mapper
2669d529-d93b-40c6-a18f-d60bd85526bf	bfbae768-ff2d-4dc5-b738-1ab050ae948a	allow-default-scopes	true
df8f414b-65d1-4e91-bb14-90b088857643	4b4e0f5d-519a-46ec-b9c9-b79c1a3af491	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
050e778b-14bf-4a7b-b406-073313f311c3	4b4e0f5d-519a-46ec-b9c9-b79c1a3af491	allowed-protocol-mapper-types	oidc-full-name-mapper
8030ad2e-885c-4ecd-bf52-dadb51603538	4b4e0f5d-519a-46ec-b9c9-b79c1a3af491	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
ffc6effd-7346-41a0-8d9e-242c33529d38	4b4e0f5d-519a-46ec-b9c9-b79c1a3af491	allowed-protocol-mapper-types	saml-role-list-mapper
588f7f9a-8857-4ffe-a1cf-8d67d75e18c4	4b4e0f5d-519a-46ec-b9c9-b79c1a3af491	allowed-protocol-mapper-types	saml-user-attribute-mapper
48f81f5f-7a43-4a49-a1f5-89bc199a6ace	4b4e0f5d-519a-46ec-b9c9-b79c1a3af491	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0bbd64f1-772a-4027-b3bb-597997704897	4b4e0f5d-519a-46ec-b9c9-b79c1a3af491	allowed-protocol-mapper-types	saml-user-property-mapper
e807e7bf-835a-4d36-99e7-e4fac5061098	4b4e0f5d-519a-46ec-b9c9-b79c1a3af491	allowed-protocol-mapper-types	oidc-address-mapper
e2c3787e-01d5-4835-9260-32e495c0c5ee	6fcd3a26-4d9c-4b69-8ad8-ce532e33390b	client-uris-must-match	true
90bcb547-c316-4f9c-927a-107f035c9006	6fcd3a26-4d9c-4b69-8ad8-ce532e33390b	host-sending-registration-request-must-match	true
c9b704f8-8402-4ebf-bdfb-376399b87096	af636e05-6f77-4406-8e2a-db1c45273fd4	max-clients	200
49ebb2c7-3022-4f02-9d41-b0b223bb2996	117bb7d2-4474-49c7-ae04-310209f2ede4	privateKey	MIIEpAIBAAKCAQEA0+BGi1eBj4bAQXo9D4P+fOYIgl3Gjc+2V99WWxkqNOgSsL91bXhjVgC+HChY8CogEI5REgihxI7eJHG3UKyTGubqgN7Xp0NDWm6LEBUwe5AafdE67fJEJjyQpHhZ6NLz1J7t6D9hur6CQRXvHN3Q+seE0fbgmgqq6bejhbHuHVTti/cHR5gpkScPgrgCTMQlaCeCmo+HmdKNMTtmSGRuRKUwhoFdU5KsBf48xThGSQiu2QoBB+vWMbT2VPWNB5Bkvn5/vl0RY5HB8EAhTaEbIRd6MLyMqyp8AKVI9bVZrgL0CZ6JHZO/qJh+bnJgNaQ+bW1xW2h50kNQSRS/rv+KEwIDAQABAoIBAGlcZ/g25bjH26cz8FVc4BqgEa8yjuBKYHTGHR1kIDb7CQBX1T9A1LUZ3XAHKGMVr6hL/UiofjlOim05F13I08ZW+lpndno42q+HtSOkRd3MRUA34cQd64HQMGV5a8x5ysL63XfWvPSuc/uFushyDdAHk6cNy5cOovtiVLDRUIXIpEorzNRi2BAp9HZsBBC5gxLGTQ9x5nEiOaAEpbw2u9afS8Nv4YfcCScCXodGWZ4X1y8WVN7Jty9Pejl5Y3h3XkuDUpa63+Q9PFXW7N2CjqZHIO63dbKLxqeatmR7sOOWVOwpD+CNmU/YwIJM3lOFZDPCATTgoSyGZPanNVviVgECgYEA69QQ9FhyScoqgOrU/6FX5aWNtCuxv3iGOheV0xOZtrA//sPz1qmo2FK2ipjH19WR2zZcQNqcR8D5xEBgJ2SsLK6euS5q8lk9kTEKs4Gz1Rh5o1Cyx8ROuiIKn7rxRp+Dl/AQzcOzaN7BqHbuT9lONVTITLrCxS6AZViDHF14OoECgYEA5f+5x1WlD7+uXJmcc5LzD6MbQsktcyUMNGp9c+eKWfeAv03sDCwXuYDCZbrYta2gy3FuO+8r+QLhG7uabr/a0Xdwj7OMtMRQkpEWxcFfwOnTdwcPP7GawRK8bC98OGPbn2Iism49tOXRnf+Uhf8lAXe899SWQw+BnSZMAneo8pMCgYAE0mU2WciccaHE2QhZ4bamX2gyUuJjg9dawLizhCcUcS4dy2vk67skESziUJVleFxvGwFv4ghn/y4cMSTGKWzLzRY5uxU8t05m9ZW+bdx7cvCpwjClnQHvFFsbQPtF8mUCakotqt60OjnDdAsTXuIWfRFLYFYzKew+Jj0oC1E2AQKBgQCEFAWYnesrDxVPIfuBNzsTmMP351WNURIgK6MdYzLFFWe+9D2Ag/Wf1nxMNS9rrWiwS9RU4LUsy2WAKoy12sELFv7x1tcPm8j1UhJ0v+Z//wcrzEcKebB3/Y1sxxwbueSOM6nfM4WGE4/7nqCpDmsu25cN7uvXWNlC6JIvvI2ttwKBgQDJPP+DdvOkM4JAjfc/kUpI1AluitvYBfbwBZf+sPx/y26arcwD56BigybgybnapeeSeNRmk/pI6KL6XTr/JyaXblVrfJc4vLBWp1fr8TWJPe8tvr03RQt64NULMXN796tu1+yHb4W8R8TPyPuUj56ffO5r8Q2CHNjQJXtioAGTeQ==
fd4092a6-319a-4513-ab5d-a634c80920cb	117bb7d2-4474-49c7-ae04-310209f2ede4	keyUse	ENC
8e5efada-37c4-49bc-8acd-ae3afa527721	117bb7d2-4474-49c7-ae04-310209f2ede4	priority	100
862abafb-2f4a-4720-b466-683c7dc0f7fc	117bb7d2-4474-49c7-ae04-310209f2ede4	algorithm	RSA-OAEP
860389b2-f5a9-4b26-8369-46ffab457b27	117bb7d2-4474-49c7-ae04-310209f2ede4	certificate	MIICmzCCAYMCBgGU7WeOWzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMjEwMDEwNzU0WhcNMzUwMjEwMDEwOTM0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDT4EaLV4GPhsBBej0Pg/585giCXcaNz7ZX31ZbGSo06BKwv3VteGNWAL4cKFjwKiAQjlESCKHEjt4kcbdQrJMa5uqA3tenQ0NabosQFTB7kBp90Trt8kQmPJCkeFno0vPUnu3oP2G6voJBFe8c3dD6x4TR9uCaCqrpt6OFse4dVO2L9wdHmCmRJw+CuAJMxCVoJ4Kaj4eZ0o0xO2ZIZG5EpTCGgV1TkqwF/jzFOEZJCK7ZCgEH69YxtPZU9Y0HkGS+fn++XRFjkcHwQCFNoRshF3owvIyrKnwApUj1tVmuAvQJnokdk7+omH5ucmA1pD5tbXFbaHnSQ1BJFL+u/4oTAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAAqcdoYcEzcxz6+scChgZM9YuCa0yefvodpdtzjYiHU0GlOBG8vWnOn58ffCVjiayZ+H08Q/a9SZM7mk0oAZoJ7RA4llPdqgAKvQQEnuDQ34oBed+poZUJBnAtOqVpJHxJwatcq7Pit9hb6TGZJqILkK8ExGKi1hrd9bD3RGSX6Gw1qjIIrDJKeCHFLZcCLO2L1nmg8Nwcsk92BKUCesP6ZUMB4FiMudaR6pyjNV+Ow5xIOqUYQqCPT42mXSiNtZlRAtYTiaH1dYAk+Sa0oYXjKuLHbr1fUYrqHkxEiyk5YpSh1icjTZH9tY7XadeeUvEQJlJ3Gag7oII7WzXb+Ts4k=
08326c5f-1037-42e0-864f-830f1053d031	8bfe14e6-0592-4405-bf72-46aa92ca171a	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
d96f5257-f53d-43ae-bbc4-28ef438bfe39	7e5bc1e5-3e23-43cd-9cdc-e4b50cf5b87d	keyUse	SIG
fa40ead6-2494-4e28-9404-6c12fd24439b	7e5bc1e5-3e23-43cd-9cdc-e4b50cf5b87d	certificate	MIICmzCCAYMCBgGU7WeNizANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjUwMjEwMDEwNzU0WhcNMzUwMjEwMDEwOTM0WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCImAMoOBLz77F0ul8vEW0xvmRtFUxojsg+6CU8kacT6wkQjKSUeXSotikQ1NQbgcjIBfO2M2muzT0b+1/3Es8WYMCrLEMkDHyTnxlzw5HZt6j8mOLemHoog2PLKP/jlSvQ5wpnZn8jXRPODEg2rmiNC8IYmOGj46NjwD+bwTkzc91mpiQV/pOmX+pWJGtytTDffr9ElMAP+lVx7ndns3i7OwXpVjCRgeiitwvSv/dtgybNdiG5rOX+aKFKdX7uqvaABR1/0nnK35TCkhisIWUnBwRZ5mHaEM8WMmC9VJT5qjRJegBHnkBfHnFr/jHZReBMYnJn56I1Mgm+g9V6xS6NAgMBAAEwDQYJKoZIhvcNAQELBQADggEBADr1ahUd5u6FictAXP1rH7oSwxzdUWkKaX14Z4VjqHZXymokqgMMykEE3h1VDYJfyJa83CN97YscTjWSp3VNYwXqzjjFbMS4pQe7QTI8WzS1kYfmo0zkhfHgStdFdVOfAI/0kFC8HB+fXZ43/wPz3nPO1xl12ZANko7rQDLJe2s67wFHvq5Wr3zQ85AU7bFD8hs9dtXgiPgWgHN4wktMWJkP/tNbxJaU8cosx7sR3XIrqrEeexMOYuWKYxLSw1r0fNZkJ9b2jgz/mRbw1MRaaB0pTSqEsSFPDLDiyh5ilrsIC5rG18cFc9W3OCCShJbKvypzlDODcLf4+hE0By2YW2U=
0bdb7802-42a4-42d4-9cbf-735b1e773b42	7e5bc1e5-3e23-43cd-9cdc-e4b50cf5b87d	privateKey	MIIEowIBAAKCAQEAiJgDKDgS8++xdLpfLxFtMb5kbRVMaI7IPuglPJGnE+sJEIyklHl0qLYpENTUG4HIyAXztjNprs09G/tf9xLPFmDAqyxDJAx8k58Zc8OR2beo/Jji3ph6KINjyyj/45Ur0OcKZ2Z/I10TzgxINq5ojQvCGJjho+OjY8A/m8E5M3PdZqYkFf6Tpl/qViRrcrUw336/RJTAD/pVce53Z7N4uzsF6VYwkYHoorcL0r/3bYMmzXYhuazl/mihSnV+7qr2gAUdf9J5yt+UwpIYrCFlJwcEWeZh2hDPFjJgvVSU+ao0SXoAR55AXx5xa/4x2UXgTGJyZ+eiNTIJvoPVesUujQIDAQABAoIBAAQLSXSkYbNFMnd77nDXTuinyWi4C7YWHB74rTmOL73Vj0QlKy5A1k+0bPd+8EoMMqScFdYcJDyKU7fYs8Ook+cGtaLxFt/MsCzdYK8zvXAOZvtrj16lxwrHW79abGZm4TrjIZoOx87aj56McIrl6QSGskLGK/q336YxZ/C1l3r1dSgEXftSUQOK9fMsFZ71x3Ke1IkHJrjUNSALPwJCGDwpIc8Wam5/edAKWXhGHY0tJ/kpt23AmAD8IgScu/hkpt9e7rgblVY+Oau+UZrMMNU939xFSEeO0u21dqywS9ddvZrzVAu6sHsOY4tGywaL0RP2wSKEmfvx81Wm37Y2geECgYEAvauLiMhE4GRW1ydMB1OEJTmSMzzv9YWllOI61hCAO5hRFbDpd/TTofbhKiCjX4vFH0eLrF0s+usoUab+FhPtQA1h6Mv2XE9VuX/que9fKpSvnb7bVmhgwS5FS4YURxPw7LxOZQUjVpMKU/drYws2zBMSnhfycTwIzEo1nIt1OUkCgYEAuFy+mncR69VHjDHgEhh/fmE8kVN12tvrvLO3GPvuQlYOfRlj213Y8Dqc5+cHX+cDrAFcasnfKhB2Z413Pql9pQd8tm82kI3CbKh3QWNgg0yhOkGHFHsV44c1jZwCnsZViiHIep6xxV9WIsbmreh3iLVal1JpURf0bcBcd65TryUCgYEAjo6jH7m22xlPlAL7R/5jsj7lPhGtIdLDs3WeV0qrtx8ywqTntbuUXYXbkvhZEvVQwcPanUCjEC0zbrue+iUcCyqDzp+Oma8fdX9Jg1sBIlYC8QOEhBuLrWcDulIaZ5n7WVPncFI+T1HRT28FjbneA+DJ+31wQd+nlTSpuvGut9ECgYBa43YgBnVyU1oLdoclxKgN8PgAGSov9F2aUOsCSSkj0PMhn0PIYNLTU8II3a+YCvaXdLBQASegwC7vTCGuZbaIhlFoSxmWWByynrb0KH7rG/scEjP619dprT2si24LQnHnQFJqiRPQ3vhC+tW8hK9xWR7JHRrInMum07+CTRH6dQKBgE1174ETsMTrqc1h1ynLcaC9vRWWsxAWJvYUfH6kYChYjngWXGS29UXw7ItR+64T+7AeqVvlLGbZFgoVJOouFuR3135K/IiNPyCCrVW1jcer96ZBfEY3g9Vf1rOElD4A9PXMBgA7GbkM3nMLoczp2AKpLvuhQPQ4JsxPppj0PEdh
f584bb83-4835-400c-afab-09fddddda678	7e5bc1e5-3e23-43cd-9cdc-e4b50cf5b87d	priority	100
048c80f4-0967-46d3-a1f9-4a4425d19913	79e83cde-2575-4ba4-9f4d-db1be79b2185	secret	H7FCdn1_VN6Lok5GZK3XW8xA9O5GNJav9r2p3QIyQZHA8PmWyRDWrTZZEhllexVhz2sYYNhEmpuSGOQjqSzLESighczNSmOIaZHwXXOht1IH7x6tm9krxz44rrbsXW4WXB2Nt5lwGiQWdE2Eph2YVo_GYTtAwrWawUDyeHOK5HQ
44d119b3-bb98-4097-bd1c-ce5357d91592	79e83cde-2575-4ba4-9f4d-db1be79b2185	algorithm	HS512
67c08593-42a3-4d02-b1e6-1f26f125216d	79e83cde-2575-4ba4-9f4d-db1be79b2185	kid	88f4077f-720f-4093-920c-ed666af957d3
3a62f308-07ae-4cf4-bddb-789a52d84c4a	79e83cde-2575-4ba4-9f4d-db1be79b2185	priority	100
2e1cb52a-9cdc-415c-9e66-3e2603755384	e61e3278-afcc-4369-bc01-fea004558bf5	secret	DXZXWgOmofB7a8ZTBv5ayg
c908179d-9373-4228-9c8a-b9c2ed028215	e61e3278-afcc-4369-bc01-fea004558bf5	priority	100
e6ebb462-535c-40a6-a617-6db48e64c97f	e61e3278-afcc-4369-bc01-fea004558bf5	kid	45b77bb1-b186-4cd4-a706-7357079a3076
7e9d925c-3ccd-4b46-9b26-c3860bb524c5	d8e3815c-d7b2-47b1-8dc3-841f5277bac0	certificate	MIICnzCCAYcCBgGU7Z+2qDANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhteS1yZWFsbTAeFw0yNTAyMTAwMjA5MTRaFw0zNTAyMTAwMjEwNTRaMBMxETAPBgNVBAMMCG15LXJlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjppt6IxpPKLkKQwCjGyzxmLhPslkDZU20wHufaJw18h+JTw9wseWVYV8VqW5kIbZ+9cqLGkt99V7rhWRJslEHxOOXKsluXwbzZ7FKANb05j5vF9+wJq4GThx3ehQNbDC1muw5TQlI7uQsTE0l92V2N68Ef37uoESIwNrE/Vq1nx9gP3PLktF0j/YC7nnyA0aF4kGOcbn5iR80Ppt2/bi8yGL5fmmWF2YzJYK/ezJbvLniJrPWQEs0CG+rZpQh6jKIpo/xVmammq6roHk11VoH3LIM0yudfeRuZcYewxo5hjbMg+9tg4k6GYOY70L+NhALL42Alyo7LggaoZqh0mEjQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQACMHk9DnnsZOo3Dr1/2p5eagiwSvADus+BPI9gsqca7xTZboTszNrMlXJIO8Bg83Prz3Tkqi9sKQsSxUq2+No5azZwdFqhK93kU/Xw/iBED5xlvNqhwCAawv5C01noTQfZ3dT3Fdhll1MwFaRJuaaZrvkXmdJ1Bdwd56NRV5mLoDI9hh6p0mrhkMWfMxcfJjpPx6DDfbY5x1dhVKxVufWa7HB45Uje1gdwGIAvvP87t9LrfYsdpHeoBanJ5/51nAZcXxGOwvYCH75tzwt+owau1VOV8PbD+ycyDufiJkoOemQx5BJd4U1t7YD3R/TJKcNAirq+l9xzXcOrpiHOc2Br
03262c85-c539-4c05-9a31-70df87930ca5	d8e3815c-d7b2-47b1-8dc3-841f5277bac0	keyUse	ENC
b06475a2-3e9b-4bd0-8454-1a629a9b56c8	d8e3815c-d7b2-47b1-8dc3-841f5277bac0	privateKey	MIIEpAIBAAKCAQEAjppt6IxpPKLkKQwCjGyzxmLhPslkDZU20wHufaJw18h+JTw9wseWVYV8VqW5kIbZ+9cqLGkt99V7rhWRJslEHxOOXKsluXwbzZ7FKANb05j5vF9+wJq4GThx3ehQNbDC1muw5TQlI7uQsTE0l92V2N68Ef37uoESIwNrE/Vq1nx9gP3PLktF0j/YC7nnyA0aF4kGOcbn5iR80Ppt2/bi8yGL5fmmWF2YzJYK/ezJbvLniJrPWQEs0CG+rZpQh6jKIpo/xVmammq6roHk11VoH3LIM0yudfeRuZcYewxo5hjbMg+9tg4k6GYOY70L+NhALL42Alyo7LggaoZqh0mEjQIDAQABAoIBACsaUHhG4JQ8ZBxoDekl/hzLzGtu8fgNDvoujkiZLeR7LG3SzJQwQadt5oxGIVWm/QJbIds0m3lapLyUtj/z+8ws3A30iT2MXtcC03LpuPq3NV0TvDs5SMYOwpQhYQUpfWrUOC6/WS54xh5Y0h3JEz7u7AfALjNMShAdO2NX/cgAe0xG9iGpsSYcOq2MEzd89skZ2brHGWPVkrBt5IXI6rzLo7chAka8rdjVdlk46acTFY+SpX0LK3n2jSEtT9bGtPlx9Xd4Q2njtzc5UpQM+VQEiZIa4QU7fkVaCHjwY0zKchM5W0MR65HIpMt1jwxTPErJZ25AZvyx15a2U9yVTj0CgYEAx81DZhE/HyFZnEDmQ/uiMzmzRCeCZf21kOe5ZsUJUXXmJkxd+WtUW6A7/yr6t+SJmYBECB8FtOYO+FtzPCSw7UAuCPtTBi/JcEg8RgSrySL0gZCuT2TvEoARNeFt49jXN++/VXLQn/u/jLUNaGEkVQ65jb/g2Q1vi41Pp5RsXwsCgYEAtraUtSwyLJzMbaC9A5RhGjKQzQkEQ1IYe6Howujm6z786yC2jQwQ1+LDBVCOzivKGx5lhecR73420SDetVIfN8Xc4auEWhqlNH698KLgqDAZJH8FkC/f79DGViYSnuIlrFXmgaoiW97bvltCx00uxfzs3Mjw6HOHv1yxDGTEyccCgYEAjRDYeDTPCyyhtxd/PBpqr54aepEmmNnjGnbwyKVu6cvC/eFHLDViLvrXwVXYBIPfvrf30IAOqGURxrnSh3EkVa3NktvXB3Qv1g26OHlNzEnYta2v1DBgNwCiphcOXiMX+M9VmH/i2kGFQVQHLl3/p+ooifMiTj0VN0NDLP828HcCgYArj8JKo5veyQ9wP7dwyAqSnWWqjLDIgCU4LLT6615Kzfys7mK3pB3L6tOGS9uQSh5ocsnPr/S1vcjB+W0/m7G3sWPlJehrNxkWN/V/DsYzMyx7aBFifBeO7J6s4WzlFpPWz7AiT/bbInoPm2CDdeJl79RlGz9cnFbMCARqKQhF9wKBgQC3qx+pTdtTJYA2zzIsJ3VMmEGC504Bp/R8jHOBNAt1IUZkOaYTPU5Cu0HPe5BvPydnbEHAUmpR63/49PoJjb8lGmKuj1CZjIkvb0hkusaegGClD2zc2Jqh0f/beGoZR3eIy9n8psTVSRnAdWrzKiW5FIVZRKIfxa2JnthzyL9hxw==
664d0bb5-9f67-46a9-809e-30789608e884	d8e3815c-d7b2-47b1-8dc3-841f5277bac0	priority	100
9aad2910-578f-4444-8243-c950e9eb5eb9	d8e3815c-d7b2-47b1-8dc3-841f5277bac0	algorithm	RSA-OAEP
2a786721-16f2-47ba-a4dd-bc19e7ab5003	b6a9dd6f-7de2-4d68-a03c-6e27b8f83843	privateKey	MIIEpQIBAAKCAQEAsSV6Vdx/bJGVaVfoY73eHEBojPfcV1fJxpN/TM4oG58QV/fV3nrj/rEUg0cbkkwRzdPibof9lP23s9P9ZL4pYSVENRaguDKnknb4qK6LMUkXkJOvcl1vHKHbjEkXiUnQMkn8YCPc5ZEcfYEb0WppaL8Pzv24bJNgyLNYemTLbZBlVOjHhI4yunC0+XXohfHHer9g3G19jufxdw6Fa392QKACkBufebPZ9TjQRboje2Z1Nirz1GwauAaLbf3bDxC80qKEwTx/HkvhnGs+K8zCH2TPVuXbO7/sOUN6eQlBj6PETMQ3T4e0G3KF6mpZzhetrFeKJcnIUgwVy9Fnbr+yNQIDAQABAoIBABX1Xxd/FGWFG1f6T2JzwfFPE5arz8qc5XRhyrUe1e5slnZNEJv6MEJdOX13ZkXJe6h/tBD+9vJNzAR0yfN/tfnmiHCrPCNxFgAMEtE4B6WFma/wep5K0i/iqWgXlF0OgwoEzU2ujF6BkR5Gj4fzMJtNGbzPCxocX7IpNxW+4k+TklIqTJm2JsoaTxEPcR4IQH6T0ilagwidUxWyAi+/6Qw7dtLgXVqQvohXKLgGcsVjFpBuO8wwp4ruHtqlsJQ/5pmWZomZNLDhbi1KhzmW7AA8BxZpdZi41BPh4U1YI7AIwyYbsNpLLRyhuQaPvxgUCNRTs0G7mT5KNlKRVsNH5ukCgYEA6a6DWa4iXrGG5NQncRKKqaLpSP0dXLn7uUqXnrHX7cqDQZ9ei91xXpURELLiaXEd1hrf/SYBexQO+fXeRMftc+wIzfW2S/sm3Rn2O5adNYVq1ZEExftYudylQufSE5AXPneuwx6lz1xg7MncN5X8GdmF42bTYN/d1M9ImoU54AkCgYEAwhCvKPdyP7iNojBV6+4JuG7pyffC4nzxtktL6fyLbCCKJc8l7WVQgoKx4bYtwSbEf7QqoeYz/UDzE52PFEJRKfSxxRoLuZtANgxXc2jh4jtb8iYZ7m4nX9fvkZlxMXmTLpIBrFC1iukAWxf5qE18JISIcfDgA+K6p4kDHyf5s80CgYEAmig4GpdXsSRoGtkiU+OpehMw1qe0ERHYT/o3X8du7T3lrQrXsmkZew3Xvi5kUq7+wdnk3fmOjIVFA/0A7lr9+LVDcaug4SsEDmQsHk9T0pT7T3xlq74OYD6A/0wzOBicXOdTcQDs3YjRoCPilQDq2Jq5SrTwyT2l99fuy5EMBxECgYEArUoqrwEuotnQl0hkIRXg1jEsUG4ONyJs0GQyOJGLihUQZyyvaGm016WO48dC2hwdEQ+3lfQy7m1F4XkrH2MMiNN4vlFAsQ+B6gFhQawhMFvjAbqmIzN3s2zl/vSukAhItigomE9FnPHsoGsrQu9V8GHsWRpHXxDhreJ5yCNxJO0CgYEAvWG2hNxi/htLvy1g5NLBgqrgLUBPRd5cogqeeoJi2we6lbglgWpEN/sfNNzU6sUJvv8ErpctndKHp1tBcIQVM+Pc0cXLb3CWHBKlIBzcMsZ/P9ELgPJV9TzTxRW5QY6mP/KGx6CpYSUsVLJQjC5ggiNZNy7Py4YfsiELt585m1g=
b9eea204-ef71-45c5-ae84-e9c38fe4aa8a	b6a9dd6f-7de2-4d68-a03c-6e27b8f83843	priority	100
3c5b0d3f-dab7-434b-a14b-0a28c9588581	b6a9dd6f-7de2-4d68-a03c-6e27b8f83843	keyUse	SIG
5a63458f-8e8d-41ba-9455-45502d01fb5c	b6a9dd6f-7de2-4d68-a03c-6e27b8f83843	certificate	MIICnzCCAYcCBgGU7Z+2XDANBgkqhkiG9w0BAQsFADATMREwDwYDVQQDDAhteS1yZWFsbTAeFw0yNTAyMTAwMjA5MTRaFw0zNTAyMTAwMjEwNTRaMBMxETAPBgNVBAMMCG15LXJlYWxtMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsSV6Vdx/bJGVaVfoY73eHEBojPfcV1fJxpN/TM4oG58QV/fV3nrj/rEUg0cbkkwRzdPibof9lP23s9P9ZL4pYSVENRaguDKnknb4qK6LMUkXkJOvcl1vHKHbjEkXiUnQMkn8YCPc5ZEcfYEb0WppaL8Pzv24bJNgyLNYemTLbZBlVOjHhI4yunC0+XXohfHHer9g3G19jufxdw6Fa392QKACkBufebPZ9TjQRboje2Z1Nirz1GwauAaLbf3bDxC80qKEwTx/HkvhnGs+K8zCH2TPVuXbO7/sOUN6eQlBj6PETMQ3T4e0G3KF6mpZzhetrFeKJcnIUgwVy9Fnbr+yNQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQAeomW9O4mS+3/sWhojjwd6ifOwdun/nQLGd0KNcF9AXeYSwC4uqG2TLoPXUenndQDOS1wZlIKS3rXDcKLcluboq751dPNikEvOkY11CordNFSFxWQX1tTA6qgbrb777kwBTEkltAyjsu29D/tLgTaqFkos8W64Jm5RbVctggMFq68/GYlxOThyLbLfX9UYqWMXtNwxdPxVIozvRzowwxFSNbXmM5wesdUb8JJItF4ZbY0MjdVkr8295TO1VdsoxnCiI9Sn0TTT+Ns9bm+H29gH+m8fA3WaKS510kvbfH4OnRrV5KfiTAujzzgItv+Pow3S9X5aRuMjYOPdtWDOFjWR
e3011614-87e7-4117-a3a0-a41ce217f948	1668b931-5c04-4e06-b7c8-7c702188a794	kid	cd48a461-d0d9-4764-b4ca-524d66f256d8
d6733cbc-dd4d-4dee-bea8-8f3d2a42a75d	1668b931-5c04-4e06-b7c8-7c702188a794	priority	100
db8f9076-d3d1-46a3-bcea-4a1138ad5614	1668b931-5c04-4e06-b7c8-7c702188a794	algorithm	HS512
bda477f4-312f-4bf5-8bce-48607d32826b	1668b931-5c04-4e06-b7c8-7c702188a794	secret	bLgEh_paFNMBU2xz2wIryzFyl6ItEioukS3c_VhGxaD2hg8974R5ddf2gfGS9JaJ971Fj58P-8Yo-5RL_d7yU-D438SYanjVbLpYGL_bAiI5gzfvhTzccgMJqv86hFTFbIA_bSt5Vhzfwttni1olrm7aBtU2k7LZtB8sCzGbweY
c57b5c35-233f-4145-86c6-a59152035faf	f71ad7a8-08d1-4c9c-8d14-10d47becd126	kid	2d6bedf6-4224-44c4-9933-a8bd8860c485
5f69e060-b097-4e8f-b217-3bc47c433a4b	f71ad7a8-08d1-4c9c-8d14-10d47becd126	priority	100
d92fe04a-48bc-4c22-9b26-e6e4deb248b1	f71ad7a8-08d1-4c9c-8d14-10d47becd126	secret	s7Y2xQdmBEeGJJCU7_9kbg
ae2e0090-d6eb-4cbf-a301-0407d967a209	b508f35c-daae-4505-a933-763df3ff90be	max-clients	200
d116d63b-ffca-4d0f-98e5-c7efb4832285	8aa55f5a-bc69-436d-ab2b-847fe19956be	allowed-protocol-mapper-types	saml-user-attribute-mapper
3a9ede7b-6f3e-48d7-af10-c9dac2338ff5	8aa55f5a-bc69-436d-ab2b-847fe19956be	allowed-protocol-mapper-types	saml-user-property-mapper
45494c46-02d3-4c6a-aeed-35429df1d6ed	8aa55f5a-bc69-436d-ab2b-847fe19956be	allowed-protocol-mapper-types	oidc-address-mapper
e5a927a3-7516-43d6-90a2-16d810ea7f2f	8aa55f5a-bc69-436d-ab2b-847fe19956be	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
06f94a16-71f1-46fc-a1f0-117faef68a0a	8aa55f5a-bc69-436d-ab2b-847fe19956be	allowed-protocol-mapper-types	oidc-full-name-mapper
406f1dfb-1793-48d1-be6d-cb0f552d8922	8aa55f5a-bc69-436d-ab2b-847fe19956be	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
96843d9b-dd3b-4165-8282-08bd3a8ffcff	8aa55f5a-bc69-436d-ab2b-847fe19956be	allowed-protocol-mapper-types	saml-role-list-mapper
5af34e7d-9b45-477b-886a-aa1aa7183831	8aa55f5a-bc69-436d-ab2b-847fe19956be	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
7d7d63a2-36f7-4a17-b55f-90668f8d7a7d	e2125110-869f-4886-96ce-f80670db0336	allow-default-scopes	true
4699fec6-c61c-4bc1-825b-25aab871c06e	dbf342a6-3709-4776-b9c9-52f5356e9223	allow-default-scopes	true
c3a3c541-89d5-4a44-bf00-e7866e122ba6	994b13d7-a7d8-4e93-bf03-20e8d2971df8	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
50f73629-1766-46b8-b621-1ecabd9a8104	994b13d7-a7d8-4e93-bf03-20e8d2971df8	allowed-protocol-mapper-types	oidc-address-mapper
415339af-bb33-47a8-982b-33ba7195ad93	994b13d7-a7d8-4e93-bf03-20e8d2971df8	allowed-protocol-mapper-types	saml-user-property-mapper
71f87ab1-916e-44a8-8cb0-9311d02ac8ec	994b13d7-a7d8-4e93-bf03-20e8d2971df8	allowed-protocol-mapper-types	oidc-full-name-mapper
b651a9b2-bf9f-405d-869f-e068ab40229d	994b13d7-a7d8-4e93-bf03-20e8d2971df8	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
45a4613b-5151-4290-8b7b-8a8c69d7e36a	994b13d7-a7d8-4e93-bf03-20e8d2971df8	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e8bd8e69-f343-4e41-96f0-ce84d3f4d163	994b13d7-a7d8-4e93-bf03-20e8d2971df8	allowed-protocol-mapper-types	saml-user-attribute-mapper
edde0f3a-a71e-48e7-a633-5924e4e3b941	994b13d7-a7d8-4e93-bf03-20e8d2971df8	allowed-protocol-mapper-types	saml-role-list-mapper
2d9418c9-a5ad-4912-937b-eb98268f9a83	ad44d1a6-c47d-4254-a75c-8a4ffccfe5b7	client-uris-must-match	true
228d611f-7362-48a3-8b0c-04f69b20a6ed	ad44d1a6-c47d-4254-a75c-8a4ffccfe5b7	host-sending-registration-request-must-match	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
6474bb43-8c60-47da-b276-f151c38601ee	ce8052e4-78b2-4c72-af20-33381e938bbf
6474bb43-8c60-47da-b276-f151c38601ee	58b9ff0e-bb67-4e82-af49-edb4c5eada55
6474bb43-8c60-47da-b276-f151c38601ee	fcc9d495-687d-4f09-b26e-db03ad3b17c9
6474bb43-8c60-47da-b276-f151c38601ee	def41d97-1c01-46c2-bf28-3e231299d3f1
6474bb43-8c60-47da-b276-f151c38601ee	a3d8b5ed-904d-469b-bdee-d5a19e614991
6474bb43-8c60-47da-b276-f151c38601ee	030467d1-0cd6-476f-be6c-40bd9eacb9dc
6474bb43-8c60-47da-b276-f151c38601ee	fb28f848-5d23-4fa2-9d42-d260be84e211
6474bb43-8c60-47da-b276-f151c38601ee	6aa2d3dc-5a10-4954-84bb-af2674909799
6474bb43-8c60-47da-b276-f151c38601ee	feeb14e8-c654-432f-8095-71b59c907740
6474bb43-8c60-47da-b276-f151c38601ee	a7ce70e8-b9f0-4133-aadc-8b9964a06e01
6474bb43-8c60-47da-b276-f151c38601ee	9d441d0d-c92c-47e7-91f2-ffbe0f4085f1
6474bb43-8c60-47da-b276-f151c38601ee	c3bbd7a5-dc81-4b8d-bbb9-0cc50de9e1ae
6474bb43-8c60-47da-b276-f151c38601ee	0850887f-77e5-4db4-a69e-e2f30e1e36d7
6474bb43-8c60-47da-b276-f151c38601ee	6fcf4b9c-0aa3-4fe1-aee6-afa0dbb1786f
6474bb43-8c60-47da-b276-f151c38601ee	4d205d3f-b0f2-4ab4-a2a6-42ba36452b93
6474bb43-8c60-47da-b276-f151c38601ee	56a79f2a-99c1-4d68-b197-df012a0b6a73
6474bb43-8c60-47da-b276-f151c38601ee	1da8e042-0193-48be-b52f-163a326994fe
6474bb43-8c60-47da-b276-f151c38601ee	c5ecbd31-e211-4d71-89cd-ca82f0f9d742
806a48f1-c68b-435d-9964-93f511494602	5f97465a-70ff-4a91-96b3-840b9da459f9
a3d8b5ed-904d-469b-bdee-d5a19e614991	56a79f2a-99c1-4d68-b197-df012a0b6a73
def41d97-1c01-46c2-bf28-3e231299d3f1	c5ecbd31-e211-4d71-89cd-ca82f0f9d742
def41d97-1c01-46c2-bf28-3e231299d3f1	4d205d3f-b0f2-4ab4-a2a6-42ba36452b93
806a48f1-c68b-435d-9964-93f511494602	0bbf5b92-4383-478e-8868-76f84382a131
0bbf5b92-4383-478e-8868-76f84382a131	75b257b0-424a-458a-9579-7aa1d85b559c
d8f82b5d-2cc3-4ea9-82b7-ffd9c0602c8c	f280cc4b-c5dc-4345-b610-3f15106e3b23
6474bb43-8c60-47da-b276-f151c38601ee	927dda8f-5d3e-4448-9ce9-9f6e5c9caa1e
806a48f1-c68b-435d-9964-93f511494602	d3012426-111a-41dd-8adf-e3a626a1d0cd
806a48f1-c68b-435d-9964-93f511494602	e6e06f94-9d37-49ac-a751-ddf6646676eb
6474bb43-8c60-47da-b276-f151c38601ee	c3df3699-0012-4933-b60c-136cd0d0840d
6474bb43-8c60-47da-b276-f151c38601ee	ade28bef-80ce-4a08-88a0-d778c2056e22
6474bb43-8c60-47da-b276-f151c38601ee	c23ce049-d7d3-43fb-9b77-41c6ba29c3f0
6474bb43-8c60-47da-b276-f151c38601ee	5c1c0445-f1df-46ff-b0e1-180573d624e9
6474bb43-8c60-47da-b276-f151c38601ee	ee132b0b-39a7-4001-9513-f7732dcb4eff
6474bb43-8c60-47da-b276-f151c38601ee	4eb197b6-8df7-4df3-b583-807a9e543732
6474bb43-8c60-47da-b276-f151c38601ee	ed2eb6c2-1eb2-4e8d-b580-0fca3c4e590a
6474bb43-8c60-47da-b276-f151c38601ee	b46a873c-f977-4f0d-83bc-ed940b1c618e
6474bb43-8c60-47da-b276-f151c38601ee	e13b0db9-ace8-4dc8-ad70-91f5c9ed3e6f
6474bb43-8c60-47da-b276-f151c38601ee	fad41e3f-060a-4e13-93da-8e39fa40b517
6474bb43-8c60-47da-b276-f151c38601ee	9d14846c-1835-454a-8962-57d6553a67ff
6474bb43-8c60-47da-b276-f151c38601ee	633baba0-690e-4043-aefd-ed2d5f607592
6474bb43-8c60-47da-b276-f151c38601ee	f700978f-fdba-4141-89b2-cdca7d3df137
6474bb43-8c60-47da-b276-f151c38601ee	2209f686-1b6a-42b5-bbdb-2d995b6ca411
6474bb43-8c60-47da-b276-f151c38601ee	395b4813-e12a-4058-8a63-8522f049e0d9
6474bb43-8c60-47da-b276-f151c38601ee	c7dce21e-7b53-45dd-9089-bc33aa4261d2
6474bb43-8c60-47da-b276-f151c38601ee	becd33bb-4f3d-4245-82e3-72c6df3ace4d
5c1c0445-f1df-46ff-b0e1-180573d624e9	395b4813-e12a-4058-8a63-8522f049e0d9
c23ce049-d7d3-43fb-9b77-41c6ba29c3f0	becd33bb-4f3d-4245-82e3-72c6df3ace4d
c23ce049-d7d3-43fb-9b77-41c6ba29c3f0	2209f686-1b6a-42b5-bbdb-2d995b6ca411
42238201-95fe-406a-8759-fdb94b56ec9a	e99e5ac5-eac8-4f57-b1be-54d491232161
42238201-95fe-406a-8759-fdb94b56ec9a	a9d4425a-d85f-442c-9b6d-6cc1dcd26e3b
42238201-95fe-406a-8759-fdb94b56ec9a	b3f0923e-83ee-4c99-b783-6ec065fd6109
42238201-95fe-406a-8759-fdb94b56ec9a	d740b06d-0d18-4b7c-bd97-5d46de1d4562
42238201-95fe-406a-8759-fdb94b56ec9a	8585466b-b276-460b-b6f0-c806b0d01c5b
42238201-95fe-406a-8759-fdb94b56ec9a	16b73b3e-9222-4f2b-a931-ff13848a0380
42238201-95fe-406a-8759-fdb94b56ec9a	308ddbed-c439-49cb-ae43-fb4dadf49353
42238201-95fe-406a-8759-fdb94b56ec9a	b2110a97-ba26-41c0-8b44-a61b985a3a95
42238201-95fe-406a-8759-fdb94b56ec9a	d0424779-192c-42d5-8cee-65d73147fdb0
42238201-95fe-406a-8759-fdb94b56ec9a	a624ab77-e22c-43e2-8da5-26df4ff07e91
42238201-95fe-406a-8759-fdb94b56ec9a	11222d38-4c7f-4ad2-b45a-0f5e6761cf05
42238201-95fe-406a-8759-fdb94b56ec9a	f238f298-8da4-486b-a6cd-67adda0e92c1
42238201-95fe-406a-8759-fdb94b56ec9a	97b1c61d-9bdf-4899-bff2-3460176741b8
42238201-95fe-406a-8759-fdb94b56ec9a	5aaefbe1-bfae-4ba5-baa3-866d4cc3a95c
42238201-95fe-406a-8759-fdb94b56ec9a	7ddd3dcb-3649-4e16-a3e0-eca7d0608213
42238201-95fe-406a-8759-fdb94b56ec9a	7a2c97b9-dec7-4700-b47e-7303e2419f7b
42238201-95fe-406a-8759-fdb94b56ec9a	a335746c-d885-4de3-9cf0-822055914227
b19d7be8-5220-43df-84cb-b87d7262cc8d	8525b770-4ee1-4a99-b701-e90cf6a819cf
b3f0923e-83ee-4c99-b783-6ec065fd6109	a335746c-d885-4de3-9cf0-822055914227
b3f0923e-83ee-4c99-b783-6ec065fd6109	5aaefbe1-bfae-4ba5-baa3-866d4cc3a95c
d740b06d-0d18-4b7c-bd97-5d46de1d4562	7ddd3dcb-3649-4e16-a3e0-eca7d0608213
b19d7be8-5220-43df-84cb-b87d7262cc8d	3d2a6ddd-cf10-4002-8aa4-96571d9cdab6
3d2a6ddd-cf10-4002-8aa4-96571d9cdab6	e238c24c-4a19-419d-8231-b7c44bfefd88
bc9f4113-8abf-4550-b6ef-01231b077a6f	331940af-2d2b-4e41-8e4a-e394df05ef1f
6474bb43-8c60-47da-b276-f151c38601ee	334d0500-17ef-4237-9032-3e3560f7c505
42238201-95fe-406a-8759-fdb94b56ec9a	9fd66f3b-b6d6-4ca3-9ea5-5fada23974bc
b19d7be8-5220-43df-84cb-b87d7262cc8d	e9cfac0d-f3b0-4441-8ad7-fea724371b05
b19d7be8-5220-43df-84cb-b87d7262cc8d	36fd2209-f336-4cb1-8e45-96e1c660af24
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
5efafea8-cc04-4530-99c2-93015d1ad991	\N	password	63dd6689-287a-4742-bdb4-7f72f4776f30	1739149774741	\N	{"value":"esrB6kuI524R2Fv177wQyLRQtVa1VX9azRntRDG2uMQ=","salt":"mc8Q2fsD6MFqauiesG+zYw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
b53174dd-23f8-492c-b12c-d24ef9ed8133	\N	password	6c991c84-e0b6-47d2-9032-b42813e2ab61	1739158800197	My password	{"value":"HKNkrC04A+FqTjp18GVg3zHxQneRGJKpfi56h5tm1pM=","salt":"OR9J/WZ8qlAum7IFDk6kaw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2025-02-10 01:09:24.169754	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	9149763308
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2025-02-10 01:09:24.190042	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	9149763308
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2025-02-10 01:09:24.271106	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	9149763308
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2025-02-10 01:09:24.279206	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	9149763308
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2025-02-10 01:09:24.504007	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	9149763308
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2025-02-10 01:09:24.514357	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	9149763308
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2025-02-10 01:09:24.696094	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	9149763308
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2025-02-10 01:09:24.703596	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	9149763308
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2025-02-10 01:09:24.713439	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	9149763308
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2025-02-10 01:09:24.902272	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	9149763308
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2025-02-10 01:09:25.001006	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	9149763308
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2025-02-10 01:09:25.006516	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	9149763308
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2025-02-10 01:09:25.038146	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	9149763308
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-02-10 01:09:25.070266	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	9149763308
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-02-10 01:09:25.072498	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-02-10 01:09:25.07612	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	9149763308
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2025-02-10 01:09:25.079854	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	9149763308
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2025-02-10 01:09:25.15385	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	9149763308
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2025-02-10 01:09:25.236635	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	9149763308
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2025-02-10 01:09:25.245342	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	9149763308
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2025-02-10 01:09:25.248629	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	9149763308
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2025-02-10 01:09:25.252861	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	9149763308
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2025-02-10 01:09:25.358864	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	9149763308
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2025-02-10 01:09:25.36648	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	9149763308
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2025-02-10 01:09:25.368566	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	9149763308
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2025-02-10 01:09:25.845694	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	9149763308
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2025-02-10 01:09:25.974844	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	9149763308
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2025-02-10 01:09:25.981894	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	9149763308
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2025-02-10 01:09:26.080219	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	9149763308
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2025-02-10 01:09:26.103021	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	9149763308
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2025-02-10 01:09:26.127156	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	9149763308
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2025-02-10 01:09:26.132748	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	9149763308
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-02-10 01:09:26.139372	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-02-10 01:09:26.141893	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	9149763308
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-02-10 01:09:26.187084	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	9149763308
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2025-02-10 01:09:26.193457	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	9149763308
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2025-02-10 01:09:26.199351	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	9149763308
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2025-02-10 01:09:26.202985	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	9149763308
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2025-02-10 01:09:26.206612	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	9149763308
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-02-10 01:09:26.208561	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	9149763308
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-02-10 01:09:26.210935	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	9149763308
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2025-02-10 01:09:26.216619	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	9149763308
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2025-02-10 01:09:28.052313	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	9149763308
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2025-02-10 01:09:28.058911	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	9149763308
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-02-10 01:09:28.065831	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	9149763308
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-02-10 01:09:28.072868	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	9149763308
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-02-10 01:09:28.074482	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	9149763308
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-02-10 01:09:28.251022	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	9149763308
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2025-02-10 01:09:28.256964	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	9149763308
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2025-02-10 01:09:28.314698	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	9149763308
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2025-02-10 01:09:28.758578	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	9149763308
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2025-02-10 01:09:28.762843	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2025-02-10 01:09:28.766341	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	9149763308
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2025-02-10 01:09:28.770902	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	9149763308
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-02-10 01:09:28.778982	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	9149763308
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-02-10 01:09:28.792012	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	9149763308
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-02-10 01:09:28.864792	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	9149763308
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2025-02-10 01:09:29.40232	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	9149763308
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2025-02-10 01:09:29.445777	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	9149763308
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2025-02-10 01:09:29.454934	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	9149763308
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-02-10 01:09:29.465011	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	9149763308
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2025-02-10 01:09:29.472284	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	9149763308
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2025-02-10 01:09:29.476038	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	9149763308
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2025-02-10 01:09:29.480712	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	9149763308
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2025-02-10 01:09:29.484247	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	9149763308
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2025-02-10 01:09:29.537967	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	9149763308
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2025-02-10 01:09:29.582117	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	9149763308
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2025-02-10 01:09:29.587419	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	9149763308
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2025-02-10 01:09:29.637028	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	9149763308
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2025-02-10 01:09:29.643649	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	9149763308
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2025-02-10 01:09:29.649234	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	9149763308
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-02-10 01:09:29.657801	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	9149763308
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-02-10 01:09:29.667495	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	9149763308
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-02-10 01:09:29.669977	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	9149763308
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-02-10 01:09:29.707081	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	9149763308
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2025-02-10 01:09:29.758571	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	9149763308
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-02-10 01:09:29.762756	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	9149763308
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-02-10 01:09:29.764292	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	9149763308
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-02-10 01:09:29.799501	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	9149763308
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2025-02-10 01:09:29.802187	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	9149763308
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-02-10 01:09:29.849648	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	9149763308
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-02-10 01:09:29.851416	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	9149763308
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-02-10 01:09:29.859016	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	9149763308
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-02-10 01:09:29.860858	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	9149763308
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2025-02-10 01:09:29.904729	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	9149763308
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2025-02-10 01:09:29.912299	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	9149763308
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-02-10 01:09:29.927391	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	9149763308
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2025-02-10 01:09:29.940191	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	9149763308
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-02-10 01:09:29.947724	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	9149763308
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-02-10 01:09:29.965261	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	9149763308
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-02-10 01:09:30.009728	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-02-10 01:09:30.023664	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	9149763308
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-02-10 01:09:30.025224	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	9149763308
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-02-10 01:09:30.039029	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	9149763308
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-02-10 01:09:30.040989	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	9149763308
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2025-02-10 01:09:30.049302	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	9149763308
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-02-10 01:09:30.170735	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-02-10 01:09:30.17285	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-02-10 01:09:30.188642	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-02-10 01:09:30.237182	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-02-10 01:09:30.239241	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-02-10 01:09:30.291944	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	9149763308
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2025-02-10 01:09:30.298911	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	9149763308
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2025-02-10 01:09:30.307984	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	9149763308
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2025-02-10 01:09:30.361853	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	9149763308
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2025-02-10 01:09:30.414108	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	9149763308
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2025-02-10 01:09:30.477093	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	9149763308
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2025-02-10 01:09:30.48267	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	9149763308
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-02-10 01:09:30.535121	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	9149763308
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-02-10 01:09:30.537294	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	9149763308
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2025-02-10 01:09:30.549864	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2025-02-10 01:09:30.554965	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	9149763308
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-02-10 01:09:30.607663	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	9149763308
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2025-02-10 01:09:30.610888	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	9149763308
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-02-10 01:09:30.617087	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	9149763308
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2025-02-10 01:09:30.619953	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	9149763308
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-02-10 01:09:30.62889	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	9149763308
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2025-02-10 01:09:30.633377	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	9149763308
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-02-10 01:09:30.799641	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	9149763308
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-02-10 01:09:30.804983	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	9149763308
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-02-10 01:09:30.812336	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2025-02-10 01:09:30.854823	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-02-10 01:09:30.85962	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	9149763308
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-02-10 01:09:30.861517	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2025-02-10 01:09:30.865206	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	9149763308
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:30.8726	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	9149763308
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:30.91434	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:30.996208	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:31.059416	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:31.124603	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:31.190748	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	9149763308
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:31.192938	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:31.258281	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	9149763308
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:31.295746	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	9149763308
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:31.314911	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	9149763308
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:31.318589	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	9149763308
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2025-02-10 01:09:31.424753	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	9149763308
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.438065	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	9149763308
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.4489	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	9149763308
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.498624	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	9149763308
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.505268	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	9149763308
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.514239	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	9149763308
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.558093	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	9149763308
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.669859	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	9149763308
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.727633	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	9149763308
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.792533	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	9149763308
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2025-02-10 01:09:31.796098	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	9149763308
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-02-10 01:09:31.808885	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	9149763308
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-02-10 01:09:31.819281	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	9149763308
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2025-02-10 01:09:31.829876	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	9149763308
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
9810599f-a32f-4d69-893a-d08f7209a282	18eb89a9-b7a8-4518-9dbd-8240931c3d9d	f
9810599f-a32f-4d69-893a-d08f7209a282	7e276f44-70c2-43b4-b7d3-6006d02172d0	t
9810599f-a32f-4d69-893a-d08f7209a282	814b13c0-2255-4349-af70-6aba614d88c5	t
9810599f-a32f-4d69-893a-d08f7209a282	8d7bb5c2-46c3-4c37-b40a-743233979570	t
9810599f-a32f-4d69-893a-d08f7209a282	68ccda09-ea26-483c-aa4f-5306a7a5992c	t
9810599f-a32f-4d69-893a-d08f7209a282	91507df5-a08c-4080-b0f7-124725f50ccc	f
9810599f-a32f-4d69-893a-d08f7209a282	02a40f0f-bdfb-4e90-b0f0-e154f8766787	f
9810599f-a32f-4d69-893a-d08f7209a282	17bae105-a391-475e-b0fb-1acf39f46d58	t
9810599f-a32f-4d69-893a-d08f7209a282	8da2d223-4297-4166-a405-f9c0c2eda3b1	t
9810599f-a32f-4d69-893a-d08f7209a282	12a9978c-7fdd-4e1c-8100-07e091808057	f
9810599f-a32f-4d69-893a-d08f7209a282	7930caf8-10ea-45f1-957e-6a51a69f4b09	t
9810599f-a32f-4d69-893a-d08f7209a282	8588d757-d109-48c3-93b4-63698fb9e81a	t
9810599f-a32f-4d69-893a-d08f7209a282	0b6d4d44-f036-4bda-ada1-972bb59f6e95	f
c46dc488-1d5b-449e-886b-6024480d4e83	18ab70d0-6dde-4668-b396-abd0e0f4f23d	f
c46dc488-1d5b-449e-886b-6024480d4e83	6c28a83f-f09f-494f-9346-671c09f29e3c	t
c46dc488-1d5b-449e-886b-6024480d4e83	c53da4fb-8a5e-47ec-80af-7de31bcb55ab	t
c46dc488-1d5b-449e-886b-6024480d4e83	7a0f36cf-7639-434d-96ee-516ee53a3898	t
c46dc488-1d5b-449e-886b-6024480d4e83	a8e5898b-5cb9-4a82-8383-578023a151b4	t
c46dc488-1d5b-449e-886b-6024480d4e83	80c84187-d24a-4e47-8a85-e3142c0a3648	f
c46dc488-1d5b-449e-886b-6024480d4e83	f90b816a-f494-4892-b766-df4e9af30098	f
c46dc488-1d5b-449e-886b-6024480d4e83	dd5e2866-7793-4660-b5b3-1249286e8373	t
c46dc488-1d5b-449e-886b-6024480d4e83	fdeed3b7-ccf7-4403-a037-5c1be5abc614	t
c46dc488-1d5b-449e-886b-6024480d4e83	5d43cdea-1f20-4887-950b-cf4417eca5da	f
c46dc488-1d5b-449e-886b-6024480d4e83	19a2c512-9ff9-473c-8735-097b1802a7f1	t
c46dc488-1d5b-449e-886b-6024480d4e83	479b9395-bfcd-492f-b8fe-4c24f9175226	t
c46dc488-1d5b-449e-886b-6024480d4e83	aea5b7f9-a949-46d6-8478-26ee49ad6edc	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
806a48f1-c68b-435d-9964-93f511494602	9810599f-a32f-4d69-893a-d08f7209a282	f	${role_default-roles}	default-roles-master	9810599f-a32f-4d69-893a-d08f7209a282	\N	\N
6474bb43-8c60-47da-b276-f151c38601ee	9810599f-a32f-4d69-893a-d08f7209a282	f	${role_admin}	admin	9810599f-a32f-4d69-893a-d08f7209a282	\N	\N
ce8052e4-78b2-4c72-af20-33381e938bbf	9810599f-a32f-4d69-893a-d08f7209a282	f	${role_create-realm}	create-realm	9810599f-a32f-4d69-893a-d08f7209a282	\N	\N
58b9ff0e-bb67-4e82-af49-edb4c5eada55	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_create-client}	create-client	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
fcc9d495-687d-4f09-b26e-db03ad3b17c9	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_view-realm}	view-realm	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
def41d97-1c01-46c2-bf28-3e231299d3f1	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_view-users}	view-users	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
a3d8b5ed-904d-469b-bdee-d5a19e614991	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_view-clients}	view-clients	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
030467d1-0cd6-476f-be6c-40bd9eacb9dc	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_view-events}	view-events	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
fb28f848-5d23-4fa2-9d42-d260be84e211	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_view-identity-providers}	view-identity-providers	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
6aa2d3dc-5a10-4954-84bb-af2674909799	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_view-authorization}	view-authorization	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
feeb14e8-c654-432f-8095-71b59c907740	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_manage-realm}	manage-realm	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
a7ce70e8-b9f0-4133-aadc-8b9964a06e01	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_manage-users}	manage-users	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
9d441d0d-c92c-47e7-91f2-ffbe0f4085f1	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_manage-clients}	manage-clients	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
c3bbd7a5-dc81-4b8d-bbb9-0cc50de9e1ae	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_manage-events}	manage-events	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
0850887f-77e5-4db4-a69e-e2f30e1e36d7	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_manage-identity-providers}	manage-identity-providers	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
6fcf4b9c-0aa3-4fe1-aee6-afa0dbb1786f	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_manage-authorization}	manage-authorization	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
4d205d3f-b0f2-4ab4-a2a6-42ba36452b93	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_query-users}	query-users	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
56a79f2a-99c1-4d68-b197-df012a0b6a73	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_query-clients}	query-clients	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
1da8e042-0193-48be-b52f-163a326994fe	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_query-realms}	query-realms	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
c5ecbd31-e211-4d71-89cd-ca82f0f9d742	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_query-groups}	query-groups	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
5f97465a-70ff-4a91-96b3-840b9da459f9	3c64e277-a482-44d8-a8cf-0d4122b11488	t	${role_view-profile}	view-profile	9810599f-a32f-4d69-893a-d08f7209a282	3c64e277-a482-44d8-a8cf-0d4122b11488	\N
0bbf5b92-4383-478e-8868-76f84382a131	3c64e277-a482-44d8-a8cf-0d4122b11488	t	${role_manage-account}	manage-account	9810599f-a32f-4d69-893a-d08f7209a282	3c64e277-a482-44d8-a8cf-0d4122b11488	\N
75b257b0-424a-458a-9579-7aa1d85b559c	3c64e277-a482-44d8-a8cf-0d4122b11488	t	${role_manage-account-links}	manage-account-links	9810599f-a32f-4d69-893a-d08f7209a282	3c64e277-a482-44d8-a8cf-0d4122b11488	\N
49f4cf1a-08e5-4869-9970-34a33679b28b	3c64e277-a482-44d8-a8cf-0d4122b11488	t	${role_view-applications}	view-applications	9810599f-a32f-4d69-893a-d08f7209a282	3c64e277-a482-44d8-a8cf-0d4122b11488	\N
f280cc4b-c5dc-4345-b610-3f15106e3b23	3c64e277-a482-44d8-a8cf-0d4122b11488	t	${role_view-consent}	view-consent	9810599f-a32f-4d69-893a-d08f7209a282	3c64e277-a482-44d8-a8cf-0d4122b11488	\N
d8f82b5d-2cc3-4ea9-82b7-ffd9c0602c8c	3c64e277-a482-44d8-a8cf-0d4122b11488	t	${role_manage-consent}	manage-consent	9810599f-a32f-4d69-893a-d08f7209a282	3c64e277-a482-44d8-a8cf-0d4122b11488	\N
a05a2481-7819-49ac-a97b-02c3b1488b00	3c64e277-a482-44d8-a8cf-0d4122b11488	t	${role_view-groups}	view-groups	9810599f-a32f-4d69-893a-d08f7209a282	3c64e277-a482-44d8-a8cf-0d4122b11488	\N
6b6fa750-7e28-4599-a7d8-7818a3095dd8	3c64e277-a482-44d8-a8cf-0d4122b11488	t	${role_delete-account}	delete-account	9810599f-a32f-4d69-893a-d08f7209a282	3c64e277-a482-44d8-a8cf-0d4122b11488	\N
fd7ff8dd-054d-4ef8-9499-cac4182036d0	e396082f-9a9c-41ab-8f49-8f4534bc785c	t	${role_read-token}	read-token	9810599f-a32f-4d69-893a-d08f7209a282	e396082f-9a9c-41ab-8f49-8f4534bc785c	\N
927dda8f-5d3e-4448-9ce9-9f6e5c9caa1e	e781c0bf-0ec5-4947-b7c3-9112207b95ac	t	${role_impersonation}	impersonation	9810599f-a32f-4d69-893a-d08f7209a282	e781c0bf-0ec5-4947-b7c3-9112207b95ac	\N
d3012426-111a-41dd-8adf-e3a626a1d0cd	9810599f-a32f-4d69-893a-d08f7209a282	f	${role_offline-access}	offline_access	9810599f-a32f-4d69-893a-d08f7209a282	\N	\N
e6e06f94-9d37-49ac-a751-ddf6646676eb	9810599f-a32f-4d69-893a-d08f7209a282	f	${role_uma_authorization}	uma_authorization	9810599f-a32f-4d69-893a-d08f7209a282	\N	\N
b19d7be8-5220-43df-84cb-b87d7262cc8d	c46dc488-1d5b-449e-886b-6024480d4e83	f	${role_default-roles}	default-roles-my-realm	c46dc488-1d5b-449e-886b-6024480d4e83	\N	\N
c3df3699-0012-4933-b60c-136cd0d0840d	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_create-client}	create-client	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
ade28bef-80ce-4a08-88a0-d778c2056e22	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_view-realm}	view-realm	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
c23ce049-d7d3-43fb-9b77-41c6ba29c3f0	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_view-users}	view-users	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
5c1c0445-f1df-46ff-b0e1-180573d624e9	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_view-clients}	view-clients	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
ee132b0b-39a7-4001-9513-f7732dcb4eff	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_view-events}	view-events	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
4eb197b6-8df7-4df3-b583-807a9e543732	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_view-identity-providers}	view-identity-providers	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
ed2eb6c2-1eb2-4e8d-b580-0fca3c4e590a	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_view-authorization}	view-authorization	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
b46a873c-f977-4f0d-83bc-ed940b1c618e	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_manage-realm}	manage-realm	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
e13b0db9-ace8-4dc8-ad70-91f5c9ed3e6f	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_manage-users}	manage-users	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
fad41e3f-060a-4e13-93da-8e39fa40b517	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_manage-clients}	manage-clients	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
9d14846c-1835-454a-8962-57d6553a67ff	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_manage-events}	manage-events	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
633baba0-690e-4043-aefd-ed2d5f607592	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_manage-identity-providers}	manage-identity-providers	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
f700978f-fdba-4141-89b2-cdca7d3df137	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_manage-authorization}	manage-authorization	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
2209f686-1b6a-42b5-bbdb-2d995b6ca411	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_query-users}	query-users	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
395b4813-e12a-4058-8a63-8522f049e0d9	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_query-clients}	query-clients	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
c7dce21e-7b53-45dd-9089-bc33aa4261d2	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_query-realms}	query-realms	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
becd33bb-4f3d-4245-82e3-72c6df3ace4d	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_query-groups}	query-groups	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
42238201-95fe-406a-8759-fdb94b56ec9a	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_realm-admin}	realm-admin	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
e99e5ac5-eac8-4f57-b1be-54d491232161	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_create-client}	create-client	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
a9d4425a-d85f-442c-9b6d-6cc1dcd26e3b	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_view-realm}	view-realm	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
b3f0923e-83ee-4c99-b783-6ec065fd6109	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_view-users}	view-users	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
d740b06d-0d18-4b7c-bd97-5d46de1d4562	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_view-clients}	view-clients	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
8585466b-b276-460b-b6f0-c806b0d01c5b	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_view-events}	view-events	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
16b73b3e-9222-4f2b-a931-ff13848a0380	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_view-identity-providers}	view-identity-providers	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
308ddbed-c439-49cb-ae43-fb4dadf49353	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_view-authorization}	view-authorization	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
b2110a97-ba26-41c0-8b44-a61b985a3a95	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_manage-realm}	manage-realm	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
d0424779-192c-42d5-8cee-65d73147fdb0	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_manage-users}	manage-users	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
a624ab77-e22c-43e2-8da5-26df4ff07e91	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_manage-clients}	manage-clients	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
11222d38-4c7f-4ad2-b45a-0f5e6761cf05	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_manage-events}	manage-events	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
f238f298-8da4-486b-a6cd-67adda0e92c1	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_manage-identity-providers}	manage-identity-providers	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
97b1c61d-9bdf-4899-bff2-3460176741b8	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_manage-authorization}	manage-authorization	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
5aaefbe1-bfae-4ba5-baa3-866d4cc3a95c	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_query-users}	query-users	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
7ddd3dcb-3649-4e16-a3e0-eca7d0608213	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_query-clients}	query-clients	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
7a2c97b9-dec7-4700-b47e-7303e2419f7b	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_query-realms}	query-realms	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
a335746c-d885-4de3-9cf0-822055914227	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_query-groups}	query-groups	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
8525b770-4ee1-4a99-b701-e90cf6a819cf	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	t	${role_view-profile}	view-profile	c46dc488-1d5b-449e-886b-6024480d4e83	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	\N
3d2a6ddd-cf10-4002-8aa4-96571d9cdab6	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	t	${role_manage-account}	manage-account	c46dc488-1d5b-449e-886b-6024480d4e83	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	\N
e238c24c-4a19-419d-8231-b7c44bfefd88	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	t	${role_manage-account-links}	manage-account-links	c46dc488-1d5b-449e-886b-6024480d4e83	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	\N
da681955-d1c9-413b-95a1-15b0b7efae90	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	t	${role_view-applications}	view-applications	c46dc488-1d5b-449e-886b-6024480d4e83	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	\N
331940af-2d2b-4e41-8e4a-e394df05ef1f	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	t	${role_view-consent}	view-consent	c46dc488-1d5b-449e-886b-6024480d4e83	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	\N
bc9f4113-8abf-4550-b6ef-01231b077a6f	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	t	${role_manage-consent}	manage-consent	c46dc488-1d5b-449e-886b-6024480d4e83	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	\N
da6c1463-3ada-4b4d-8860-6b18ffe49809	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	t	${role_view-groups}	view-groups	c46dc488-1d5b-449e-886b-6024480d4e83	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	\N
df81cc60-f823-4a78-891e-94515311b134	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	t	${role_delete-account}	delete-account	c46dc488-1d5b-449e-886b-6024480d4e83	7b5bf83e-3ef5-4f42-898e-c9f607143aa0	\N
334d0500-17ef-4237-9032-3e3560f7c505	8442a0ac-6e22-400c-8522-4ec51b254d40	t	${role_impersonation}	impersonation	9810599f-a32f-4d69-893a-d08f7209a282	8442a0ac-6e22-400c-8522-4ec51b254d40	\N
9fd66f3b-b6d6-4ca3-9ea5-5fada23974bc	57d25610-4002-4b7a-8aae-9a82e0979e29	t	${role_impersonation}	impersonation	c46dc488-1d5b-449e-886b-6024480d4e83	57d25610-4002-4b7a-8aae-9a82e0979e29	\N
c5bd90b8-4ed5-4592-ba86-c531d0c074d0	692745f4-b7aa-4718-bd28-3283052b2136	t	${role_read-token}	read-token	c46dc488-1d5b-449e-886b-6024480d4e83	692745f4-b7aa-4718-bd28-3283052b2136	\N
e9cfac0d-f3b0-4441-8ad7-fea724371b05	c46dc488-1d5b-449e-886b-6024480d4e83	f	${role_offline-access}	offline_access	c46dc488-1d5b-449e-886b-6024480d4e83	\N	\N
36fd2209-f336-4cb1-8e45-96e1c660af24	c46dc488-1d5b-449e-886b-6024480d4e83	f	${role_uma_authorization}	uma_authorization	c46dc488-1d5b-449e-886b-6024480d4e83	\N	\N
00656f6d-7338-4f00-b8cf-7f409b8d6ffe	419c054d-a05a-4d5f-8f3b-8654f86d8a82	t	\N	uma_protection	c46dc488-1d5b-449e-886b-6024480d4e83	419c054d-a05a-4d5f-8f3b-8654f86d8a82	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
jvbwt	26.1.1	1739149772
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
651e2728-1029-499b-bdd1-b8d455ddf86e	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
cfb3c9bf-ad9f-41b5-b371-1619970b4ff1	defaultResourceType	urn:kong:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
a1c00209-45ed-4c34-a540-acc57e8577a0	audience resolve	openid-connect	oidc-audience-resolve-mapper	afba78af-48c0-47e4-b27e-53b0e5ae124d	\N
06c2b01c-5c67-409e-9673-8d34a0b4b872	locale	openid-connect	oidc-usermodel-attribute-mapper	c204d56a-263a-4c50-8489-45a040774637	\N
7dd82966-2292-44f9-ba7b-369c10a3edae	role list	saml	saml-role-list-mapper	\N	7e276f44-70c2-43b4-b7d3-6006d02172d0
f6caacaa-d349-4de9-9036-0fde87dd5ea4	organization	saml	saml-organization-membership-mapper	\N	814b13c0-2255-4349-af70-6aba614d88c5
e328a08e-a22d-40e4-80ad-701594cfdf9f	full name	openid-connect	oidc-full-name-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
e6391b04-5707-4fe9-aef7-7b83ad99e07b	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
e367bf01-936b-47c9-b90d-a3ee83ca1375	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
d3e45808-59da-4e68-97d8-c88da13b600e	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
d394acc0-5684-4232-acc3-98eafd1aeffc	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
e66916ea-ddbe-4f2d-8b3a-534d96799f52	username	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
c1755d84-5459-4235-8f21-b6657fd83431	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
5594bcdc-f514-438c-bc52-5cb11b85e758	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
58677134-8fc9-4eab-a6f7-239949327479	website	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
49ae2288-910b-4822-9bf2-e68fbe450999	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
87bac443-9ccc-42ff-be65-b68d976918cc	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
97fbd34e-d945-4b59-a36c-01ce8b5429fa	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
509591d9-af64-4ed1-9432-6cd06872059a	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
eee11221-03ea-4069-9c11-7b26f98e6fb7	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	8d7bb5c2-46c3-4c37-b40a-743233979570
1f424db3-5b63-43ca-b162-24928538a5ea	email	openid-connect	oidc-usermodel-attribute-mapper	\N	68ccda09-ea26-483c-aa4f-5306a7a5992c
074c7c85-b96a-45a6-93f6-89f5189bb53b	email verified	openid-connect	oidc-usermodel-property-mapper	\N	68ccda09-ea26-483c-aa4f-5306a7a5992c
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	address	openid-connect	oidc-address-mapper	\N	91507df5-a08c-4080-b0f7-124725f50ccc
e1704b91-70f5-4ee0-91a1-a390d38c4231	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	02a40f0f-bdfb-4e90-b0f0-e154f8766787
3e419dec-fa5a-470e-b014-301dcc4d4c39	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	02a40f0f-bdfb-4e90-b0f0-e154f8766787
d60a0181-b7fc-4d3e-b61e-4c0a0b9d872e	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	17bae105-a391-475e-b0fb-1acf39f46d58
ffedab07-df7d-480c-a9b4-1238f088880f	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	17bae105-a391-475e-b0fb-1acf39f46d58
88c54cb8-fae6-4f18-baaf-2928307125f2	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	17bae105-a391-475e-b0fb-1acf39f46d58
953cbbe4-1836-433d-932d-d2eb509e23b9	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	8da2d223-4297-4166-a405-f9c0c2eda3b1
9316621d-0cfa-4aa6-8a21-4ed3b0d250fb	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	12a9978c-7fdd-4e1c-8100-07e091808057
4f213040-c32c-4228-b30a-9f81fc97d610	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	12a9978c-7fdd-4e1c-8100-07e091808057
5dda80e4-3d19-4cc9-b7b0-bf9598788214	acr loa level	openid-connect	oidc-acr-mapper	\N	7930caf8-10ea-45f1-957e-6a51a69f4b09
7efab3af-2ac8-4229-abf2-c2a62008d470	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	8588d757-d109-48c3-93b4-63698fb9e81a
d1c3f539-929b-472e-a1ce-83abd5445db5	sub	openid-connect	oidc-sub-mapper	\N	8588d757-d109-48c3-93b4-63698fb9e81a
b8e8c42b-307a-4920-8d77-c5c7fa97a124	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	5d173d26-5c29-4af4-a1dc-98e1919f5128
98770a44-7e82-4058-af1e-2eff00c2ddc3	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	5d173d26-5c29-4af4-a1dc-98e1919f5128
7de95832-b5a6-4f22-a070-ffdc8e8c144a	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	5d173d26-5c29-4af4-a1dc-98e1919f5128
a80abe4b-3e39-4c1c-8d1d-905a70710dd7	organization	openid-connect	oidc-organization-membership-mapper	\N	0b6d4d44-f036-4bda-ada1-972bb59f6e95
73391aac-7dae-471c-a68f-e6116d3befaf	audience resolve	openid-connect	oidc-audience-resolve-mapper	72dc3713-9065-401e-821e-3e0d9c21f6ac	\N
7cf19550-169c-4c70-920c-c51a8a390c84	role list	saml	saml-role-list-mapper	\N	6c28a83f-f09f-494f-9346-671c09f29e3c
3c9f1a87-e19c-46cc-b7e5-2edbf54350f9	organization	saml	saml-organization-membership-mapper	\N	c53da4fb-8a5e-47ec-80af-7de31bcb55ab
1f1dd30f-5415-4a9c-bc70-5421bdd1cb80	full name	openid-connect	oidc-full-name-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
c86545d2-363d-496f-af54-c8218bd0f0ea	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
c1ff4661-7d56-42e0-bbe7-5b605638975f	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
d8710f8d-330d-4631-9119-e89108d61a69	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
8a20bee7-b06c-4613-8c41-2e6905c8b8d4	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
2500bf70-e374-43d4-a693-8bf14fcbdd80	username	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
9ceec139-5153-46e4-aa9d-b2f2aedb0ba8	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
0bd98d7b-5292-4603-a65d-17e316970e55	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
28df50ef-8b1e-4bc1-b58b-ba16c18fbeb7	website	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
ae47daff-81c7-44cf-bad6-9c7ee3ce72c8	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
17ee7984-b875-4512-8d94-5cdedf1d0374	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
462db567-7631-4d2d-8ffb-5648fe37e925	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
82560d19-70ce-4a4d-a330-e16f7e6d1236	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
611f8146-2d26-4e64-9313-ce8a7eddc8c2	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	7a0f36cf-7639-434d-96ee-516ee53a3898
6e8990ac-c36a-482b-9179-2bb100b51bfb	email	openid-connect	oidc-usermodel-attribute-mapper	\N	a8e5898b-5cb9-4a82-8383-578023a151b4
a91708ca-4b59-49e7-b4e1-047f4b0db36f	email verified	openid-connect	oidc-usermodel-property-mapper	\N	a8e5898b-5cb9-4a82-8383-578023a151b4
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	address	openid-connect	oidc-address-mapper	\N	80c84187-d24a-4e47-8a85-e3142c0a3648
90ad6037-fca8-4b21-98b7-9613ca7d2ce8	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f90b816a-f494-4892-b766-df4e9af30098
a16a1334-9ffb-41fa-b614-d0fd8912fb16	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f90b816a-f494-4892-b766-df4e9af30098
a35fc712-1eac-4ff2-8d31-b1a90953cdfc	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	dd5e2866-7793-4660-b5b3-1249286e8373
eb023151-23e4-4a9a-8a89-1d0737c9b0b6	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	dd5e2866-7793-4660-b5b3-1249286e8373
89129397-bf21-4119-8687-39d20a3a4523	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	dd5e2866-7793-4660-b5b3-1249286e8373
79562fd8-fca8-46c0-91e3-68890517b89d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	fdeed3b7-ccf7-4403-a037-5c1be5abc614
0f986628-5c31-4dd9-86ca-b9dffb42944b	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	5d43cdea-1f20-4887-950b-cf4417eca5da
54d5c808-f88d-4c3d-ad04-f36ec91194ec	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	5d43cdea-1f20-4887-950b-cf4417eca5da
ab075952-b5e3-449b-a66c-13d3c405645e	acr loa level	openid-connect	oidc-acr-mapper	\N	19a2c512-9ff9-473c-8735-097b1802a7f1
59e925d7-091e-46e9-b020-dc263a29c771	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	479b9395-bfcd-492f-b8fe-4c24f9175226
16a9d26d-a203-4ddf-b332-54fb06acf65b	sub	openid-connect	oidc-sub-mapper	\N	479b9395-bfcd-492f-b8fe-4c24f9175226
6affc638-cb45-47bd-b6ee-ba13ecd92c55	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	633f4bb0-74eb-45cb-90c2-f3b1d125f49a
fff4db79-af81-4978-9e16-2d847f2f0529	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	633f4bb0-74eb-45cb-90c2-f3b1d125f49a
3acd470e-4707-46b8-b8a1-4882e7c17638	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	633f4bb0-74eb-45cb-90c2-f3b1d125f49a
809b7423-e517-4ce7-8a81-29e6cd108bb8	organization	openid-connect	oidc-organization-membership-mapper	\N	aea5b7f9-a949-46d6-8478-26ee49ad6edc
85a66399-2175-4491-895a-27f2606778be	locale	openid-connect	oidc-usermodel-attribute-mapper	e3714741-c112-48ae-9166-c99d9b25a174	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
06c2b01c-5c67-409e-9673-8d34a0b4b872	true	introspection.token.claim
06c2b01c-5c67-409e-9673-8d34a0b4b872	true	userinfo.token.claim
06c2b01c-5c67-409e-9673-8d34a0b4b872	locale	user.attribute
06c2b01c-5c67-409e-9673-8d34a0b4b872	true	id.token.claim
06c2b01c-5c67-409e-9673-8d34a0b4b872	true	access.token.claim
06c2b01c-5c67-409e-9673-8d34a0b4b872	locale	claim.name
06c2b01c-5c67-409e-9673-8d34a0b4b872	String	jsonType.label
7dd82966-2292-44f9-ba7b-369c10a3edae	false	single
7dd82966-2292-44f9-ba7b-369c10a3edae	Basic	attribute.nameformat
7dd82966-2292-44f9-ba7b-369c10a3edae	Role	attribute.name
49ae2288-910b-4822-9bf2-e68fbe450999	true	introspection.token.claim
49ae2288-910b-4822-9bf2-e68fbe450999	true	userinfo.token.claim
49ae2288-910b-4822-9bf2-e68fbe450999	gender	user.attribute
49ae2288-910b-4822-9bf2-e68fbe450999	true	id.token.claim
49ae2288-910b-4822-9bf2-e68fbe450999	true	access.token.claim
49ae2288-910b-4822-9bf2-e68fbe450999	gender	claim.name
49ae2288-910b-4822-9bf2-e68fbe450999	String	jsonType.label
509591d9-af64-4ed1-9432-6cd06872059a	true	introspection.token.claim
509591d9-af64-4ed1-9432-6cd06872059a	true	userinfo.token.claim
509591d9-af64-4ed1-9432-6cd06872059a	locale	user.attribute
509591d9-af64-4ed1-9432-6cd06872059a	true	id.token.claim
509591d9-af64-4ed1-9432-6cd06872059a	true	access.token.claim
509591d9-af64-4ed1-9432-6cd06872059a	locale	claim.name
509591d9-af64-4ed1-9432-6cd06872059a	String	jsonType.label
5594bcdc-f514-438c-bc52-5cb11b85e758	true	introspection.token.claim
5594bcdc-f514-438c-bc52-5cb11b85e758	true	userinfo.token.claim
5594bcdc-f514-438c-bc52-5cb11b85e758	picture	user.attribute
5594bcdc-f514-438c-bc52-5cb11b85e758	true	id.token.claim
5594bcdc-f514-438c-bc52-5cb11b85e758	true	access.token.claim
5594bcdc-f514-438c-bc52-5cb11b85e758	picture	claim.name
5594bcdc-f514-438c-bc52-5cb11b85e758	String	jsonType.label
58677134-8fc9-4eab-a6f7-239949327479	true	introspection.token.claim
58677134-8fc9-4eab-a6f7-239949327479	true	userinfo.token.claim
58677134-8fc9-4eab-a6f7-239949327479	website	user.attribute
58677134-8fc9-4eab-a6f7-239949327479	true	id.token.claim
58677134-8fc9-4eab-a6f7-239949327479	true	access.token.claim
58677134-8fc9-4eab-a6f7-239949327479	website	claim.name
58677134-8fc9-4eab-a6f7-239949327479	String	jsonType.label
87bac443-9ccc-42ff-be65-b68d976918cc	true	introspection.token.claim
87bac443-9ccc-42ff-be65-b68d976918cc	true	userinfo.token.claim
87bac443-9ccc-42ff-be65-b68d976918cc	birthdate	user.attribute
87bac443-9ccc-42ff-be65-b68d976918cc	true	id.token.claim
87bac443-9ccc-42ff-be65-b68d976918cc	true	access.token.claim
87bac443-9ccc-42ff-be65-b68d976918cc	birthdate	claim.name
87bac443-9ccc-42ff-be65-b68d976918cc	String	jsonType.label
97fbd34e-d945-4b59-a36c-01ce8b5429fa	true	introspection.token.claim
97fbd34e-d945-4b59-a36c-01ce8b5429fa	true	userinfo.token.claim
97fbd34e-d945-4b59-a36c-01ce8b5429fa	zoneinfo	user.attribute
97fbd34e-d945-4b59-a36c-01ce8b5429fa	true	id.token.claim
97fbd34e-d945-4b59-a36c-01ce8b5429fa	true	access.token.claim
97fbd34e-d945-4b59-a36c-01ce8b5429fa	zoneinfo	claim.name
97fbd34e-d945-4b59-a36c-01ce8b5429fa	String	jsonType.label
c1755d84-5459-4235-8f21-b6657fd83431	true	introspection.token.claim
c1755d84-5459-4235-8f21-b6657fd83431	true	userinfo.token.claim
c1755d84-5459-4235-8f21-b6657fd83431	profile	user.attribute
c1755d84-5459-4235-8f21-b6657fd83431	true	id.token.claim
c1755d84-5459-4235-8f21-b6657fd83431	true	access.token.claim
c1755d84-5459-4235-8f21-b6657fd83431	profile	claim.name
c1755d84-5459-4235-8f21-b6657fd83431	String	jsonType.label
d394acc0-5684-4232-acc3-98eafd1aeffc	true	introspection.token.claim
d394acc0-5684-4232-acc3-98eafd1aeffc	true	userinfo.token.claim
d394acc0-5684-4232-acc3-98eafd1aeffc	nickname	user.attribute
d394acc0-5684-4232-acc3-98eafd1aeffc	true	id.token.claim
d394acc0-5684-4232-acc3-98eafd1aeffc	true	access.token.claim
d394acc0-5684-4232-acc3-98eafd1aeffc	nickname	claim.name
d394acc0-5684-4232-acc3-98eafd1aeffc	String	jsonType.label
d3e45808-59da-4e68-97d8-c88da13b600e	true	introspection.token.claim
d3e45808-59da-4e68-97d8-c88da13b600e	true	userinfo.token.claim
d3e45808-59da-4e68-97d8-c88da13b600e	middleName	user.attribute
d3e45808-59da-4e68-97d8-c88da13b600e	true	id.token.claim
d3e45808-59da-4e68-97d8-c88da13b600e	true	access.token.claim
d3e45808-59da-4e68-97d8-c88da13b600e	middle_name	claim.name
d3e45808-59da-4e68-97d8-c88da13b600e	String	jsonType.label
e328a08e-a22d-40e4-80ad-701594cfdf9f	true	introspection.token.claim
e328a08e-a22d-40e4-80ad-701594cfdf9f	true	userinfo.token.claim
e328a08e-a22d-40e4-80ad-701594cfdf9f	true	id.token.claim
e328a08e-a22d-40e4-80ad-701594cfdf9f	true	access.token.claim
e367bf01-936b-47c9-b90d-a3ee83ca1375	true	introspection.token.claim
e367bf01-936b-47c9-b90d-a3ee83ca1375	true	userinfo.token.claim
e367bf01-936b-47c9-b90d-a3ee83ca1375	firstName	user.attribute
e367bf01-936b-47c9-b90d-a3ee83ca1375	true	id.token.claim
e367bf01-936b-47c9-b90d-a3ee83ca1375	true	access.token.claim
e367bf01-936b-47c9-b90d-a3ee83ca1375	given_name	claim.name
e367bf01-936b-47c9-b90d-a3ee83ca1375	String	jsonType.label
e6391b04-5707-4fe9-aef7-7b83ad99e07b	true	introspection.token.claim
e6391b04-5707-4fe9-aef7-7b83ad99e07b	true	userinfo.token.claim
e6391b04-5707-4fe9-aef7-7b83ad99e07b	lastName	user.attribute
e6391b04-5707-4fe9-aef7-7b83ad99e07b	true	id.token.claim
e6391b04-5707-4fe9-aef7-7b83ad99e07b	true	access.token.claim
e6391b04-5707-4fe9-aef7-7b83ad99e07b	family_name	claim.name
e6391b04-5707-4fe9-aef7-7b83ad99e07b	String	jsonType.label
e66916ea-ddbe-4f2d-8b3a-534d96799f52	true	introspection.token.claim
e66916ea-ddbe-4f2d-8b3a-534d96799f52	true	userinfo.token.claim
e66916ea-ddbe-4f2d-8b3a-534d96799f52	username	user.attribute
e66916ea-ddbe-4f2d-8b3a-534d96799f52	true	id.token.claim
e66916ea-ddbe-4f2d-8b3a-534d96799f52	true	access.token.claim
e66916ea-ddbe-4f2d-8b3a-534d96799f52	preferred_username	claim.name
e66916ea-ddbe-4f2d-8b3a-534d96799f52	String	jsonType.label
eee11221-03ea-4069-9c11-7b26f98e6fb7	true	introspection.token.claim
eee11221-03ea-4069-9c11-7b26f98e6fb7	true	userinfo.token.claim
eee11221-03ea-4069-9c11-7b26f98e6fb7	updatedAt	user.attribute
eee11221-03ea-4069-9c11-7b26f98e6fb7	true	id.token.claim
eee11221-03ea-4069-9c11-7b26f98e6fb7	true	access.token.claim
eee11221-03ea-4069-9c11-7b26f98e6fb7	updated_at	claim.name
eee11221-03ea-4069-9c11-7b26f98e6fb7	long	jsonType.label
074c7c85-b96a-45a6-93f6-89f5189bb53b	true	introspection.token.claim
074c7c85-b96a-45a6-93f6-89f5189bb53b	true	userinfo.token.claim
074c7c85-b96a-45a6-93f6-89f5189bb53b	emailVerified	user.attribute
074c7c85-b96a-45a6-93f6-89f5189bb53b	true	id.token.claim
074c7c85-b96a-45a6-93f6-89f5189bb53b	true	access.token.claim
074c7c85-b96a-45a6-93f6-89f5189bb53b	email_verified	claim.name
074c7c85-b96a-45a6-93f6-89f5189bb53b	boolean	jsonType.label
1f424db3-5b63-43ca-b162-24928538a5ea	true	introspection.token.claim
1f424db3-5b63-43ca-b162-24928538a5ea	true	userinfo.token.claim
1f424db3-5b63-43ca-b162-24928538a5ea	email	user.attribute
1f424db3-5b63-43ca-b162-24928538a5ea	true	id.token.claim
1f424db3-5b63-43ca-b162-24928538a5ea	true	access.token.claim
1f424db3-5b63-43ca-b162-24928538a5ea	email	claim.name
1f424db3-5b63-43ca-b162-24928538a5ea	String	jsonType.label
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	formatted	user.attribute.formatted
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	country	user.attribute.country
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	true	introspection.token.claim
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	postal_code	user.attribute.postal_code
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	true	userinfo.token.claim
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	street	user.attribute.street
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	true	id.token.claim
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	region	user.attribute.region
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	true	access.token.claim
61cfe95b-d68b-4b7b-b39f-0bc6fa299153	locality	user.attribute.locality
3e419dec-fa5a-470e-b014-301dcc4d4c39	true	introspection.token.claim
3e419dec-fa5a-470e-b014-301dcc4d4c39	true	userinfo.token.claim
3e419dec-fa5a-470e-b014-301dcc4d4c39	phoneNumberVerified	user.attribute
3e419dec-fa5a-470e-b014-301dcc4d4c39	true	id.token.claim
3e419dec-fa5a-470e-b014-301dcc4d4c39	true	access.token.claim
3e419dec-fa5a-470e-b014-301dcc4d4c39	phone_number_verified	claim.name
3e419dec-fa5a-470e-b014-301dcc4d4c39	boolean	jsonType.label
e1704b91-70f5-4ee0-91a1-a390d38c4231	true	introspection.token.claim
e1704b91-70f5-4ee0-91a1-a390d38c4231	true	userinfo.token.claim
e1704b91-70f5-4ee0-91a1-a390d38c4231	phoneNumber	user.attribute
e1704b91-70f5-4ee0-91a1-a390d38c4231	true	id.token.claim
e1704b91-70f5-4ee0-91a1-a390d38c4231	true	access.token.claim
e1704b91-70f5-4ee0-91a1-a390d38c4231	phone_number	claim.name
e1704b91-70f5-4ee0-91a1-a390d38c4231	String	jsonType.label
88c54cb8-fae6-4f18-baaf-2928307125f2	true	introspection.token.claim
88c54cb8-fae6-4f18-baaf-2928307125f2	true	access.token.claim
d60a0181-b7fc-4d3e-b61e-4c0a0b9d872e	true	introspection.token.claim
d60a0181-b7fc-4d3e-b61e-4c0a0b9d872e	true	multivalued
d60a0181-b7fc-4d3e-b61e-4c0a0b9d872e	foo	user.attribute
d60a0181-b7fc-4d3e-b61e-4c0a0b9d872e	true	access.token.claim
d60a0181-b7fc-4d3e-b61e-4c0a0b9d872e	realm_access.roles	claim.name
d60a0181-b7fc-4d3e-b61e-4c0a0b9d872e	String	jsonType.label
ffedab07-df7d-480c-a9b4-1238f088880f	true	introspection.token.claim
ffedab07-df7d-480c-a9b4-1238f088880f	true	multivalued
ffedab07-df7d-480c-a9b4-1238f088880f	foo	user.attribute
ffedab07-df7d-480c-a9b4-1238f088880f	true	access.token.claim
ffedab07-df7d-480c-a9b4-1238f088880f	resource_access.${client_id}.roles	claim.name
ffedab07-df7d-480c-a9b4-1238f088880f	String	jsonType.label
953cbbe4-1836-433d-932d-d2eb509e23b9	true	introspection.token.claim
953cbbe4-1836-433d-932d-d2eb509e23b9	true	access.token.claim
4f213040-c32c-4228-b30a-9f81fc97d610	true	introspection.token.claim
4f213040-c32c-4228-b30a-9f81fc97d610	true	multivalued
4f213040-c32c-4228-b30a-9f81fc97d610	foo	user.attribute
4f213040-c32c-4228-b30a-9f81fc97d610	true	id.token.claim
4f213040-c32c-4228-b30a-9f81fc97d610	true	access.token.claim
4f213040-c32c-4228-b30a-9f81fc97d610	groups	claim.name
4f213040-c32c-4228-b30a-9f81fc97d610	String	jsonType.label
9316621d-0cfa-4aa6-8a21-4ed3b0d250fb	true	introspection.token.claim
9316621d-0cfa-4aa6-8a21-4ed3b0d250fb	true	userinfo.token.claim
9316621d-0cfa-4aa6-8a21-4ed3b0d250fb	username	user.attribute
9316621d-0cfa-4aa6-8a21-4ed3b0d250fb	true	id.token.claim
9316621d-0cfa-4aa6-8a21-4ed3b0d250fb	true	access.token.claim
9316621d-0cfa-4aa6-8a21-4ed3b0d250fb	upn	claim.name
9316621d-0cfa-4aa6-8a21-4ed3b0d250fb	String	jsonType.label
5dda80e4-3d19-4cc9-b7b0-bf9598788214	true	introspection.token.claim
5dda80e4-3d19-4cc9-b7b0-bf9598788214	true	id.token.claim
5dda80e4-3d19-4cc9-b7b0-bf9598788214	true	access.token.claim
7efab3af-2ac8-4229-abf2-c2a62008d470	AUTH_TIME	user.session.note
7efab3af-2ac8-4229-abf2-c2a62008d470	true	introspection.token.claim
7efab3af-2ac8-4229-abf2-c2a62008d470	true	id.token.claim
7efab3af-2ac8-4229-abf2-c2a62008d470	true	access.token.claim
7efab3af-2ac8-4229-abf2-c2a62008d470	auth_time	claim.name
7efab3af-2ac8-4229-abf2-c2a62008d470	long	jsonType.label
d1c3f539-929b-472e-a1ce-83abd5445db5	true	introspection.token.claim
d1c3f539-929b-472e-a1ce-83abd5445db5	true	access.token.claim
7de95832-b5a6-4f22-a070-ffdc8e8c144a	clientAddress	user.session.note
7de95832-b5a6-4f22-a070-ffdc8e8c144a	true	introspection.token.claim
7de95832-b5a6-4f22-a070-ffdc8e8c144a	true	id.token.claim
7de95832-b5a6-4f22-a070-ffdc8e8c144a	true	access.token.claim
7de95832-b5a6-4f22-a070-ffdc8e8c144a	clientAddress	claim.name
7de95832-b5a6-4f22-a070-ffdc8e8c144a	String	jsonType.label
98770a44-7e82-4058-af1e-2eff00c2ddc3	clientHost	user.session.note
98770a44-7e82-4058-af1e-2eff00c2ddc3	true	introspection.token.claim
98770a44-7e82-4058-af1e-2eff00c2ddc3	true	id.token.claim
98770a44-7e82-4058-af1e-2eff00c2ddc3	true	access.token.claim
98770a44-7e82-4058-af1e-2eff00c2ddc3	clientHost	claim.name
98770a44-7e82-4058-af1e-2eff00c2ddc3	String	jsonType.label
b8e8c42b-307a-4920-8d77-c5c7fa97a124	client_id	user.session.note
b8e8c42b-307a-4920-8d77-c5c7fa97a124	true	introspection.token.claim
b8e8c42b-307a-4920-8d77-c5c7fa97a124	true	id.token.claim
b8e8c42b-307a-4920-8d77-c5c7fa97a124	true	access.token.claim
b8e8c42b-307a-4920-8d77-c5c7fa97a124	client_id	claim.name
b8e8c42b-307a-4920-8d77-c5c7fa97a124	String	jsonType.label
a80abe4b-3e39-4c1c-8d1d-905a70710dd7	true	introspection.token.claim
a80abe4b-3e39-4c1c-8d1d-905a70710dd7	true	multivalued
a80abe4b-3e39-4c1c-8d1d-905a70710dd7	true	id.token.claim
a80abe4b-3e39-4c1c-8d1d-905a70710dd7	true	access.token.claim
a80abe4b-3e39-4c1c-8d1d-905a70710dd7	organization	claim.name
a80abe4b-3e39-4c1c-8d1d-905a70710dd7	String	jsonType.label
7cf19550-169c-4c70-920c-c51a8a390c84	false	single
7cf19550-169c-4c70-920c-c51a8a390c84	Basic	attribute.nameformat
7cf19550-169c-4c70-920c-c51a8a390c84	Role	attribute.name
0bd98d7b-5292-4603-a65d-17e316970e55	true	introspection.token.claim
0bd98d7b-5292-4603-a65d-17e316970e55	true	userinfo.token.claim
0bd98d7b-5292-4603-a65d-17e316970e55	picture	user.attribute
0bd98d7b-5292-4603-a65d-17e316970e55	true	id.token.claim
0bd98d7b-5292-4603-a65d-17e316970e55	true	access.token.claim
0bd98d7b-5292-4603-a65d-17e316970e55	picture	claim.name
0bd98d7b-5292-4603-a65d-17e316970e55	String	jsonType.label
17ee7984-b875-4512-8d94-5cdedf1d0374	true	introspection.token.claim
17ee7984-b875-4512-8d94-5cdedf1d0374	true	userinfo.token.claim
17ee7984-b875-4512-8d94-5cdedf1d0374	birthdate	user.attribute
17ee7984-b875-4512-8d94-5cdedf1d0374	true	id.token.claim
17ee7984-b875-4512-8d94-5cdedf1d0374	true	access.token.claim
17ee7984-b875-4512-8d94-5cdedf1d0374	birthdate	claim.name
17ee7984-b875-4512-8d94-5cdedf1d0374	String	jsonType.label
1f1dd30f-5415-4a9c-bc70-5421bdd1cb80	true	introspection.token.claim
1f1dd30f-5415-4a9c-bc70-5421bdd1cb80	true	userinfo.token.claim
1f1dd30f-5415-4a9c-bc70-5421bdd1cb80	true	id.token.claim
1f1dd30f-5415-4a9c-bc70-5421bdd1cb80	true	access.token.claim
2500bf70-e374-43d4-a693-8bf14fcbdd80	true	introspection.token.claim
2500bf70-e374-43d4-a693-8bf14fcbdd80	true	userinfo.token.claim
2500bf70-e374-43d4-a693-8bf14fcbdd80	username	user.attribute
2500bf70-e374-43d4-a693-8bf14fcbdd80	true	id.token.claim
2500bf70-e374-43d4-a693-8bf14fcbdd80	true	access.token.claim
2500bf70-e374-43d4-a693-8bf14fcbdd80	preferred_username	claim.name
2500bf70-e374-43d4-a693-8bf14fcbdd80	String	jsonType.label
28df50ef-8b1e-4bc1-b58b-ba16c18fbeb7	true	introspection.token.claim
28df50ef-8b1e-4bc1-b58b-ba16c18fbeb7	true	userinfo.token.claim
28df50ef-8b1e-4bc1-b58b-ba16c18fbeb7	website	user.attribute
28df50ef-8b1e-4bc1-b58b-ba16c18fbeb7	true	id.token.claim
28df50ef-8b1e-4bc1-b58b-ba16c18fbeb7	true	access.token.claim
28df50ef-8b1e-4bc1-b58b-ba16c18fbeb7	website	claim.name
28df50ef-8b1e-4bc1-b58b-ba16c18fbeb7	String	jsonType.label
462db567-7631-4d2d-8ffb-5648fe37e925	true	introspection.token.claim
462db567-7631-4d2d-8ffb-5648fe37e925	true	userinfo.token.claim
462db567-7631-4d2d-8ffb-5648fe37e925	zoneinfo	user.attribute
462db567-7631-4d2d-8ffb-5648fe37e925	true	id.token.claim
462db567-7631-4d2d-8ffb-5648fe37e925	true	access.token.claim
462db567-7631-4d2d-8ffb-5648fe37e925	zoneinfo	claim.name
462db567-7631-4d2d-8ffb-5648fe37e925	String	jsonType.label
611f8146-2d26-4e64-9313-ce8a7eddc8c2	true	introspection.token.claim
611f8146-2d26-4e64-9313-ce8a7eddc8c2	true	userinfo.token.claim
611f8146-2d26-4e64-9313-ce8a7eddc8c2	updatedAt	user.attribute
611f8146-2d26-4e64-9313-ce8a7eddc8c2	true	id.token.claim
611f8146-2d26-4e64-9313-ce8a7eddc8c2	true	access.token.claim
611f8146-2d26-4e64-9313-ce8a7eddc8c2	updated_at	claim.name
611f8146-2d26-4e64-9313-ce8a7eddc8c2	long	jsonType.label
82560d19-70ce-4a4d-a330-e16f7e6d1236	true	introspection.token.claim
82560d19-70ce-4a4d-a330-e16f7e6d1236	true	userinfo.token.claim
82560d19-70ce-4a4d-a330-e16f7e6d1236	locale	user.attribute
82560d19-70ce-4a4d-a330-e16f7e6d1236	true	id.token.claim
82560d19-70ce-4a4d-a330-e16f7e6d1236	true	access.token.claim
82560d19-70ce-4a4d-a330-e16f7e6d1236	locale	claim.name
82560d19-70ce-4a4d-a330-e16f7e6d1236	String	jsonType.label
8a20bee7-b06c-4613-8c41-2e6905c8b8d4	true	introspection.token.claim
8a20bee7-b06c-4613-8c41-2e6905c8b8d4	true	userinfo.token.claim
8a20bee7-b06c-4613-8c41-2e6905c8b8d4	nickname	user.attribute
8a20bee7-b06c-4613-8c41-2e6905c8b8d4	true	id.token.claim
8a20bee7-b06c-4613-8c41-2e6905c8b8d4	true	access.token.claim
8a20bee7-b06c-4613-8c41-2e6905c8b8d4	nickname	claim.name
8a20bee7-b06c-4613-8c41-2e6905c8b8d4	String	jsonType.label
9ceec139-5153-46e4-aa9d-b2f2aedb0ba8	true	introspection.token.claim
9ceec139-5153-46e4-aa9d-b2f2aedb0ba8	true	userinfo.token.claim
9ceec139-5153-46e4-aa9d-b2f2aedb0ba8	profile	user.attribute
9ceec139-5153-46e4-aa9d-b2f2aedb0ba8	true	id.token.claim
9ceec139-5153-46e4-aa9d-b2f2aedb0ba8	true	access.token.claim
9ceec139-5153-46e4-aa9d-b2f2aedb0ba8	profile	claim.name
9ceec139-5153-46e4-aa9d-b2f2aedb0ba8	String	jsonType.label
ae47daff-81c7-44cf-bad6-9c7ee3ce72c8	true	introspection.token.claim
ae47daff-81c7-44cf-bad6-9c7ee3ce72c8	true	userinfo.token.claim
ae47daff-81c7-44cf-bad6-9c7ee3ce72c8	gender	user.attribute
ae47daff-81c7-44cf-bad6-9c7ee3ce72c8	true	id.token.claim
ae47daff-81c7-44cf-bad6-9c7ee3ce72c8	true	access.token.claim
ae47daff-81c7-44cf-bad6-9c7ee3ce72c8	gender	claim.name
ae47daff-81c7-44cf-bad6-9c7ee3ce72c8	String	jsonType.label
c1ff4661-7d56-42e0-bbe7-5b605638975f	true	introspection.token.claim
c1ff4661-7d56-42e0-bbe7-5b605638975f	true	userinfo.token.claim
c1ff4661-7d56-42e0-bbe7-5b605638975f	firstName	user.attribute
c1ff4661-7d56-42e0-bbe7-5b605638975f	true	id.token.claim
c1ff4661-7d56-42e0-bbe7-5b605638975f	true	access.token.claim
c1ff4661-7d56-42e0-bbe7-5b605638975f	given_name	claim.name
c1ff4661-7d56-42e0-bbe7-5b605638975f	String	jsonType.label
c86545d2-363d-496f-af54-c8218bd0f0ea	true	introspection.token.claim
c86545d2-363d-496f-af54-c8218bd0f0ea	true	userinfo.token.claim
c86545d2-363d-496f-af54-c8218bd0f0ea	lastName	user.attribute
c86545d2-363d-496f-af54-c8218bd0f0ea	true	id.token.claim
c86545d2-363d-496f-af54-c8218bd0f0ea	true	access.token.claim
c86545d2-363d-496f-af54-c8218bd0f0ea	family_name	claim.name
c86545d2-363d-496f-af54-c8218bd0f0ea	String	jsonType.label
d8710f8d-330d-4631-9119-e89108d61a69	true	introspection.token.claim
d8710f8d-330d-4631-9119-e89108d61a69	true	userinfo.token.claim
d8710f8d-330d-4631-9119-e89108d61a69	middleName	user.attribute
d8710f8d-330d-4631-9119-e89108d61a69	true	id.token.claim
d8710f8d-330d-4631-9119-e89108d61a69	true	access.token.claim
d8710f8d-330d-4631-9119-e89108d61a69	middle_name	claim.name
d8710f8d-330d-4631-9119-e89108d61a69	String	jsonType.label
6e8990ac-c36a-482b-9179-2bb100b51bfb	true	introspection.token.claim
6e8990ac-c36a-482b-9179-2bb100b51bfb	true	userinfo.token.claim
6e8990ac-c36a-482b-9179-2bb100b51bfb	email	user.attribute
6e8990ac-c36a-482b-9179-2bb100b51bfb	true	id.token.claim
6e8990ac-c36a-482b-9179-2bb100b51bfb	true	access.token.claim
6e8990ac-c36a-482b-9179-2bb100b51bfb	email	claim.name
6e8990ac-c36a-482b-9179-2bb100b51bfb	String	jsonType.label
a91708ca-4b59-49e7-b4e1-047f4b0db36f	true	introspection.token.claim
a91708ca-4b59-49e7-b4e1-047f4b0db36f	true	userinfo.token.claim
a91708ca-4b59-49e7-b4e1-047f4b0db36f	emailVerified	user.attribute
a91708ca-4b59-49e7-b4e1-047f4b0db36f	true	id.token.claim
a91708ca-4b59-49e7-b4e1-047f4b0db36f	true	access.token.claim
a91708ca-4b59-49e7-b4e1-047f4b0db36f	email_verified	claim.name
a91708ca-4b59-49e7-b4e1-047f4b0db36f	boolean	jsonType.label
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	formatted	user.attribute.formatted
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	country	user.attribute.country
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	true	introspection.token.claim
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	postal_code	user.attribute.postal_code
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	true	userinfo.token.claim
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	street	user.attribute.street
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	true	id.token.claim
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	region	user.attribute.region
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	true	access.token.claim
f114c5fc-bea3-4e35-ab4e-fc6c023898c3	locality	user.attribute.locality
90ad6037-fca8-4b21-98b7-9613ca7d2ce8	true	introspection.token.claim
90ad6037-fca8-4b21-98b7-9613ca7d2ce8	true	userinfo.token.claim
90ad6037-fca8-4b21-98b7-9613ca7d2ce8	phoneNumber	user.attribute
90ad6037-fca8-4b21-98b7-9613ca7d2ce8	true	id.token.claim
90ad6037-fca8-4b21-98b7-9613ca7d2ce8	true	access.token.claim
90ad6037-fca8-4b21-98b7-9613ca7d2ce8	phone_number	claim.name
90ad6037-fca8-4b21-98b7-9613ca7d2ce8	String	jsonType.label
a16a1334-9ffb-41fa-b614-d0fd8912fb16	true	introspection.token.claim
a16a1334-9ffb-41fa-b614-d0fd8912fb16	true	userinfo.token.claim
a16a1334-9ffb-41fa-b614-d0fd8912fb16	phoneNumberVerified	user.attribute
a16a1334-9ffb-41fa-b614-d0fd8912fb16	true	id.token.claim
a16a1334-9ffb-41fa-b614-d0fd8912fb16	true	access.token.claim
a16a1334-9ffb-41fa-b614-d0fd8912fb16	phone_number_verified	claim.name
a16a1334-9ffb-41fa-b614-d0fd8912fb16	boolean	jsonType.label
89129397-bf21-4119-8687-39d20a3a4523	true	introspection.token.claim
89129397-bf21-4119-8687-39d20a3a4523	true	access.token.claim
a35fc712-1eac-4ff2-8d31-b1a90953cdfc	true	introspection.token.claim
a35fc712-1eac-4ff2-8d31-b1a90953cdfc	true	multivalued
a35fc712-1eac-4ff2-8d31-b1a90953cdfc	foo	user.attribute
a35fc712-1eac-4ff2-8d31-b1a90953cdfc	true	access.token.claim
a35fc712-1eac-4ff2-8d31-b1a90953cdfc	realm_access.roles	claim.name
a35fc712-1eac-4ff2-8d31-b1a90953cdfc	String	jsonType.label
eb023151-23e4-4a9a-8a89-1d0737c9b0b6	true	introspection.token.claim
eb023151-23e4-4a9a-8a89-1d0737c9b0b6	true	multivalued
eb023151-23e4-4a9a-8a89-1d0737c9b0b6	foo	user.attribute
eb023151-23e4-4a9a-8a89-1d0737c9b0b6	true	access.token.claim
eb023151-23e4-4a9a-8a89-1d0737c9b0b6	resource_access.${client_id}.roles	claim.name
eb023151-23e4-4a9a-8a89-1d0737c9b0b6	String	jsonType.label
79562fd8-fca8-46c0-91e3-68890517b89d	true	introspection.token.claim
79562fd8-fca8-46c0-91e3-68890517b89d	true	access.token.claim
0f986628-5c31-4dd9-86ca-b9dffb42944b	true	introspection.token.claim
0f986628-5c31-4dd9-86ca-b9dffb42944b	true	userinfo.token.claim
0f986628-5c31-4dd9-86ca-b9dffb42944b	username	user.attribute
0f986628-5c31-4dd9-86ca-b9dffb42944b	true	id.token.claim
0f986628-5c31-4dd9-86ca-b9dffb42944b	true	access.token.claim
0f986628-5c31-4dd9-86ca-b9dffb42944b	upn	claim.name
0f986628-5c31-4dd9-86ca-b9dffb42944b	String	jsonType.label
54d5c808-f88d-4c3d-ad04-f36ec91194ec	true	introspection.token.claim
54d5c808-f88d-4c3d-ad04-f36ec91194ec	true	multivalued
54d5c808-f88d-4c3d-ad04-f36ec91194ec	foo	user.attribute
54d5c808-f88d-4c3d-ad04-f36ec91194ec	true	id.token.claim
54d5c808-f88d-4c3d-ad04-f36ec91194ec	true	access.token.claim
54d5c808-f88d-4c3d-ad04-f36ec91194ec	groups	claim.name
54d5c808-f88d-4c3d-ad04-f36ec91194ec	String	jsonType.label
ab075952-b5e3-449b-a66c-13d3c405645e	true	introspection.token.claim
ab075952-b5e3-449b-a66c-13d3c405645e	true	id.token.claim
ab075952-b5e3-449b-a66c-13d3c405645e	true	access.token.claim
16a9d26d-a203-4ddf-b332-54fb06acf65b	true	introspection.token.claim
16a9d26d-a203-4ddf-b332-54fb06acf65b	true	access.token.claim
59e925d7-091e-46e9-b020-dc263a29c771	AUTH_TIME	user.session.note
59e925d7-091e-46e9-b020-dc263a29c771	true	introspection.token.claim
59e925d7-091e-46e9-b020-dc263a29c771	true	id.token.claim
59e925d7-091e-46e9-b020-dc263a29c771	true	access.token.claim
59e925d7-091e-46e9-b020-dc263a29c771	auth_time	claim.name
59e925d7-091e-46e9-b020-dc263a29c771	long	jsonType.label
3acd470e-4707-46b8-b8a1-4882e7c17638	clientAddress	user.session.note
3acd470e-4707-46b8-b8a1-4882e7c17638	true	introspection.token.claim
3acd470e-4707-46b8-b8a1-4882e7c17638	true	id.token.claim
3acd470e-4707-46b8-b8a1-4882e7c17638	true	access.token.claim
3acd470e-4707-46b8-b8a1-4882e7c17638	clientAddress	claim.name
3acd470e-4707-46b8-b8a1-4882e7c17638	String	jsonType.label
6affc638-cb45-47bd-b6ee-ba13ecd92c55	client_id	user.session.note
6affc638-cb45-47bd-b6ee-ba13ecd92c55	true	introspection.token.claim
6affc638-cb45-47bd-b6ee-ba13ecd92c55	true	id.token.claim
6affc638-cb45-47bd-b6ee-ba13ecd92c55	true	access.token.claim
6affc638-cb45-47bd-b6ee-ba13ecd92c55	client_id	claim.name
6affc638-cb45-47bd-b6ee-ba13ecd92c55	String	jsonType.label
fff4db79-af81-4978-9e16-2d847f2f0529	clientHost	user.session.note
fff4db79-af81-4978-9e16-2d847f2f0529	true	introspection.token.claim
fff4db79-af81-4978-9e16-2d847f2f0529	true	id.token.claim
fff4db79-af81-4978-9e16-2d847f2f0529	true	access.token.claim
fff4db79-af81-4978-9e16-2d847f2f0529	clientHost	claim.name
fff4db79-af81-4978-9e16-2d847f2f0529	String	jsonType.label
809b7423-e517-4ce7-8a81-29e6cd108bb8	true	introspection.token.claim
809b7423-e517-4ce7-8a81-29e6cd108bb8	true	multivalued
809b7423-e517-4ce7-8a81-29e6cd108bb8	true	id.token.claim
809b7423-e517-4ce7-8a81-29e6cd108bb8	true	access.token.claim
809b7423-e517-4ce7-8a81-29e6cd108bb8	organization	claim.name
809b7423-e517-4ce7-8a81-29e6cd108bb8	String	jsonType.label
85a66399-2175-4491-895a-27f2606778be	true	introspection.token.claim
85a66399-2175-4491-895a-27f2606778be	true	userinfo.token.claim
85a66399-2175-4491-895a-27f2606778be	locale	user.attribute
85a66399-2175-4491-895a-27f2606778be	true	id.token.claim
85a66399-2175-4491-895a-27f2606778be	true	access.token.claim
85a66399-2175-4491-895a-27f2606778be	locale	claim.name
85a66399-2175-4491-895a-27f2606778be	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
c46dc488-1d5b-449e-886b-6024480d4e83	60	300	300	\N	\N	\N	t	f	0	\N	my-realm	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	8442a0ac-6e22-400c-8522-4ec51b254d40	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	7cafe6d9-4426-404a-854f-212d8928855b	fae5a460-39c0-4db4-b696-42041df68e23	faf98d32-9a03-42d4-b85f-2e9e73836316	42aa3994-fee4-4614-818d-5a262a4cf323	ee4a8493-bc20-4b12-b475-eefa2498904d	2592000	f	900	t	f	8d9c781c-e648-4939-9a2d-5886358d5405	0	f	0	0	b19d7be8-5220-43df-84cb-b87d7262cc8d
9810599f-a32f-4d69-893a-d08f7209a282	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	e781c0bf-0ec5-4947-b7c3-9112207b95ac	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	4ad25181-d2a5-4979-b7b2-a60b4790eb17	0d44f40b-036c-4368-954a-6881374181e3	b64a8500-a3d8-48be-8fc3-7a70ef74790a	90308637-d161-4ecb-8fe3-f8a72c6568f2	d4da58e8-894f-46fe-bff6-be2a5113a26b	2592000	f	900	t	f	b04b5094-9e27-418d-93fa-49af30201a5c	0	f	0	0	806a48f1-c68b-435d-9964-93f511494602
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	9810599f-a32f-4d69-893a-d08f7209a282	
_browser_header.xContentTypeOptions	9810599f-a32f-4d69-893a-d08f7209a282	nosniff
_browser_header.referrerPolicy	9810599f-a32f-4d69-893a-d08f7209a282	no-referrer
_browser_header.xRobotsTag	9810599f-a32f-4d69-893a-d08f7209a282	none
_browser_header.xFrameOptions	9810599f-a32f-4d69-893a-d08f7209a282	SAMEORIGIN
_browser_header.contentSecurityPolicy	9810599f-a32f-4d69-893a-d08f7209a282	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	9810599f-a32f-4d69-893a-d08f7209a282	1; mode=block
_browser_header.strictTransportSecurity	9810599f-a32f-4d69-893a-d08f7209a282	max-age=31536000; includeSubDomains
bruteForceProtected	9810599f-a32f-4d69-893a-d08f7209a282	false
permanentLockout	9810599f-a32f-4d69-893a-d08f7209a282	false
maxTemporaryLockouts	9810599f-a32f-4d69-893a-d08f7209a282	0
bruteForceStrategy	9810599f-a32f-4d69-893a-d08f7209a282	MULTIPLE
maxFailureWaitSeconds	9810599f-a32f-4d69-893a-d08f7209a282	900
minimumQuickLoginWaitSeconds	9810599f-a32f-4d69-893a-d08f7209a282	60
waitIncrementSeconds	9810599f-a32f-4d69-893a-d08f7209a282	60
quickLoginCheckMilliSeconds	9810599f-a32f-4d69-893a-d08f7209a282	1000
maxDeltaTimeSeconds	9810599f-a32f-4d69-893a-d08f7209a282	43200
failureFactor	9810599f-a32f-4d69-893a-d08f7209a282	30
realmReusableOtpCode	9810599f-a32f-4d69-893a-d08f7209a282	false
firstBrokerLoginFlowId	9810599f-a32f-4d69-893a-d08f7209a282	5c4623b3-25bc-4d04-83af-660bb9566e06
displayName	9810599f-a32f-4d69-893a-d08f7209a282	Keycloak
displayNameHtml	9810599f-a32f-4d69-893a-d08f7209a282	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	9810599f-a32f-4d69-893a-d08f7209a282	RS256
offlineSessionMaxLifespanEnabled	9810599f-a32f-4d69-893a-d08f7209a282	false
offlineSessionMaxLifespan	9810599f-a32f-4d69-893a-d08f7209a282	5184000
bruteForceProtected	c46dc488-1d5b-449e-886b-6024480d4e83	false
permanentLockout	c46dc488-1d5b-449e-886b-6024480d4e83	false
maxTemporaryLockouts	c46dc488-1d5b-449e-886b-6024480d4e83	0
bruteForceStrategy	c46dc488-1d5b-449e-886b-6024480d4e83	MULTIPLE
maxFailureWaitSeconds	c46dc488-1d5b-449e-886b-6024480d4e83	900
minimumQuickLoginWaitSeconds	c46dc488-1d5b-449e-886b-6024480d4e83	60
waitIncrementSeconds	c46dc488-1d5b-449e-886b-6024480d4e83	60
quickLoginCheckMilliSeconds	c46dc488-1d5b-449e-886b-6024480d4e83	1000
maxDeltaTimeSeconds	c46dc488-1d5b-449e-886b-6024480d4e83	43200
failureFactor	c46dc488-1d5b-449e-886b-6024480d4e83	30
realmReusableOtpCode	c46dc488-1d5b-449e-886b-6024480d4e83	false
defaultSignatureAlgorithm	c46dc488-1d5b-449e-886b-6024480d4e83	RS256
offlineSessionMaxLifespanEnabled	c46dc488-1d5b-449e-886b-6024480d4e83	false
offlineSessionMaxLifespan	c46dc488-1d5b-449e-886b-6024480d4e83	5184000
actionTokenGeneratedByAdminLifespan	c46dc488-1d5b-449e-886b-6024480d4e83	43200
oauth2DeviceCodeLifespan	c46dc488-1d5b-449e-886b-6024480d4e83	600
oauth2DevicePollingInterval	c46dc488-1d5b-449e-886b-6024480d4e83	5
webAuthnPolicyRpEntityName	c46dc488-1d5b-449e-886b-6024480d4e83	keycloak
webAuthnPolicySignatureAlgorithms	c46dc488-1d5b-449e-886b-6024480d4e83	ES256,RS256
webAuthnPolicyRpId	c46dc488-1d5b-449e-886b-6024480d4e83	
webAuthnPolicyAttestationConveyancePreference	c46dc488-1d5b-449e-886b-6024480d4e83	not specified
webAuthnPolicyAuthenticatorAttachment	c46dc488-1d5b-449e-886b-6024480d4e83	not specified
webAuthnPolicyRequireResidentKey	c46dc488-1d5b-449e-886b-6024480d4e83	not specified
webAuthnPolicyUserVerificationRequirement	c46dc488-1d5b-449e-886b-6024480d4e83	not specified
webAuthnPolicyCreateTimeout	c46dc488-1d5b-449e-886b-6024480d4e83	0
webAuthnPolicyAvoidSameAuthenticatorRegister	c46dc488-1d5b-449e-886b-6024480d4e83	false
webAuthnPolicyRpEntityNamePasswordless	c46dc488-1d5b-449e-886b-6024480d4e83	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	c46dc488-1d5b-449e-886b-6024480d4e83	ES256,RS256
webAuthnPolicyRpIdPasswordless	c46dc488-1d5b-449e-886b-6024480d4e83	
webAuthnPolicyAttestationConveyancePreferencePasswordless	c46dc488-1d5b-449e-886b-6024480d4e83	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	c46dc488-1d5b-449e-886b-6024480d4e83	not specified
webAuthnPolicyRequireResidentKeyPasswordless	c46dc488-1d5b-449e-886b-6024480d4e83	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	c46dc488-1d5b-449e-886b-6024480d4e83	not specified
webAuthnPolicyCreateTimeoutPasswordless	c46dc488-1d5b-449e-886b-6024480d4e83	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	c46dc488-1d5b-449e-886b-6024480d4e83	false
cibaBackchannelTokenDeliveryMode	c46dc488-1d5b-449e-886b-6024480d4e83	poll
cibaExpiresIn	c46dc488-1d5b-449e-886b-6024480d4e83	120
cibaInterval	c46dc488-1d5b-449e-886b-6024480d4e83	5
cibaAuthRequestedUserHint	c46dc488-1d5b-449e-886b-6024480d4e83	login_hint
parRequestUriLifespan	c46dc488-1d5b-449e-886b-6024480d4e83	60
firstBrokerLoginFlowId	c46dc488-1d5b-449e-886b-6024480d4e83	7ad11612-484f-4eac-8fdd-d8421e97bac9
shortVerificationUri	c46dc488-1d5b-449e-886b-6024480d4e83	
actionTokenGeneratedByUserLifespan.verify-email	c46dc488-1d5b-449e-886b-6024480d4e83	
actionTokenGeneratedByUserLifespan.idp-verify-account-via-email	c46dc488-1d5b-449e-886b-6024480d4e83	
actionTokenGeneratedByUserLifespan.reset-credentials	c46dc488-1d5b-449e-886b-6024480d4e83	
actionTokenGeneratedByUserLifespan.execute-actions	c46dc488-1d5b-449e-886b-6024480d4e83	
organizationsEnabled	c46dc488-1d5b-449e-886b-6024480d4e83	false
adminPermissionsEnabled	c46dc488-1d5b-449e-886b-6024480d4e83	false
verifiableCredentialsEnabled	c46dc488-1d5b-449e-886b-6024480d4e83	false
actionTokenGeneratedByUserLifespan	c46dc488-1d5b-449e-886b-6024480d4e83	1800
clientSessionIdleTimeout	c46dc488-1d5b-449e-886b-6024480d4e83	0
clientSessionMaxLifespan	c46dc488-1d5b-449e-886b-6024480d4e83	0
clientOfflineSessionIdleTimeout	c46dc488-1d5b-449e-886b-6024480d4e83	0
clientOfflineSessionMaxLifespan	c46dc488-1d5b-449e-886b-6024480d4e83	0
client-policies.profiles	c46dc488-1d5b-449e-886b-6024480d4e83	{"profiles":[]}
client-policies.policies	c46dc488-1d5b-449e-886b-6024480d4e83	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	c46dc488-1d5b-449e-886b-6024480d4e83	
_browser_header.xContentTypeOptions	c46dc488-1d5b-449e-886b-6024480d4e83	nosniff
_browser_header.referrerPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	no-referrer
_browser_header.xRobotsTag	c46dc488-1d5b-449e-886b-6024480d4e83	none
_browser_header.xFrameOptions	c46dc488-1d5b-449e-886b-6024480d4e83	SAMEORIGIN
_browser_header.contentSecurityPolicy	c46dc488-1d5b-449e-886b-6024480d4e83	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	c46dc488-1d5b-449e-886b-6024480d4e83	1; mode=block
_browser_header.strictTransportSecurity	c46dc488-1d5b-449e-886b-6024480d4e83	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
9810599f-a32f-4d69-893a-d08f7209a282	jboss-logging
c46dc488-1d5b-449e-886b-6024480d4e83	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	9810599f-a32f-4d69-893a-d08f7209a282
password	password	t	t	c46dc488-1d5b-449e-886b-6024480d4e83
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
3c64e277-a482-44d8-a8cf-0d4122b11488	/realms/master/account/*
afba78af-48c0-47e4-b27e-53b0e5ae124d	/realms/master/account/*
7b5bf83e-3ef5-4f42-898e-c9f607143aa0	/realms/my-realm/account/*
72dc3713-9065-401e-821e-3e0d9c21f6ac	/realms/my-realm/account/*
e3714741-c112-48ae-9166-c99d9b25a174	/admin/my-realm/console/*
419c054d-a05a-4d5f-8f3b-8654f86d8a82	http://sensor-manager-service:8080
c204d56a-263a-4c50-8489-45a040774637	http://172.21.0.6/auth/admin/*
c204d56a-263a-4c50-8489-45a040774637	http://192.168.1.68/auth/admin/*
c204d56a-263a-4c50-8489-45a040774637	/admin/master/console/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
9b1bae2f-bc29-4b4f-b820-dc5cfdacb370	VERIFY_EMAIL	Verify Email	9810599f-a32f-4d69-893a-d08f7209a282	t	f	VERIFY_EMAIL	50
846cd9e3-6dcb-47dc-9db5-f132d4e60fc1	UPDATE_PROFILE	Update Profile	9810599f-a32f-4d69-893a-d08f7209a282	t	f	UPDATE_PROFILE	40
7f12b3aa-b14a-432c-906e-c99c75caac3c	CONFIGURE_TOTP	Configure OTP	9810599f-a32f-4d69-893a-d08f7209a282	t	f	CONFIGURE_TOTP	10
cd789710-c861-4093-9f04-f665a45a327b	UPDATE_PASSWORD	Update Password	9810599f-a32f-4d69-893a-d08f7209a282	t	f	UPDATE_PASSWORD	30
9f965688-320d-4200-8099-a943031c23fe	TERMS_AND_CONDITIONS	Terms and Conditions	9810599f-a32f-4d69-893a-d08f7209a282	f	f	TERMS_AND_CONDITIONS	20
9683d4ce-da2b-4540-80df-4514dddbcdfc	delete_account	Delete Account	9810599f-a32f-4d69-893a-d08f7209a282	f	f	delete_account	60
73883c84-5c7c-4134-a20a-719f4c64fd21	delete_credential	Delete Credential	9810599f-a32f-4d69-893a-d08f7209a282	t	f	delete_credential	100
e83717ec-1ab7-43c7-adb7-15545b6be633	update_user_locale	Update User Locale	9810599f-a32f-4d69-893a-d08f7209a282	t	f	update_user_locale	1000
40a3fc19-4636-4cb9-a637-5ab51e0d46ad	webauthn-register	Webauthn Register	9810599f-a32f-4d69-893a-d08f7209a282	t	f	webauthn-register	70
d53e0ae4-74f4-4bca-afa8-a723eb2decdd	webauthn-register-passwordless	Webauthn Register Passwordless	9810599f-a32f-4d69-893a-d08f7209a282	t	f	webauthn-register-passwordless	80
0784f2d5-ad0d-4251-9929-3f3538e508e2	VERIFY_PROFILE	Verify Profile	9810599f-a32f-4d69-893a-d08f7209a282	t	f	VERIFY_PROFILE	90
ce514264-b3a1-458c-b14a-234288ef54dd	VERIFY_EMAIL	Verify Email	c46dc488-1d5b-449e-886b-6024480d4e83	t	f	VERIFY_EMAIL	50
4f952c68-196f-4958-9600-330e88bacdcf	UPDATE_PROFILE	Update Profile	c46dc488-1d5b-449e-886b-6024480d4e83	t	f	UPDATE_PROFILE	40
8af07eed-056e-405d-8dd7-89a1682a8f04	CONFIGURE_TOTP	Configure OTP	c46dc488-1d5b-449e-886b-6024480d4e83	t	f	CONFIGURE_TOTP	10
27ba3d4b-4eb4-464e-a72b-3164f6fc4bbd	UPDATE_PASSWORD	Update Password	c46dc488-1d5b-449e-886b-6024480d4e83	t	f	UPDATE_PASSWORD	30
d1b640cd-46e3-469b-a0e9-3777a4f3f1c3	TERMS_AND_CONDITIONS	Terms and Conditions	c46dc488-1d5b-449e-886b-6024480d4e83	f	f	TERMS_AND_CONDITIONS	20
199e0d09-b0a8-426b-a8b5-e85a89fbf566	delete_account	Delete Account	c46dc488-1d5b-449e-886b-6024480d4e83	f	f	delete_account	60
bc45aa75-0ea1-4727-9382-821a767a1d16	delete_credential	Delete Credential	c46dc488-1d5b-449e-886b-6024480d4e83	t	f	delete_credential	100
05d2ea08-4c1b-4905-b5a2-077f1ee9b616	update_user_locale	Update User Locale	c46dc488-1d5b-449e-886b-6024480d4e83	t	f	update_user_locale	1000
99926d9e-8ee1-4141-b51a-126a2ac7390f	webauthn-register	Webauthn Register	c46dc488-1d5b-449e-886b-6024480d4e83	t	f	webauthn-register	70
cb12e703-0e17-44a3-9326-9168d66e758f	webauthn-register-passwordless	Webauthn Register Passwordless	c46dc488-1d5b-449e-886b-6024480d4e83	t	f	webauthn-register-passwordless	80
c6ee853d-01d7-4031-9ec3-403ba80edece	VERIFY_PROFILE	Verify Profile	c46dc488-1d5b-449e-886b-6024480d4e83	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
419c054d-a05a-4d5f-8f3b-8654f86d8a82	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
651e2728-1029-499b-bdd1-b8d455ddf86e	Default Policy	A policy that grants access only for users within this realm	js	0	0	419c054d-a05a-4d5f-8f3b-8654f86d8a82	\N
cfb3c9bf-ad9f-41b5-b371-1619970b4ff1	Default Permission	A permission that applies to the default resource type	resource	1	0	419c054d-a05a-4d5f-8f3b-8654f86d8a82	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
79a461e9-ea7e-41d0-adb5-b40ac341107d	Default Resource	urn:kong:resources:default	\N	419c054d-a05a-4d5f-8f3b-8654f86d8a82	419c054d-a05a-4d5f-8f3b-8654f86d8a82	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
79a461e9-ea7e-41d0-adb5-b40ac341107d	/*
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
afba78af-48c0-47e4-b27e-53b0e5ae124d	a05a2481-7819-49ac-a97b-02c3b1488b00
afba78af-48c0-47e4-b27e-53b0e5ae124d	0bbf5b92-4383-478e-8868-76f84382a131
72dc3713-9065-401e-821e-3e0d9c21f6ac	da6c1463-3ada-4b4d-8860-6b18ffe49809
72dc3713-9065-401e-821e-3e0d9c21f6ac	3d2a6ddd-cf10-4002-8aa4-96571d9cdab6
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	63dd6689-287a-4742-bdb4-7f72f4776f30	5fe8f01c-fa3e-4bdc-ba02-5e4011659eb2	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
63dd6689-287a-4742-bdb4-7f72f4776f30	\N	16177ade-89f6-4619-adbb-af0f29b0da7f	f	t	\N	\N	\N	9810599f-a32f-4d69-893a-d08f7209a282	admin	1739149774545	\N	0
e34ec915-7b79-48a4-94e8-1eb1d3a3a113	\N	76a6ae57-6a5f-49c0-ab88-1e0fde04c6c7	f	t	\N	\N	\N	c46dc488-1d5b-449e-886b-6024480d4e83	service-account-kong	1739153999311	419c054d-a05a-4d5f-8f3b-8654f86d8a82	0
6c991c84-e0b6-47d2-9032-b42813e2ab61	superadmin@example.com	superadmin@example.com	f	t	\N	super	admin	9810599f-a32f-4d69-893a-d08f7209a282	superadmin	1739158594231	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
806a48f1-c68b-435d-9964-93f511494602	63dd6689-287a-4742-bdb4-7f72f4776f30
6474bb43-8c60-47da-b276-f151c38601ee	63dd6689-287a-4742-bdb4-7f72f4776f30
b19d7be8-5220-43df-84cb-b87d7262cc8d	e34ec915-7b79-48a4-94e8-1eb1d3a3a113
00656f6d-7338-4f00-b8cf-7f409b8d6ffe	e34ec915-7b79-48a4-94e8-1eb1d3a3a113
806a48f1-c68b-435d-9964-93f511494602	6c991c84-e0b6-47d2-9032-b42813e2ab61
6474bb43-8c60-47da-b276-f151c38601ee	6c991c84-e0b6-47d2-9032-b42813e2ab61
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
e3714741-c112-48ae-9166-c99d9b25a174	+
419c054d-a05a-4d5f-8f3b-8654f86d8a82	http://sensor-manager-service:8080
c204d56a-263a-4c50-8489-45a040774637	+
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

