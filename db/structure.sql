CREATE SCHEMA conciage;

CREATE SEQUENCE conciage.business_business_id_seq START WITH 1;

CREATE SEQUENCE conciage.categories_category_id_seq START WITH 1;

CREATE SEQUENCE conciage.categories_category_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.categories_category_id_seq2 START WITH 1;

CREATE SEQUENCE conciage.channels_human_interests_channel_id_seq START WITH 1;

CREATE SEQUENCE conciage.city_id_seq START WITH 1;

CREATE SEQUENCE conciage.city_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.country_id_seq START WITH 1;

CREATE SEQUENCE conciage.country_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.message_action_configuration_transaction_code_seq START WITH 1;

CREATE SEQUENCE conciage.message_action_configuration_transaction_code_seq1 START WITH 1;

CREATE SEQUENCE conciage.message_action_message_action_id_seq START WITH 1;

CREATE SEQUENCE conciage.message_action_message_action_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.message_analytics_messageanalytics_id_seq START WITH 1;

CREATE SEQUENCE conciage.message_analytics_messageanalytics_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.message_analytics_messageanalytics_id_seq2 START WITH 1;

CREATE SEQUENCE conciage.message_comments_message_comment_id_seq START WITH 1;

CREATE SEQUENCE conciage.message_comments_message_id_seq START WITH 1;

CREATE SEQUENCE conciage.message_curated_code_message_curatedcode_id_seq START WITH 1;

CREATE SEQUENCE conciage.message_curated_code_message_curatedcode_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.message_curated_code_message_curatedcode_id_seq2 START WITH 1;

CREATE SEQUENCE conciage.message_curation_curation_id_seq START WITH 1;

CREATE SEQUENCE conciage.message_curation_curation_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.message_curation_message_curation_id_seq START WITH 1;

CREATE SEQUENCE conciage.message_message_id_seq START WITH 1;

CREATE SEQUENCE conciage.message_message_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.message_message_id_seq2 START WITH 1;

CREATE SEQUENCE conciage.message_source_message_source_id_seq START WITH 1;

CREATE SEQUENCE conciage.message_source_message_source_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.message_source_message_source_id_seq2 START WITH 1;

CREATE SEQUENCE conciage.message_status_message_status_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.message_status_status_id_seq START WITH 1;

CREATE SEQUENCE conciage.places_category_id_seq START WITH 1;

CREATE SEQUENCE conciage.places_category_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.places_category_id_seq_001 START WITH 1;

CREATE SEQUENCE conciage.places_conciage_id_seq START WITH 1;

CREATE SEQUENCE conciage.places_place_id_seq START WITH 1;

CREATE SEQUENCE conciage.places_place_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.placescrawler_newadded_placescrawler_newadded_id_seq START WITH 1;

CREATE SEQUENCE conciage.state_id_seq START WITH 1;

CREATE SEQUENCE conciage.state_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.user_address_address_id_seq START WITH 1;

CREATE SEQUENCE conciage.user_details_address_id_seq START WITH 1;

CREATE SEQUENCE conciage.user_info_user_id_seq START WITH 1;

CREATE SEQUENCE conciage.user_info_user_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.user_info_user_id_seq2 START WITH 1;

CREATE SEQUENCE conciage.username_id_seq START WITH 1;

CREATE SEQUENCE conciage.username_id_seq1 START WITH 1;

CREATE SEQUENCE conciage.username_id_seq2 START WITH 1;

CREATE SEQUENCE conciage.zip_code_id_seq START WITH 1;

CREATE SEQUENCE conciage.zip_code_id_seq1 START WITH 1;

CREATE TABLE conciage.categories (
  category_id          serial  NOT NULL,
  parents              integer  ,
  en                   varchar(255)  ,
  de                   varchar(255)  ,
  es                   varchar(255)  ,
  fr                   varchar(255)  ,
  it                   varchar(255)  ,
  jp                   varchar(255)  ,
  kr                   varchar(255)  ,
  zh                   varchar(255)  ,
  zh_hant              varchar(255)  ,
  abstract             varchar(255)  ,
  CONSTRAINT pk_categories PRIMARY KEY ( category_id )
);

COMMENT ON TABLE conciage.categories IS 'This is a classification of all places. Factual�s Places are classified into 440 categories.\n\nThe categories are coarsely grained and will be familiar to most users of the Yellow Pages. The top level headings are :\nAutomotive\nCommunity and Government\nHealthcare\nLandmarks\nRetail\nServices and Supplies\nSocial\nSports and Recreation\nTransportation\nTravel \n\nThe standouts here are �Social� which is the parent category for all places where you meet people in small gatherings, such as bars and restaurants; �Transport Hubs� which include rail stations, airports and ports, and �Landmarks� which consist of generally non-business entities such as historic buildings, monuments and miscellaneous, but prominent, beacons used in real-world social navigation.\n\n\n';

CREATE TABLE conciage.categories_factual_to_mcc (
  mcc_code             integer  NOT NULL,
  mcc_label            varchar(300)  ,
  factual_category_id  integer
);

COMMENT ON TABLE conciage.categories_factual_to_mcc IS 'This table contains factual category IDs mapped to MCC . This is akin to business type but also matches the factual taxonomical grouping of placess which will be used to create the algorithmic classification instead of using keywords - places will be automatically calssified without the use of user netered keywords.\nA merchant category code (MCC) is a four-digit number assigned to a business by MasterCard or VISA when the business first starts accepting one of these cards as a form of payment.[1] The MCC is used to classify the business by the type of goods or services it provides. In the United States, it can be used to determine if a payment needs to be reported to the Internal Revenue Service for tax purposes.[2]';

CREATE TABLE conciage.country (
  id                   serial  NOT NULL,
  code                 varchar(2)  NOT NULL,
  name                 varchar(255)  NOT NULL,
  latitude             float8  ,
  longitude            float8  ,
  factual_id           varchar(50)  ,
  CONSTRAINT pk_country UNIQUE ( id )
);

CREATE INDEX idx_country_code ON conciage.country ( code );

CREATE INDEX idx_country_name ON conciage.country ( name );

CREATE TABLE conciage.error_log (
  error_log_id         bigint  NOT NULL,
  description          varchar(500)  ,
  error_log_date       timestamptz DEFAULT now() ,
  placescrawler_newadded_id bigint  ,
  CONSTRAINT pk_error_log PRIMARY KEY ( error_log_id ),
  CONSTRAINT pk_error_log_0 UNIQUE ( placescrawler_newadded_id )
);

COMMENT ON TABLE conciage.error_log IS 'A general log of all errors';

CREATE TABLE conciage.message_action (
  message_action_id    serial  NOT NULL,
  description          varchar(50)  ,
  CONSTRAINT pk_message_action PRIMARY KEY ( message_action_id )
);

