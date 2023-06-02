## Course Code for [Building Full stack application with NextJs 13+](https://www.udemy.com/course/fullstack-nextjs-13-recoil-supabase)

## Handing supabase migration with migra tool

- https://supabase.com/blog/supabase-cli#migrations

# requirements

- read: https://supabase.com/blog/supabase-cli#migrations
- install: docker
- pull image: docker pull djrobstep/migra
- add file github action: migrate.yaml

# steps supabase

- create two projects  dev & prod
- download anon_key  & db_url from both projects
- sdfd **Settings -> Database**
- create table "public.flyway_schema_history" at production database using  supabase sql editor, you could find at the folder's script the definicion for this table.

# flyway migration naming conventions

- V1__description.sql => V-version
- U1__description.sql => U- undo
- R1_description.sql => R-repeateable migration

# steps migration with migra

at integrated terminal set:

- alias migra="docker run djrobstep/migra migra"
- migra  [db_url_target] [db_url_from] --unsafe  > file_name.sql
- db_url_from can find it at **Settings -> Database**
- file_name.sql  must follow flyway naming convesion.
- example cmd :

  - migra postgresql://postgres:[YOUR-PASSWORD-PROD]@db.[ID_DATABASE_TARGET].supabase.co:5432/postgres postgresql://postgres:[YOUR-PASSWORD-DEV]@db.[ID_DATABASE_FROM].supabase.co:5432/postgres --unsafe  > migrations/V1__getting_started_from_dev.sql

# Github actions

set up password secret & ID_DATABASE_FROM need by migrate.yaml

- -password="${{ secrets.PRODUCTION_DB_PASSWORD }}"
- SUPABASE_HOST: db.[ID_DATABASE_TARGET].supabase.co

any push to main will trigger the migration job.
