drop index if exists "auth"."idx_user_id_auth_method";

create table "public"."order_detail" (
    "id" bigint generated by default as identity not null,
    "order_id" bigint,
    "product_items" jsonb,
    "shipping_address" text,
    "mobile_number" text,
    "created_at" timestamp with time zone default (now() AT TIME ZONE 'utc'::text)
);


alter table "public"."order_detail" enable row level security;

create table "public"."orders" (
    "id" bigint generated by default as identity not null,
    "user_id" uuid,
    "order_number" text,
    "state" text,
    "amount" text,
    "delivery_date" text,
    "created_at" text
);


alter table "public"."orders" enable row level security;

create table "public"."product_deals" (
    "id" integer generated by default as identity not null,
    "product_id" bigint,
    "deals" text
);


alter table "public"."product_deals" enable row level security;

create table "public"."products" (
    "id" bigint generated by default as identity not null,
    "code" text,
    "name" text,
    "description" text,
    "image" text,
    "path" text,
    "price" text,
    "category" text,
    "quantity" text,
    "inventory_status" text,
    "rating" text
);


alter table "public"."products" enable row level security;

create table "public"."todos" (
    "id" bigint generated by default as identity not null,
    "user_id" uuid not null,
    "task" text,
    "is_complete" boolean default false,
    "inserted_at" timestamp with time zone not null default timezone('utc'::text, now())
);


alter table "public"."todos" enable row level security;

CREATE UNIQUE INDEX order_detail_pkey ON public.order_detail USING btree (id);

CREATE UNIQUE INDEX orders_pkey ON public.orders USING btree (id);

CREATE UNIQUE INDEX product_deals_pkey ON public.product_deals USING btree (id);

CREATE UNIQUE INDEX products_pkey ON public.products USING btree (id);

CREATE UNIQUE INDEX todos_pkey ON public.todos USING btree (id);

alter table "public"."order_detail" add constraint "order_detail_pkey" PRIMARY KEY using index "order_detail_pkey";

alter table "public"."orders" add constraint "orders_pkey" PRIMARY KEY using index "orders_pkey";

alter table "public"."product_deals" add constraint "product_deals_pkey" PRIMARY KEY using index "product_deals_pkey";

alter table "public"."products" add constraint "products_pkey" PRIMARY KEY using index "products_pkey";

alter table "public"."todos" add constraint "todos_pkey" PRIMARY KEY using index "todos_pkey";

alter table "public"."order_detail" add constraint "order_detail_order_id_fkey" FOREIGN KEY (order_id) REFERENCES orders(id) not valid;

alter table "public"."order_detail" validate constraint "order_detail_order_id_fkey";

alter table "public"."orders" add constraint "orders_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."orders" validate constraint "orders_user_id_fkey";

alter table "public"."product_deals" add constraint "product_deals_product_id_fkey" FOREIGN KEY (product_id) REFERENCES products(id) not valid;

alter table "public"."product_deals" validate constraint "product_deals_product_id_fkey";

alter table "public"."todos" add constraint "todos_task_check" CHECK ((char_length(task) > 3)) not valid;

alter table "public"."todos" validate constraint "todos_task_check";

alter table "public"."todos" add constraint "todos_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."todos" validate constraint "todos_user_id_fkey";

create policy "Enable read access for all users"
on "public"."order_detail"
as permissive
for select
to public
using (true);


create policy "Enable read access for authenticated users"
on "public"."orders"
as permissive
for select
to public
using ((auth.uid() = user_id));


create policy "Everybody can read product_deals. "
on "public"."product_deals"
as permissive
for select
to public
using (true);


create policy "Everybody can read products. "
on "public"."products"
as permissive
for select
to public
using (true);


create policy "Individuals can create todos."
on "public"."todos"
as permissive
for insert
to public
with check ((auth.uid() = user_id));


create policy "Individuals can delete their own todos."
on "public"."todos"
as permissive
for delete
to public
using ((auth.uid() = user_id));


create policy "Individuals can update their own todos."
on "public"."todos"
as permissive
for update
to public
using ((auth.uid() = user_id));


create policy "Individuals can view their own todos. "
on "public"."todos"
as permissive
for select
to public
using ((auth.uid() = user_id));