COMMENT ON TABLE conciage.message_action IS 'This table houses the types of action items available. These are the action items that a business user will add so that the end user can interact with the message in the desired fashion e.g Purchase, Donate, RSVP, Claim ';

CREATE TABLE conciage.message_button (
  action_button_id     integer  NOT NULL,
  description          integer  ,
  CONSTRAINT pk_message_button PRIMARY KEY ( action_button_id )
);

CREATE TABLE conciage.message_button_configuration (
  message_id           integer  ,
  action_button_id     integer  ,
  minimum_quantity     integer  ,
  maximum_quantity     integer  ,
  created_datetime     timestamptz  ,
  cost                 numeric(12,2)
);

CREATE INDEX idx_message_button_configuration ON conciage.message_button_configuration ( action_button_id );

CREATE TABLE conciage.message_curated_code (
  message_curatedcode_id serial  NOT NULL,
  description          varchar(100)  ,
  CONSTRAINT pk_message_curated_code PRIMARY KEY ( message_curatedcode_id )
);

COMMENT ON TABLE conciage.message_curated_code IS 'This contains different statuses for messages - approved, duplicate, denied etc';

CREATE TABLE conciage.message_curation_status (
  curation_status_id   integer  NOT NULL,
  status               varchar(20)  ,
  CONSTRAINT pk_message_curation_status PRIMARY KEY ( curation_status_id )
);

COMMENT ON TABLE conciage.message_curation_status IS 'A message can be approved, declined, pending review e.t.c';

CREATE TABLE conciage.message_source (
  message_source_id    serial  NOT NULL,
  messagesource_name   varchar(200)  NOT NULL,
  CONSTRAINT pk_message_source PRIMARY KEY ( message_source_id )
);

COMMENT ON TABLE conciage.message_source IS 'The source of the message is noted here. The source will typically be automated  i.e via an API or web crawler/scraper or manual by the owner of the business profile or authorised user';

CREATE TABLE conciage.message_status (
  status_id            serial  NOT NULL,
  status_description   varchar(30)  ,
  CONSTRAINT pk_message_status PRIMARY KEY ( status_id )
);

COMMENT ON TABLE conciage.message_status IS 'A message can be either playing, paused, stopped or saved';

COMMENT ON COLUMN conciage.message_status.status_description IS 'A message can be saved, playing, paused, stopped';

CREATE TABLE conciage.places_category (
  id                   serial  NOT NULL,
  name                 varchar(255)  NOT NULL,
  parent_id            integer  ,
  factual_id           integer  ,
  factual_parent_id    integer  ,
  CONSTRAINT pk_places_category UNIQUE ( id )
);

COMMENT ON TABLE conciage.places_category IS 'Factual taxonomy category for that categorizes places of business http://developer.factual.com/working-with-categories/';

CREATE TABLE conciage.schema_migrations (
  version              varchar(255)  NOT NULL,
  CONSTRAINT unique_schema_migrations UNIQUE ( version )
);

CREATE TABLE conciage.state (
  id                   serial  NOT NULL,
  country_id           integer  NOT NULL,
  name                 varchar(255)  NOT NULL,
  latitude             float8  ,
  longitude            float8  ,
  factual_id           varchar(50)  ,
  factual_parent_id    varchar(50)  ,
  CONSTRAINT pk_state UNIQUE ( id )
);

CREATE INDEX idx_state_name ON conciage.state ( name );

CREATE TABLE conciage.subscription_email_list_ingest_name (
  ingest_id            bigint  NOT NULL,
  ingest_name          varchar(100)  ,
  CONSTRAINT pk_subscription_email_list_ingest_name PRIMARY KEY ( ingest_id )
);

COMMENT ON TABLE conciage.subscription_email_list_ingest_name IS 'This houses the custom name for each lsit ingested and or created by the user';

CREATE TABLE conciage.user_activity_type (
  activity_type_id     integer  NOT NULL,
  activity             varchar(30)  ,
  CONSTRAINT pk_user_activity_type PRIMARY KEY ( activity_type_id )
);

CREATE TABLE conciage.user_info (
  user_id              bigserial  NOT NULL,
  first_name           varchar(50)  ,
  middle_name          varchar(100)  ,
  last_name            varchar(50)  ,
  gender               char(1)  ,
  date_of_birth        timestamp  ,
  created              timestamptz DEFAULT current_timestamp ,
  verified             bool  ,
  photo                varchar(200)  ,
  mobile_number        bigint  ,
  time_zone            varchar(100)  ,
  web                  varchar(255)  ,
  phone                varchar(50)  ,
  bio                  varchar(200)  ,
  is_facebook          bool DEFAULT 'false' ,
  is_google            bool DEFAULT 'false' ,
  is_twitter           bool DEFAULT 'false' ,
  is_private           bool DEFAULT 'false' ,
  email                varchar(50)  ,
  encrypted_password   varchar(255) DEFAULT ''::character varying NOT NULL,
  reset_password_token varchar(255)  ,
  reset_password_sent_at timestamp  ,
  remember_created_at  timestamp  ,
  sign_in_count        integer DEFAULT 0 NOT NULL,
  current_sign_in_at   timestamp  ,
  last_sign_in_at      timestamp  ,
  current_sign_in_ip   varchar(255)  ,
  last_sign_in_ip      varchar(255)  ,
  confirmation_token   varchar(255)  ,
  confirmed_at         timestamp  ,
  confirmation_sent_at timestamp  ,
  unconfirmed_email    varchar(255)  ,
  failed_attempts      integer DEFAULT 0 NOT NULL,
  unlock_token         varchar(255)  ,
  locked_at            timestamp  ,
  created_at           timestamp  ,
  updated_at           timestamp  ,
  CONSTRAINT pk_user PRIMARY KEY ( user_id ),
  CONSTRAINT idx_user_info_on_confirmation_token UNIQUE ( confirmation_token ) ,
  CONSTRAINT idx_user_info_on_email UNIQUE ( email ) ,
  CONSTRAINT idx_user_info_on_reset_password_token UNIQUE ( reset_password_token ) ,
  CONSTRAINT idx_user_info_on_unlock_token UNIQUE ( unlock_token )
);

COMMENT ON TABLE conciage.user_info IS 'This is the primary user table that houses data retrieved when a user signs in via email address in addition to common data items from social media sign up';

COMMENT ON COLUMN conciage.user_info.is_facebook IS 'This flag indicates whether the user has signed up using facebook first. The default is false';

COMMENT ON COLUMN conciage.user_info.is_google IS 'This flag indicates whether the user has signed up using google first. The default is false';

COMMENT ON COLUMN conciage.user_info.is_twitter IS 'This flag indicates whether the user has signed up using twitter. The default is false';

COMMENT ON COLUMN conciage.user_info.is_private IS 'The user can designate his/her account and profile as private or public';

