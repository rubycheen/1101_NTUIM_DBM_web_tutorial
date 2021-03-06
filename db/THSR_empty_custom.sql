PGDMP         :             	    y            THSR    13.3    13.3 '    
           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16981    THSR    DATABASE     [   CREATE DATABASE "THSR" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE "THSR";
                postgres    false                        2615    16982    THSR    SCHEMA        CREATE SCHEMA "THSR";
    DROP SCHEMA "THSR";
                postgres    false                       0    0    SCHEMA "THSR"    COMMENT     6   COMMENT ON SCHEMA "THSR" IS 'standard public schema';
                   postgres    false    4            ?            1259    16983    discount    TABLE     s   CREATE TABLE "THSR".discount (
    discount_id integer NOT NULL,
    type text NOT NULL,
    discount_rate real
);
    DROP TABLE "THSR".discount;
       THSR         heap    postgres    false    4            ?            1259    16989    discount_discount_id_seq    SEQUENCE     ?   CREATE SEQUENCE "THSR".discount_discount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE "THSR".discount_discount_id_seq;
       THSR          postgres    false    4    201                       0    0    discount_discount_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE "THSR".discount_discount_id_seq OWNED BY "THSR".discount.discount_id;
          THSR          postgres    false    202            ?            1259    16991    fare    TABLE     ?   CREATE TABLE "THSR".fare (
    fare_id integer NOT NULL,
    origin_station_id text NOT NULL,
    destination_station_id text NOT NULL,
    business_fare real NOT NULL,
    standard_fare real NOT NULL,
    non_reserved_fare real NOT NULL
);
    DROP TABLE "THSR".fare;
       THSR         heap    postgres    false    4            ?            1259    16997    fare_fare_id_seq    SEQUENCE     ?   CREATE SEQUENCE "THSR".fare_fare_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE "THSR".fare_fare_id_seq;
       THSR          postgres    false    203    4                       0    0    fare_fare_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE "THSR".fare_fare_id_seq OWNED BY "THSR".fare.fare_id;
          THSR          postgres    false    204            ?            1259    16999    schedule    TABLE     ?   CREATE TABLE "THSR".schedule (
    schedule_id integer NOT NULL,
    train_id text NOT NULL,
    stop_sequence integer NOT NULL,
    station_id text NOT NULL,
    arrival_time text,
    departure_time text
);
    DROP TABLE "THSR".schedule;
       THSR         heap    postgres    false    4            ?            1259    17005    schedule_schedule_id_seq    SEQUENCE     ?   CREATE SEQUENCE "THSR".schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE "THSR".schedule_schedule_id_seq;
       THSR          postgres    false    4    205                       0    0    schedule_schedule_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE "THSR".schedule_schedule_id_seq OWNED BY "THSR".schedule.schedule_id;
          THSR          postgres    false    206            ?            1259    17007    station    TABLE     ^   CREATE TABLE "THSR".station (
    station_id text NOT NULL,
    station_name text NOT NULL
);
    DROP TABLE "THSR".station;
       THSR         heap    postgres    false    4            ?            1259    17013    train    TABLE     <  CREATE TABLE "THSR".train (
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
    DROP TABLE "THSR".train;
       THSR         heap    postgres    false    4            k           2604    17019    discount discount_id    DEFAULT     |   ALTER TABLE ONLY "THSR".discount ALTER COLUMN discount_id SET DEFAULT nextval('"THSR".discount_discount_id_seq'::regclass);
 C   ALTER TABLE "THSR".discount ALTER COLUMN discount_id DROP DEFAULT;
       THSR          postgres    false    202    201            l           2604    17020    fare fare_id    DEFAULT     l   ALTER TABLE ONLY "THSR".fare ALTER COLUMN fare_id SET DEFAULT nextval('"THSR".fare_fare_id_seq'::regclass);
 ;   ALTER TABLE "THSR".fare ALTER COLUMN fare_id DROP DEFAULT;
       THSR          postgres    false    204    203            m           2604    17021    schedule schedule_id    DEFAULT     |   ALTER TABLE ONLY "THSR".schedule ALTER COLUMN schedule_id SET DEFAULT nextval('"THSR".schedule_schedule_id_seq'::regclass);
 C   ALTER TABLE "THSR".schedule ALTER COLUMN schedule_id DROP DEFAULT;
       THSR          postgres    false    206    205                       0    16983    discount 
   TABLE DATA           D   COPY "THSR".discount (discount_id, type, discount_rate) FROM stdin;
    THSR          postgres    false    201   ?+                 0    16991    fare 
   TABLE DATA           ?   COPY "THSR".fare (fare_id, origin_station_id, destination_station_id, business_fare, standard_fare, non_reserved_fare) FROM stdin;
    THSR          postgres    false    203   ?+                 0    16999    schedule 
   TABLE DATA           r   COPY "THSR".schedule (schedule_id, train_id, stop_sequence, station_id, arrival_time, departure_time) FROM stdin;
    THSR          postgres    false    205   ?+                 0    17007    station 
   TABLE DATA           ;   COPY "THSR".station (station_id, station_name) FROM stdin;
    THSR          postgres    false    207   ,                 0    17013    train 
   TABLE DATA           t   COPY "THSR".train (train_id, starting_station_id, ending_station_id, mon, tue, wed, thu, fri, sat, sun) FROM stdin;
    THSR          postgres    false    208   !,                  0    0    discount_discount_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('"THSR".discount_discount_id_seq', 12, true);
          THSR          postgres    false    202                       0    0    fare_fare_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('"THSR".fare_fare_id_seq', 396, true);
          THSR          postgres    false    204                       0    0    schedule_schedule_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('"THSR".schedule_schedule_id_seq', 3337, true);
          THSR          postgres    false    206            o           2606    17023    discount discount_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY "THSR".discount
    ADD CONSTRAINT discount_pkey PRIMARY KEY (discount_id);
 @   ALTER TABLE ONLY "THSR".discount DROP CONSTRAINT discount_pkey;
       THSR            postgres    false    201            q           2606    17025    fare fare_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY "THSR".fare
    ADD CONSTRAINT fare_pkey PRIMARY KEY (fare_id);
 8   ALTER TABLE ONLY "THSR".fare DROP CONSTRAINT fare_pkey;
       THSR            postgres    false    203            s           2606    17027    schedule schedule_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY "THSR".schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id);
 @   ALTER TABLE ONLY "THSR".schedule DROP CONSTRAINT schedule_pkey;
       THSR            postgres    false    205            u           2606    17029    station station_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY "THSR".station
    ADD CONSTRAINT station_pkey PRIMARY KEY (station_id);
 >   ALTER TABLE ONLY "THSR".station DROP CONSTRAINT station_pkey;
       THSR            postgres    false    207            w           2606    17031    train train_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY "THSR".train
    ADD CONSTRAINT train_pkey PRIMARY KEY (train_id);
 :   ALTER TABLE ONLY "THSR".train DROP CONSTRAINT train_pkey;
       THSR            postgres    false    208            x           2606    17032    fare fare_fkey1    FK CONSTRAINT     ?   ALTER TABLE ONLY "THSR".fare
    ADD CONSTRAINT fare_fkey1 FOREIGN KEY (origin_station_id) REFERENCES "THSR".station(station_id);
 9   ALTER TABLE ONLY "THSR".fare DROP CONSTRAINT fare_fkey1;
       THSR          postgres    false    203    207    3189            y           2606    17037    fare fare_fkey2    FK CONSTRAINT     ?   ALTER TABLE ONLY "THSR".fare
    ADD CONSTRAINT fare_fkey2 FOREIGN KEY (destination_station_id) REFERENCES "THSR".station(station_id);
 9   ALTER TABLE ONLY "THSR".fare DROP CONSTRAINT fare_fkey2;
       THSR          postgres    false    203    207    3189            z           2606    17042    schedule schedule_fkey1    FK CONSTRAINT     }   ALTER TABLE ONLY "THSR".schedule
    ADD CONSTRAINT schedule_fkey1 FOREIGN KEY (train_id) REFERENCES "THSR".train(train_id);
 A   ALTER TABLE ONLY "THSR".schedule DROP CONSTRAINT schedule_fkey1;
       THSR          postgres    false    208    205    3191            {           2606    17047    schedule schedule_fkey2    FK CONSTRAINT     ?   ALTER TABLE ONLY "THSR".schedule
    ADD CONSTRAINT schedule_fkey2 FOREIGN KEY (station_id) REFERENCES "THSR".station(station_id);
 A   ALTER TABLE ONLY "THSR".schedule DROP CONSTRAINT schedule_fkey2;
       THSR          postgres    false    3189    205    207            |           2606    17052    train train_fkey1    FK CONSTRAINT     ?   ALTER TABLE ONLY "THSR".train
    ADD CONSTRAINT train_fkey1 FOREIGN KEY (starting_station_id) REFERENCES "THSR".station(station_id);
 ;   ALTER TABLE ONLY "THSR".train DROP CONSTRAINT train_fkey1;
       THSR          postgres    false    207    3189    208            }           2606    17057    train train_fkey2    FK CONSTRAINT     ?   ALTER TABLE ONLY "THSR".train
    ADD CONSTRAINT train_fkey2 FOREIGN KEY (ending_station_id) REFERENCES "THSR".station(station_id);
 ;   ALTER TABLE ONLY "THSR".train DROP CONSTRAINT train_fkey2;
       THSR          postgres    false    207    3189    208                   x?????? ? ?            x?????? ? ?            x?????? ? ?            x?????? ? ?            x?????? ? ?     