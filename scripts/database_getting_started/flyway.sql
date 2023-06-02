/*
    table flyway_schema_history intended to register all migrations following naming convention
*/
create table
  public.flyway_schema_history (
    installed_rank integer not null,
    version character varying(50) null,
    description character varying(200) not null,
    type character varying(20) not null,
    script character varying(1000) not null,
    checksum integer null,
    installed_by character varying(100) not null,
    installed_on timestamp without time zone not null default now(),
    execution_time integer not null,
    success boolean not null,
    constraint flyway_schema_history_pk primary key (installed_rank)
  ) tablespace pg_default;

create index if not exists flyway_schema_history_s_idx on public.flyway_schema_history using btree (success) tablespace pg_default;