CREATE TABLE conciage.user_info_facebook (
  user_id              bigint  NOT NULL,
  uid                  varchar(255)  NOT NULL,
  image                varchar(255)  ,
  profile              varchar(255)  ,
  gender               varchar(255)  ,
  birthday             varchar(255)  ,
  locale               varchar(255)  ,
  location             varchar(255)  ,
  time_zone            varchar(255)  ,
  created_at           timestamp  ,
  updated_at           timestamp  ,
  CONSTRAINT pk_facebook_user_info PRIMARY KEY ( user_id ),
  CONSTRAINT idx_facebook_user_info_on_uid UNIQUE ( uid )
);

COMMENT ON TABLE conciage.user_info_facebook IS 'Socail media - facebook authentication';

CREATE TABLE conciage.user_info_google (
  user_id              bigint  NOT NULL,
  uid                  varchar(255)  NOT NULL,
  image                varchar(255)  ,
  profile              varchar(255)  ,
  gender               varchar(255)  ,
  birthday             varchar(255)  ,
  locale               varchar(255)  ,
  created_at           timestamp  ,
  updated_at           timestamp  ,
  CONSTRAINT pk_google_user_info PRIMARY KEY ( user_id ),
  CONSTRAINT idx_google_user_info_on_uid UNIQUE ( uid )
);

COMMENT ON TABLE conciage.user_info_google IS 'Socail media - google+ authentication';

CREATE TABLE conciage.user_info_twitter (
  user_id              bigint  NOT NULL,
  uid                  varchar(255)  NOT NULL,
  image                varchar(255)  ,
  location             varchar(255)  ,
  geo_enabled          bool DEFAULT false ,
  time_zone            varchar(255)  ,
  utc_offset           varchar(255)  ,
  created_at           timestamp  ,
  updated_at           timestamp  ,
  CONSTRAINT pk_twitter_user_info PRIMARY KEY ( user_id ),
  CONSTRAINT idx_twitter_user_info_on_uid UNIQUE ( uid )
);

COMMENT ON TABLE conciage.user_info_twitter IS 'Socail media - twitter authentication';

CREATE TABLE conciage.user_log_action (
  log_type_id          integer  NOT NULL,
  description          varchar(20)  ,
  CONSTRAINT pk_user_log_actions PRIMARY KEY ( log_type_id )
);

COMMENT ON TABLE conciage.user_log_action IS 'These are the type of user actions and interactions that are to be logged = password_reset, search, email verification, other';

CREATE TABLE conciage.user_notifications_email (
  userid               bigint  NOT NULL,
  email                bool  ,
  mentions             bool  ,
  new_mail             bool  ,
  CONSTRAINT pk_user_notification_type PRIMARY KEY ( userid )
);

COMMENT ON TABLE conciage.user_notifications_email IS 'Each user`s email notification configurations are stored here. The default is such that they recieve all notifications';

CREATE TABLE conciage.user_notifications_mobile (
  user_id              bigint  NOT NULL,
  mobile               bool  ,
  all_friends_activity bool  ,
  mentions_me          bool  ,
  new_notifications    bool  ,
  CONSTRAINT pk_usernotifications PRIMARY KEY ( user_id )
);

COMMENT ON TABLE conciage.user_notifications_mobile IS 'The user`s mobile notification configurations are stored here';

CREATE TABLE conciage.user_roles (
  role_id              integer  NOT NULL,
  rolename             varchar(50)  ,
  CONSTRAINT pk_user_roles PRIMARY KEY ( role_id )
);

COMMENT ON TABLE conciage.user_roles IS 'This table stores the various user types that can manage the tables';

CREATE TABLE conciage.zip_code (
  id                   serial  NOT NULL,
  country_id           integer  NOT NULL,
  name                 varchar(255)  NOT NULL,
  latitude             float8  ,
  longitude            float8  ,
  factual_id           varchar(50)  ,
  factual_parent_id    varchar(50)  ,
  CONSTRAINT pk_zip_code UNIQUE ( id )
);

CREATE INDEX idx_zip_code_name ON conciage.zip_code ( name );

CREATE TABLE conciage.city (
  id                   serial  NOT NULL,
  country_id           integer  NOT NULL,
  name                 varchar(255)  NOT NULL,
  latitude             float8  ,
  longitude            float8  ,
  factual_id           varchar(50)  ,
  factual_parent_id    varchar(50)  ,
  CONSTRAINT pk_city UNIQUE ( id )
);

CREATE INDEX idx_city_name ON conciage.city ( name );

CREATE TABLE conciage.hinge (
  hid                  bigint  NOT NULL,
  hid_name             varchar(200)  ,
  added_by             bigint  NOT NULL,
  verified_by          bigint  ,
  hinge_add_date       timestamptz  ,
  hinge_approval_date  timestamptz  ,
  CONSTRAINT pk_human_interests PRIMARY KEY ( hid )
);

CREATE INDEX idx_human_interests_engine ON conciage.hinge ( added_by );

CREATE INDEX idx_human_interests_engine_0 ON conciage.hinge ( verified_by );

COMMENT ON TABLE conciage.hinge IS 'This is table houses a list of all possible curated human interests ';

CREATE TABLE conciage.hinge_business_category (
  mcc_code             integer  NOT NULL,
  hid                  bigint  NOT NULL,
  creator_id           bigint  ,
  approver_id          bigint  ,
  created_date         timestamptz DEFAULT now() ,
  approval_date        timestamptz  ,
  CONSTRAINT pk_idx_hinge_business_category PRIMARY KEY ( mcc_code, hid )
);

CREATE INDEX idx_channels ON conciage.hinge_business_category ( creator_id );

CREATE INDEX idx_channels_0 ON conciage.hinge_business_category ( approver_id );

CREATE INDEX idx_business_category_hid ON conciage.hinge_business_category ( hid );

CREATE INDEX idx_business_category_hid_0 ON conciage.hinge_business_category ( mcc_code );

COMMENT ON TABLE conciage.hinge_business_category IS 'This table is a curated list of business categories matched with specific human interests from the human interest engine. For example, a coffe shop could potentially be associated be coffee drinking, live music, coffee tasting and lvie comedy';

CREATE TABLE conciage.places (
  place_id             bigserial  NOT NULL,
  factual_id           varchar(36)  ,
  name                 varchar(255)  ,
  address              varchar(255)  ,
  address_extended     varchar(255)  ,
  locality             varchar(255)  ,
  region               varchar(255)  ,
  postcode             varchar(255)  ,
  country              varchar(2)  ,
  neighbourhood        text  ,
  tel                  varchar(20)  ,
  fax                  varchar(20)  ,
  website              varchar(255)  ,
  latitude             float8  ,
  longitude            float8  ,
  chain_name           varchar(255)  ,
  post_town            varchar(255)  ,
  chain_id             varchar(36)  ,
  admin_region         varchar(255)  ,
  po_box               varchar(255)  ,
  hours_display        text  ,
  email                varchar(255)  ,
  email_sec            varchar(255)  ,
  category_ids         integer  ,
  category_labels      varchar(255)  ,
  claimedby            bigint  ,
  claimedbydate        date  ,
  business_description varchar(255)  ,
  business_logo        varchar(255)  ,
  ismissing            bool  ,
  added_by             bigint  ,
  date_added           timestamptz DEFAULT now() ,
  verified_by          bigint  ,
  verified_date        timestamptz  ,
  is_crawler           bool DEFAULT 'false' ,
  is_api               bool DEFAULT 'false' ,
  is_execution_place   bool  ,
  CONSTRAINT pk_places PRIMARY KEY ( place_id ),
  CONSTRAINT idx_places_1 UNIQUE ( category_ids )
);

CREATE INDEX idx_places ON conciage.places ( added_by );

CREATE INDEX idx_places_0 ON conciage.places ( verified_by );

COMMENT ON TABLE conciage.places IS 'ismissing - This notes records that have a fake factual_id that we generated because the place was not found in the places API\nconciage_id - This is global unique identifier';

COMMENT ON COLUMN conciage.places.place_id IS 'This is a global unique identifier for each recorded whether added from the places API or user added.';

COMMENT ON COLUMN conciage.places.added_by IS 'added_by, added_date - the date and user that adds this place';

COMMENT ON COLUMN conciage.places.date_added IS 'added_by, added_date - the date and user that adds this place';

COMMENT ON COLUMN conciage.places.verified_by IS 'the user that verifies crowdsourced additions and crawler additions';

COMMENT ON COLUMN conciage.places.verified_date IS 'the date and time the an authorised user verifies crowdsourced additions and crawler additions';

COMMENT ON COLUMN conciage.places.is_crawler IS 'place added via a crawler';

COMMENT ON COLUMN conciage.places.is_api IS 'place added via a API';

COMMENT ON COLUMN conciage.places.is_execution_place IS 'This is a place that has been added via the message execution location. The location was added during the manual creation of a message by a user';

CREATE TABLE conciage.places_polygon (
  root_place_id        bigint  NOT NULL,
  node_place_id        bigint  NOT NULL,
  CONSTRAINT pk_idx_places_polygon_root_node_place_id PRIMARY KEY ( root_place_id, node_place_id )
);

CREATE INDEX idx_places_polygon ON conciage.places_polygon ( root_place_id );

CREATE INDEX idx_places_polygon_0 ON conciage.places_polygon ( node_place_id );

COMMENT ON TABLE conciage.places_polygon IS 'This table denotes whether a palce is housed inside another place';

COMMENT ON COLUMN conciage.places_polygon.root_place_id IS 'This is the place id of the palce that houses another place';

COMMENT ON COLUMN conciage.places_polygon.node_place_id IS 'This is the place id of the place that is inside another place';

CREATE TABLE conciage.places_profile (
  places_id            bigint  NOT NULL,
  user_id              bigint  ,
  name                 varchar(255)  ,
  time_zone            varchar(255)  ,
  image                varchar(200)  ,
  business_type_code   integer  ,
  address_one          varchar(255)  ,
  address_two          varchar(255)  ,
  city_id              integer  ,
  state_id             integer  ,
  zip_id               integer  ,
  country_id           integer  ,
  bio                  varchar(255)  ,
  contact              varchar(200)  ,
  email                varchar(50)  ,
  tel                  varchar(20)  ,
  website              varchar(200)  ,
  created_date         timestamptz  ,
  isfacebookpersonal   bool DEFAULT 'false' ,
  isgooglepluspersonal bool DEFAULT 'false' ,
  istwitterpersonal    bool DEFAULT 'false' ,
  CONSTRAINT pk_place_profile PRIMARY KEY ( places_id )
);

CREATE INDEX pk_places_profile ON conciage.places_profile ( user_id );

CREATE INDEX idx_places_profile ON conciage.places_profile ( state_id );

CREATE INDEX idx_places_profile_0 ON conciage.places_profile ( country_id );

CREATE INDEX idx_places_profile_1 ON conciage.places_profile ( city_id );

CREATE INDEX idx_places_profile_2 ON conciage.places_profile ( zip_id );

COMMENT ON TABLE conciage.places_profile IS 'This is the business page profile';

COMMENT ON COLUMN conciage.places_profile.user_id IS 'The user that create`s this place profile';

COMMENT ON COLUMN conciage.places_profile.name IS 'The business profile name';

COMMENT ON COLUMN conciage.places_profile.image IS 'The path to the log image location';

COMMENT ON COLUMN conciage.places_profile.isfacebookpersonal IS 'use facebook personal login to share messages on facebook wall';

COMMENT ON COLUMN conciage.places_profile.isgooglepluspersonal IS 'use google plus personal login to share messages on wall. default is false';

COMMENT ON COLUMN conciage.places_profile.istwitterpersonal IS 'Use the already set up personal twitter account to post on behalf of the your business` twitter account. ';

CREATE TABLE conciage.places_profile_categories (
  places_id            bigint  NOT NULL,
  places_category_id   integer  NOT NULL,
  category_type        integer  NOT NULL,
  CONSTRAINT pk_idx_places_profile_categories PRIMARY KEY ( places_id, places_category_id )
);

CREATE INDEX idx_places_profile_categories_type ON conciage.places_profile_categories ( category_type );

COMMENT ON TABLE conciage.places_profile_categories IS 'Each place profile or business profile can only have upto 3 categories of business type assigned to it. These category types for each business or place profile are stored in this  junction table (places_profile(place_id) and places_categories(palce_categories_id which is tied to and references palces_category(id)))';

COMMENT ON COLUMN conciage.places_profile_categories.category_type IS 'When a business selects categories, this will be used to denote selected categories as primary, secondary or tertiary with values 1, 2 and 3';

CREATE TABLE conciage.places_profile_facebook (
  places_id            bigint  NOT NULL,
  CONSTRAINT pk_places_social_login PRIMARY KEY ( places_id )
);

COMMENT ON TABLE conciage.places_profile_facebook IS 'Store facebook login information for the place profile';

CREATE TABLE conciage.places_profile_franchise (
  franchise_id         bigint  NOT NULL,
  places_id            bigint  NOT NULL,
  added_datetime       timestamptz  ,
  added_by             bigint  ,
  verified_by          bigint  ,
  verification_date    timestamptz  ,
  CONSTRAINT pk_places_profile_franchise PRIMARY KEY ( franchise_id )
);

CREATE INDEX idx_places_profile_franchise ON conciage.places_profile_franchise ( places_id );

COMMENT ON TABLE conciage.places_profile_franchise IS 'A business/place can add another place, location or franchise to its business page such that it is able to send a broadcast/message directly to that location.';

COMMENT ON COLUMN conciage.places_profile_franchise.franchise_id IS 'This is the id of the added business';

COMMENT ON COLUMN conciage.places_profile_franchise.places_id IS 'This is the id of the place that added this place.';

CREATE TABLE conciage.places_profile_google (
  place_id             bigint  NOT NULL,
  CONSTRAINT pk_places_profile_google PRIMARY KEY ( place_id )
);

COMMENT ON TABLE conciage.places_profile_google IS 'Store google login information for the place profile';

CREATE TABLE conciage.places_profile_operating_hours (
  places_id            bigint  NOT NULL,
  CONSTRAINT pk_palces_operating_hours PRIMARY KEY ( places_id )
);

COMMENT ON TABLE conciage.places_profile_operating_hours IS 'What days and times the place of business is open';

CREATE TABLE conciage.places_profile_twitter (
  place_id             bigint  NOT NULL,
  CONSTRAINT pk_places_profile_twitter PRIMARY KEY ( place_id )
);

COMMENT ON TABLE conciage.places_profile_twitter IS 'Store twitter login information for the place profile';

CREATE TABLE conciage.subscription_email_list_ingest (
  ingest_id            bigint  NOT NULL,
  place_id             bigint  ,
  email_address        varchar(200)  ,
  ingest_date          timestamptz DEFAULT current_timestamp ,
  frist_name           varchar(50)  ,
  last_name            varchar(50)  ,
  middle_name          varchar(50)
);

CREATE INDEX idx_subscription_email_list_ingest ON conciage.subscription_email_list_ingest ( place_id );

CREATE INDEX idx_subscription_email_list_ingest_0 ON conciage.subscription_email_list_ingest ( ingest_id );

COMMENT ON TABLE conciage.subscription_email_list_ingest IS 'A business can upload their email list here. All email addresses int he lsit become automatic subscribers for that business/place';

CREATE TABLE conciage.subscription_hinge (
  hid                  bigint  NOT NULL,
  user_id              bigint  NOT NULL,
  subscription_date    timestamptz DEFAULT current_timestamp ,
  CONSTRAINT idx_subscription_human_interests_hid_userid PRIMARY KEY ( hid, user_id )
);

CREATE INDEX idx_subscription_human_interests ON conciage.subscription_hinge ( hid );

CREATE INDEX idx_subscription_human_interests_0 ON conciage.subscription_hinge ( user_id );

COMMENT ON TABLE conciage.subscription_hinge IS 'This is a record of all interest subscription by each user eitehr explicitly or via interacting with specific cards';

CREATE TABLE conciage.subscription_places (
  place_id             bigint  NOT NULL,
  user_id              bigint  NOT NULL,
  subscription_date    timestamptz DEFAULT current_timestamp ,
  CONSTRAINT idx_subscription_places_id_user_id PRIMARY KEY ( place_id, user_id )
);

CREATE INDEX idx_subscription_places ON conciage.subscription_places ( user_id );

CREATE INDEX idx_subscription_places_0 ON conciage.subscription_places ( place_id );

COMMENT ON TABLE conciage.subscription_places IS 'This table keepts track of all users that are following a particular business or place.  Email subscription and following denote the same activity. ';

CREATE TABLE conciage.user_address (
  address_id           bigserial  NOT NULL,
  user_id              bigint  ,
  alias_name           varchar(100)  ,
  city_id              integer  ,
  state_id             integer  ,
  zipcode_id           integer  ,
  country_id           integer  ,
  longitude            float8  ,
  latitude             float8  ,
  address_one          varchar(255)  ,
  address_two          varchar(255)  ,
  CONSTRAINT pk_user_address PRIMARY KEY ( address_id )
);

CREATE INDEX idx_user_address ON conciage.user_address ( user_id );

CREATE INDEX idx_user_address_0 ON conciage.user_address ( state_id );

CREATE INDEX idx_user_address_1 ON conciage.user_address ( country_id );

CREATE INDEX idx_user_address_2 ON conciage.user_address ( zipcode_id );

CREATE INDEX idx_user_address_3 ON conciage.user_address ( city_id );

CREATE TABLE conciage.user_authenticate (
  user_id              bigint  NOT NULL,
  pass                 char(40)  NOT NULL,
  is_reset             bool  ,
  CONSTRAINT pk_user_authenticate PRIMARY KEY ( user_id )
);

CREATE TABLE conciage.user_log (
  log_id               bigint  NOT NULL,
  user_id              bigint  ,
  log_type_id          integer  ,
  description          varchar(300)  ,
  device               varchar(200)  ,
  user_agent           varchar(200)  ,
  ipaddress            varchar(16)  ,
  macaddress           varchar(50)  ,
  logdate              timestamptz DEFAULT current_timestamp ,
  CONSTRAINT pk_user_log PRIMARY KEY ( log_id )
);

CREATE INDEX idx_user_log ON conciage.user_log ( user_id );

CREATE INDEX idx_user_log_0 ON conciage.user_log ( log_type_id );

COMMENT ON TABLE conciage.user_log IS 'The logging table logs all type of internal activity like errors, account and configuration changes etc. The log types can be is_private (account change to private), password_reset, verified e.t.c';

CREATE TABLE conciage.user_roles_assignment (
  role_id              integer  NOT NULL,
  user_id              bigint  NOT NULL,
  place_id             bigint  NOT NULL,
  CONSTRAINT idx_user_roles_assignment_composite_prim PRIMARY KEY ( role_id, user_id, place_id )
);

CREATE INDEX idx_user_roles_assignment_0 ON conciage.user_roles_assignment ( place_id );

CREATE INDEX idx_user_roles_assignment_1 ON conciage.user_roles_assignment ( role_id );

CREATE INDEX idx_user_roles_assignment ON conciage.user_roles_assignment ( user_id );

COMMENT ON TABLE conciage.user_roles_assignment IS 'A composite key comprising of the role_id, user_id and place_id forms the primary key';

CREATE TABLE conciage.username (
  id                   bigserial  NOT NULL,
  username             varchar(50)  NOT NULL,
  user_id              bigint  ,
  places_id            bigint  ,
  created_at           timestamp  ,
  updated_at           timestamp  ,
  CONSTRAINT pk_username PRIMARY KEY ( id ),
  CONSTRAINT idx_username_on_username UNIQUE ( username )
);

CREATE INDEX idx_username_on_business_id ON conciage.username ( places_id );

CREATE INDEX idx_username_on_user_id ON conciage.username ( user_id );

COMMENT ON TABLE conciage.username IS 'The username is unique for all places of businesses and users. The user_id and business_id attributes clarify whether the id is a user or business';

CREATE TABLE conciage.message (
  message_id           bigserial  NOT NULL,
  user_id              bigint  ,
  profile_places_id    bigint  ,
  created_datetime     timestamptz DEFAULT current_timestamp ,
  message_image        varchar(500)  ,
  description          varchar(500)  NOT NULL,
  isfacebookshare      bool DEFAULT 'true' ,
  isgoogleplusshare    bool DEFAULT 'true' ,
  istwittershare       bool  ,
  is_sold_out          bool DEFAULT 'false' ,
  is_saved             bool DEFAULT 'false' ,
  message_status_id    integer  ,
  message_type         char(1) DEFAULT 'M'::bpchar ,
  lattitude            float8  ,
  longitude            float8  ,
  places_id_execution  bigint  ,
  action_button_id     integer  ,
  crawl_insert_date    timestamptz DEFAULT current_timestamp ,
  api_insert_date      timestamptz  ,
  source_name          varchar(255)  ,
  source_url           varchar(255)  ,
  start_date           date  ,
  end_date             date  ,
  frequency            char(1)  ,
  message_source_id    integer  ,
  CONSTRAINT pk_message_0 PRIMARY KEY ( message_id )
);

CREATE INDEX idx_message ON conciage.message ( user_id );

CREATE INDEX idx_message_1 ON conciage.message ( action_button_id );

CREATE INDEX idx_message_2 ON conciage.message ( places_id_execution );

CREATE INDEX idx_message_3 ON conciage.message ( message_status_id );

CREATE INDEX idx_message_0 ON conciage.message ( message_source_id );

COMMENT ON TABLE conciage.message IS 'This table stores all records pertining to a message that is being broadcast to users.\n\nMessages can be created by the business user for now and additionally by the crawler or sourced from an API ';

COMMENT ON COLUMN conciage.message.profile_places_id IS 'Business page profile id that is creating this message';

COMMENT ON COLUMN conciage.message.message_image IS 'Thsi is the path where the image for the message is stored';

COMMENT ON COLUMN conciage.message.description IS 'This is a 200 character description of the message. We will allow upto 500 characters to be inserted by crawlers and API automated message types however these have to be curated for proper rendering on digital cards which reinforces the 200 character limit';

COMMENT ON COLUMN conciage.message.is_saved IS 'A message can be saved upon creation';

COMMENT ON COLUMN conciage.message.message_status_id IS 'A message can be sold out, playing, paused, stopped e.t.c';

COMMENT ON COLUMN conciage.message.message_type IS 'a message can be classified as a social incentive or money saving incentive - s for social incetives and m for money saving';

COMMENT ON COLUMN conciage.message.places_id_execution IS 'This is the exact place where the message will be executed/occur. This location can be different from the home location of the business. If a palce id, exists then the address will be derived from there otherwise the user can enter the address and name into the new place form';

COMMENT ON COLUMN conciage.message.action_button_id IS 'This is a call to action button for user interaction. Purchase, claim, buy, donate, RSVP are some options';

COMMENT ON COLUMN conciage.message.crawl_insert_date IS 'Crawler insert date';

COMMENT ON COLUMN conciage.message.api_insert_date IS 'API insert date';

COMMENT ON COLUMN conciage.message.source_name IS 'This is the web address and source of the  message';

CREATE TABLE conciage.message_action_configuration (
  message_id           bigint  NOT NULL,
  user_id              bigint  NOT NULL,
  message_action_id    integer  NOT NULL,
  price                numeric(12,2)  ,
  max_quantity         integer  ,
  transaction_code     bigserial  NOT NULL,
  action_date_time     timestamptz DEFAULT now() NOT NULL,
  CONSTRAINT idx_message_action_configuration PRIMARY KEY ( message_id, user_id )
);

CREATE INDEX idx_message_action_configuration_0 ON conciage.message_action_configuration ( message_id );

CREATE INDEX idx_message_action_configuration_1 ON conciage.message_action_configuration ( user_id );

CREATE INDEX idx_message_action_configuration_2 ON conciage.message_action_configuration ( message_action_id );

COMMENT ON TABLE conciage.message_action_configuration IS 'Stores the running values for an action item added to a message e.g purchase,donate, RSVP,claim ';

COMMENT ON COLUMN conciage.message_action_configuration.transaction_code IS 'This is a unique code generated to ientify the users action';

CREATE TABLE conciage.message_analytics (
  messageanalytics_id  bigserial  NOT NULL,
  message_id           bigint  NOT NULL,
  user_id              bigint  ,
  engagement_time      timestamptz  ,
  sharer_id            bigint  ,
  shared_to            varchar(255)  ,
  ipaddress            varchar(20)  ,
  macaddress           varchar(100)  ,
  user_agent           varchar(50)  ,
  device               varchar(50)  ,
  facebookuser_id      varchar(50)  ,
  facebook_shares      integer  ,
  googleplus           integer  ,
  tweets               integer  ,
  reach                integer  ,
  frequency            integer  ,
  impressions          integer  ,
  CONSTRAINT pk_message_analytics PRIMARY KEY ( messageanalytics_id )
);

CREATE INDEX idx_message_analytics ON conciage.message_analytics ( user_id );

CREATE INDEX idx_message_analytics_0 ON conciage.message_analytics ( message_id );

CREATE INDEX idx_message_analytics_1 ON conciage.message_analytics ( sharer_id );

COMMENT ON COLUMN conciage.message_analytics.reach IS 'The number of people that have viewed the message';

COMMENT ON COLUMN conciage.message_analytics.frequency IS 'How many times the message is being viewed on average';

COMMENT ON COLUMN conciage.message_analytics.impressions IS 'frequency and reach of the message';

CREATE TABLE conciage.message_curated (
  message_id           bigint  NOT NULL,
  message_curated_code_id integer  ,
  user_id              bigint  ,
  comments             varchar(500)  ,
  curated_time         timestamptz DEFAULT current_timestamp ,
  CONSTRAINT pk_message_curated PRIMARY KEY ( message_id )
);

CREATE INDEX idx_message_curated ON conciage.message_curated ( message_curated_code_id );

CREATE INDEX idx_message_curated_0 ON conciage.message_curated ( user_id );

COMMENT ON TABLE conciage.message_curated IS 'This table stores information on messages thave have been curated and approved for publishing and broadcasting';

COMMENT ON COLUMN conciage.message_curated.curated_time IS 'The approzimated time the message was curated';

CREATE TABLE conciage.message_curation (
  curation_id          serial  NOT NULL,
  message_id           bigint  ,
  curator_id           bigint  ,
  curate_date          timestamptz DEFAULT current_timestamp ,
  comments             varchar(200)  ,
  curation_status_id   integer  NOT NULL,
  CONSTRAINT pk_message_curation PRIMARY KEY ( curation_id )
);

CREATE INDEX idx_message_curation ON conciage.message_curation ( curation_status_id );

CREATE INDEX idx_message_curation_0 ON conciage.message_curation ( message_id );

CREATE INDEX idx_message_curation_1 ON conciage.message_curation ( curator_id );

COMMENT ON TABLE conciage.message_curation IS 'This table houses data pertinent to message curation';

COMMENT ON COLUMN conciage.message_curation.curation_id IS 'A unique identifier for each curation';

COMMENT ON COLUMN conciage.message_curation.curator_id IS 'The user id that interacts with the message determine if its approved for publishing';

COMMENT ON COLUMN conciage.message_curation.comments IS 'The curator`s comments if needed.';

COMMENT ON COLUMN conciage.message_curation.curation_status_id IS 'This status id references a curation status in curation_status table';

CREATE TABLE conciage.user_activity (
  user_activity_id     bigint  NOT NULL,
  user_id              bigint  ,
  other_user           bigint  ,
  activity_type_id     integer  ,
  activity_date        timestamptz DEFAULT current_timestamp ,
  message_id           bigint  ,
  narrative            varchar(50)  ,
  CONSTRAINT pk_user_activity PRIMARY KEY ( user_activity_id )
);

CREATE INDEX idx_user_activity ON conciage.user_activity ( user_id );

CREATE INDEX idx_user_activity_0 ON conciage.user_activity ( other_user );

CREATE INDEX idx_user_activity_1 ON conciage.user_activity ( activity_type_id );

CREATE INDEX idx_user_activity_2 ON conciage.user_activity ( message_id );

COMMENT ON TABLE conciage.user_activity IS 'This keeps strack of user activities like shares, tags, likes and displays this information on their activity feed and friends feed';

CREATE TABLE conciage.hinge_message (
  message_id           bigint  NOT NULL,
  hid                  bigint  NOT NULL,
  CONSTRAINT idx_hinge_message_hid_message_id PRIMARY KEY ( message_id, hid )
);

CREATE INDEX idx_channels_message_0 ON conciage.hinge_message ( message_id );

CREATE INDEX idx_channels_message ON conciage.hinge_message ( hid );

COMMENT ON TABLE conciage.hinge_message IS 'This table contains the list of all channels/human interest areas that are associated with each message created. The business will be able to add channels in addition to the ones that will show by default from the hinge_business_category_hinge table';

ALTER TABLE conciage.city ADD CONSTRAINT fk_city_country FOREIGN KEY ( country_id ) REFERENCES conciage.country( id );

ALTER TABLE conciage.hinge ADD CONSTRAINT fk_human_interests_engine_added_by FOREIGN KEY ( added_by ) REFERENCES conciage.user_info_twitter( user_id );

ALTER TABLE conciage.hinge ADD CONSTRAINT fk_human_interests_engine FOREIGN KEY ( verified_by ) REFERENCES conciage.user_info_twitter( user_id );

ALTER TABLE conciage.hinge_business_category ADD CONSTRAINT fk_channels_user FOREIGN KEY ( creator_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.hinge_business_category ADD CONSTRAINT fk_channels_user_approverid FOREIGN KEY ( approver_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.hinge_business_category ADD CONSTRAINT fk_business_category_hid FOREIGN KEY ( hid ) REFERENCES conciage.hinge( hid );

ALTER TABLE conciage.hinge_message ADD CONSTRAINT fk_channels_message_messageid FOREIGN KEY ( message_id ) REFERENCES conciage.message( message_id );

ALTER TABLE conciage.hinge_message ADD CONSTRAINT fk_channels_message_hid FOREIGN KEY ( hid ) REFERENCES conciage.hinge( hid );

ALTER TABLE conciage.message ADD CONSTRAINT fk_message_user FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.message ADD CONSTRAINT fk_message_message_action FOREIGN KEY ( action_button_id ) REFERENCES conciage.message_action( message_action_id );

ALTER TABLE conciage.message ADD CONSTRAINT fk_message_places_id FOREIGN KEY ( places_id_execution ) REFERENCES conciage.places( place_id );

ALTER TABLE conciage.message ADD CONSTRAINT fk_message_message_status FOREIGN KEY ( message_status_id ) REFERENCES conciage.message_status( status_id );

ALTER TABLE conciage.message ADD CONSTRAINT fk_message_message_source_id FOREIGN KEY ( message_source_id ) REFERENCES conciage.message_source( message_source_id );

ALTER TABLE conciage.message_action_configuration ADD CONSTRAINT fk_message_action_configuration FOREIGN KEY ( message_id ) REFERENCES conciage.message( message_id );

ALTER TABLE conciage.message_action_configuration ADD CONSTRAINT fk_message_action_configuration_user_id FOREIGN KEY ( user_id ) REFERENCES conciage.user_info_twitter( user_id );

ALTER TABLE conciage.message_action_configuration ADD CONSTRAINT fk_message_action_configuration_message_action_id FOREIGN KEY ( message_action_id ) REFERENCES conciage.message_action( message_action_id );

ALTER TABLE conciage.message_analytics ADD CONSTRAINT fk_message_analytics_message FOREIGN KEY ( message_id ) REFERENCES conciage.message( message_id );

ALTER TABLE conciage.message_analytics ADD CONSTRAINT fk_message_analytics_user_userid FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.message_analytics ADD CONSTRAINT fk_message_analytics_user_sharerid FOREIGN KEY ( sharer_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.message_button_configuration ADD CONSTRAINT fk_message_button_configuration_action_button_id FOREIGN KEY ( action_button_id ) REFERENCES conciage.message_button( action_button_id );

ALTER TABLE conciage.message_curated ADD CONSTRAINT fk_message_curated_curated_code FOREIGN KEY ( message_curated_code_id ) REFERENCES conciage.message_curated_code( message_curatedcode_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.message_curated ADD CONSTRAINT fk_message_curated_user_info FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.message_curated ADD CONSTRAINT fk_message_curated_message FOREIGN KEY ( message_id ) REFERENCES conciage.message( message_id );

ALTER TABLE conciage.message_curation ADD CONSTRAINT fk_message_curation_status_id FOREIGN KEY ( curation_status_id ) REFERENCES conciage.message_curation_status( curation_status_id );

ALTER TABLE conciage.message_curation ADD CONSTRAINT fk_message_curation_message_id FOREIGN KEY ( message_id ) REFERENCES conciage.message( message_id );

ALTER TABLE conciage.message_curation ADD CONSTRAINT fk_message_curation_user_info FOREIGN KEY ( curator_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.places ADD CONSTRAINT fk_places_user FOREIGN KEY ( claimedby ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.places ADD CONSTRAINT fk_places_added_by FOREIGN KEY ( added_by ) REFERENCES conciage.user_info( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.places ADD CONSTRAINT fk_places_verified_by FOREIGN KEY ( verified_by ) REFERENCES conciage.user_info( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.places_polygon ADD CONSTRAINT fk_places_polygon_places_root_place_id FOREIGN KEY ( root_place_id ) REFERENCES conciage.places( place_id );

ALTER TABLE conciage.places_polygon ADD CONSTRAINT fk_places_polygon_places_node_place_id FOREIGN KEY ( node_place_id ) REFERENCES conciage.places( place_id );

ALTER TABLE conciage.places_profile ADD CONSTRAINT fk_places_profile_places_id FOREIGN KEY ( places_id ) REFERENCES conciage.places( place_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.places_profile ADD CONSTRAINT fk_places_profile_state FOREIGN KEY ( state_id ) REFERENCES conciage.state( id );

ALTER TABLE conciage.places_profile ADD CONSTRAINT fk_places_profile_country FOREIGN KEY ( country_id ) REFERENCES conciage.country( id );

ALTER TABLE conciage.places_profile ADD CONSTRAINT fk_places_profile_city FOREIGN KEY ( city_id ) REFERENCES conciage.city( id );

ALTER TABLE conciage.places_profile ADD CONSTRAINT fk_places_profile_zip_code FOREIGN KEY ( zip_id ) REFERENCES conciage.zip_code( id );

ALTER TABLE conciage.places_profile ADD CONSTRAINT fk_places_profile_user_info_user_id FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.places_profile_categories ADD CONSTRAINT fk_places_profile_categories_places_id FOREIGN KEY ( places_id ) REFERENCES conciage.places_profile( places_id );

ALTER TABLE conciage.places_profile_categories ADD CONSTRAINT fk_places_profile_categories FOREIGN KEY ( places_category_id ) REFERENCES conciage.places_category( id );

ALTER TABLE conciage.places_profile_facebook ADD CONSTRAINT fk_places_social_login FOREIGN KEY ( places_id ) REFERENCES conciage.places_profile( places_id );

ALTER TABLE conciage.places_profile_franchise ADD CONSTRAINT fk_places_profile_franchise_places_id FOREIGN KEY ( places_id ) REFERENCES conciage.places_profile( places_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.places_profile_google ADD CONSTRAINT fk_places_profile_google FOREIGN KEY ( place_id ) REFERENCES conciage.places_profile( places_id );

ALTER TABLE conciage.places_profile_operating_hours ADD CONSTRAINT fk_places_operating_hours_places_id FOREIGN KEY ( places_id ) REFERENCES conciage.places_profile( places_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.places_profile_twitter ADD CONSTRAINT fk_places_profile_twitter FOREIGN KEY ( place_id ) REFERENCES conciage.places_profile( places_id );

ALTER TABLE conciage.state ADD CONSTRAINT fk_state_country FOREIGN KEY ( country_id ) REFERENCES conciage.country( id );

ALTER TABLE conciage.subscription_email_list_ingest ADD CONSTRAINT fk_subscription_email_list_ingest FOREIGN KEY ( place_id ) REFERENCES conciage.places_profile( places_id );

ALTER TABLE conciage.subscription_email_list_ingest ADD CONSTRAINT fk_subscription_email_list_ingest_ingest_id FOREIGN KEY ( ingest_id ) REFERENCES conciage.subscription_email_list_ingest_name( ingest_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.subscription_hinge ADD CONSTRAINT fk_subscription_human_interests FOREIGN KEY ( hid ) REFERENCES conciage.hinge( hid );

ALTER TABLE conciage.subscription_hinge ADD CONSTRAINT fk_subscription_human_interests_0 FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.subscription_places ADD CONSTRAINT fk_subscription_places FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.subscription_places ADD CONSTRAINT fk_subscription_places_places FOREIGN KEY ( place_id ) REFERENCES conciage.places( place_id );

ALTER TABLE conciage.user_activity ADD CONSTRAINT fk_user_activity_user_id FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.user_activity ADD CONSTRAINT fk_user_activity_other_user FOREIGN KEY ( other_user ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.user_activity ADD CONSTRAINT fk_user_activity FOREIGN KEY ( activity_type_id ) REFERENCES conciage.user_activity_type( activity_type_id );

ALTER TABLE conciage.user_activity ADD CONSTRAINT fk_user_activity_0 FOREIGN KEY ( message_id ) REFERENCES conciage.message( message_id );

ALTER TABLE conciage.user_address ADD CONSTRAINT fk_user_address_user_info FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.user_address ADD CONSTRAINT fk_user_address_state FOREIGN KEY ( state_id ) REFERENCES conciage.state( id );

ALTER TABLE conciage.user_address ADD CONSTRAINT fk_user_address_country FOREIGN KEY ( country_id ) REFERENCES conciage.country( id );

ALTER TABLE conciage.user_address ADD CONSTRAINT fk_user_address_zip_code FOREIGN KEY ( zipcode_id ) REFERENCES conciage.zip_code( id );

ALTER TABLE conciage.user_address ADD CONSTRAINT fk_user_address_city FOREIGN KEY ( city_id ) REFERENCES conciage.city( id );

ALTER TABLE conciage.user_authenticate ADD CONSTRAINT fk_user_authenticate_user_id FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.user_info_facebook ADD CONSTRAINT fk_facebook_user_info_user_info FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id ) ON DELETE CASCADE;

ALTER TABLE conciage.user_info_google ADD CONSTRAINT fk_google_user_info_user_info FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id ) ON DELETE CASCADE;

ALTER TABLE conciage.user_info_twitter ADD CONSTRAINT fk_twitter_user_info_user_info FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id ) ON DELETE CASCADE;

ALTER TABLE conciage.user_log ADD CONSTRAINT fk_user_log FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.user_log ADD CONSTRAINT fk_user_log_log_type_id FOREIGN KEY ( log_type_id ) REFERENCES conciage.user_log_action( log_type_id );

ALTER TABLE conciage.user_notifications_email ADD CONSTRAINT fk_user_notifications_email FOREIGN KEY ( userid ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.user_notifications_mobile ADD CONSTRAINT fk_usernotifications_user FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id );

ALTER TABLE conciage.user_roles_assignment ADD CONSTRAINT fk_user_roles_assignment_place_id FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.user_roles_assignment ADD CONSTRAINT fk_user_roles_assignment FOREIGN KEY ( place_id ) REFERENCES conciage.places( place_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.user_roles_assignment ADD CONSTRAINT fk_user_roles_assignment_role_id FOREIGN KEY ( role_id ) REFERENCES conciage.user_roles( role_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.username ADD CONSTRAINT fk_username_user_info FOREIGN KEY ( user_id ) REFERENCES conciage.user_info( user_id ) ON DELETE CASCADE;

ALTER TABLE conciage.username ADD CONSTRAINT fk_username_places_id FOREIGN KEY ( places_id ) REFERENCES conciage.places_profile( places_id ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE conciage.zip_code ADD CONSTRAINT fk_zip_code_country FOREIGN KEY ( country_id ) REFERENCES conciage.country( id );
