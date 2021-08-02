PGDMP     /                    y            THSR    13.3    13.3 '    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16387    THSR    DATABASE     [   CREATE DATABASE "THSR" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.UTF-8';
    DROP DATABASE "THSR";
                postgres    false                        2615    2200    THSR    SCHEMA        CREATE SCHEMA "THSR";
    DROP SCHEMA "THSR";
                postgres    false            �           0    0    SCHEMA "THSR"    COMMENT     6   COMMENT ON SCHEMA "THSR" IS 'standard public schema';
                   postgres    false    3            �            1259    16467    discount    TABLE     s   CREATE TABLE "THSR".discount (
    discount_id integer NOT NULL,
    type text NOT NULL,
    discount_rate real
);
    DROP TABLE "THSR".discount;
       THSR         heap    postgres    false    3            �            1259    16465    discount_discount_id_seq    SEQUENCE     �   CREATE SEQUENCE "THSR".discount_discount_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE "THSR".discount_discount_id_seq;
       THSR          postgres    false    202    3            �           0    0    discount_discount_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE "THSR".discount_discount_id_seq OWNED BY "THSR".discount.discount_id;
          THSR          postgres    false    201            �            1259    16592    fare    TABLE     �   CREATE TABLE "THSR".fare (
    fare_id integer NOT NULL,
    origin_station_id text NOT NULL,
    destination_station_id text NOT NULL,
    business_fare real NOT NULL,
    standard_fare real NOT NULL,
    non_reserved_fare real NOT NULL
);
    DROP TABLE "THSR".fare;
       THSR         heap    postgres    false    3            �            1259    16590    fare_fare_id_seq    SEQUENCE     �   CREATE SEQUENCE "THSR".fare_fare_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE "THSR".fare_fare_id_seq;
       THSR          postgres    false    205    3            �           0    0    fare_fare_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE "THSR".fare_fare_id_seq OWNED BY "THSR".fare.fare_id;
          THSR          postgres    false    204            �            1259    16614    schedule    TABLE     �   CREATE TABLE "THSR".schedule (
    schedule_id integer NOT NULL,
    train_id text NOT NULL,
    stop_sequence integer NOT NULL,
    station_id text NOT NULL,
    arrival_time text,
    departure_time text
);
    DROP TABLE "THSR".schedule;
       THSR         heap    postgres    false    3            �            1259    16612    schedule_schedule_id_seq    SEQUENCE     �   CREATE SEQUENCE "THSR".schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE "THSR".schedule_schedule_id_seq;
       THSR          postgres    false    207    3            �           0    0    schedule_schedule_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE "THSR".schedule_schedule_id_seq OWNED BY "THSR".schedule.schedule_id;
          THSR          postgres    false    206            �            1259    16389    station    TABLE     ^   CREATE TABLE "THSR".station (
    station_id text NOT NULL,
    station_name text NOT NULL
);
    DROP TABLE "THSR".station;
       THSR         heap    postgres    false    3            �            1259    16545    train    TABLE     <  CREATE TABLE "THSR".train (
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
       THSR         heap    postgres    false    3            F           2604    16470    discount discount_id    DEFAULT     |   ALTER TABLE ONLY "THSR".discount ALTER COLUMN discount_id SET DEFAULT nextval('"THSR".discount_discount_id_seq'::regclass);
 C   ALTER TABLE "THSR".discount ALTER COLUMN discount_id DROP DEFAULT;
       THSR          postgres    false    202    201    202            G           2604    16595    fare fare_id    DEFAULT     l   ALTER TABLE ONLY "THSR".fare ALTER COLUMN fare_id SET DEFAULT nextval('"THSR".fare_fare_id_seq'::regclass);
 ;   ALTER TABLE "THSR".fare ALTER COLUMN fare_id DROP DEFAULT;
       THSR          postgres    false    204    205    205            H           2604    16617    schedule schedule_id    DEFAULT     |   ALTER TABLE ONLY "THSR".schedule ALTER COLUMN schedule_id SET DEFAULT nextval('"THSR".schedule_schedule_id_seq'::regclass);
 C   ALTER TABLE "THSR".schedule ALTER COLUMN schedule_id DROP DEFAULT;
       THSR          postgres    false    206    207    207            �          0    16467    discount 
   TABLE DATA           D   COPY "THSR".discount (discount_id, type, discount_rate) FROM stdin;
    THSR          postgres    false    202   �+       �          0    16592    fare 
   TABLE DATA           �   COPY "THSR".fare (fare_id, origin_station_id, destination_station_id, business_fare, standard_fare, non_reserved_fare) FROM stdin;
    THSR          postgres    false    205    ,       �          0    16614    schedule 
   TABLE DATA           r   COPY "THSR".schedule (schedule_id, train_id, stop_sequence, station_id, arrival_time, departure_time) FROM stdin;
    THSR          postgres    false    207   =0       �          0    16389    station 
   TABLE DATA           ;   COPY "THSR".station (station_id, station_name) FROM stdin;
    THSR          postgres    false    200   �R       �          0    16545    train 
   TABLE DATA           t   COPY "THSR".train (train_id, starting_station_id, ending_station_id, mon, tue, wed, thu, fri, sat, sun) FROM stdin;
    THSR          postgres    false    203   BS       �           0    0    discount_discount_id_seq    SEQUENCE SET     F   SELECT pg_catalog.setval('"THSR".discount_discount_id_seq', 8, true);
          THSR          postgres    false    201            �           0    0    fare_fare_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('"THSR".fare_fare_id_seq', 264, true);
          THSR          postgres    false    204            �           0    0    schedule_schedule_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('"THSR".schedule_schedule_id_seq', 1900, true);
          THSR          postgres    false    206            L           2606    16475    discount discount_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY "THSR".discount
    ADD CONSTRAINT discount_pkey PRIMARY KEY (discount_id);
 @   ALTER TABLE ONLY "THSR".discount DROP CONSTRAINT discount_pkey;
       THSR            postgres    false    202            P           2606    16600    fare fare_pkey 
   CONSTRAINT     Q   ALTER TABLE ONLY "THSR".fare
    ADD CONSTRAINT fare_pkey PRIMARY KEY (fare_id);
 8   ALTER TABLE ONLY "THSR".fare DROP CONSTRAINT fare_pkey;
       THSR            postgres    false    205            R           2606    16622    schedule schedule_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY "THSR".schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id);
 @   ALTER TABLE ONLY "THSR".schedule DROP CONSTRAINT schedule_pkey;
       THSR            postgres    false    207            J           2606    16396    station station_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY "THSR".station
    ADD CONSTRAINT station_pkey PRIMARY KEY (station_id);
 >   ALTER TABLE ONLY "THSR".station DROP CONSTRAINT station_pkey;
       THSR            postgres    false    200            N           2606    16552    train train_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY "THSR".train
    ADD CONSTRAINT train_pkey PRIMARY KEY (train_id);
 :   ALTER TABLE ONLY "THSR".train DROP CONSTRAINT train_pkey;
       THSR            postgres    false    203            U           2606    16601    fare fare_fkey1    FK CONSTRAINT     �   ALTER TABLE ONLY "THSR".fare
    ADD CONSTRAINT fare_fkey1 FOREIGN KEY (origin_station_id) REFERENCES "THSR".station(station_id);
 9   ALTER TABLE ONLY "THSR".fare DROP CONSTRAINT fare_fkey1;
       THSR          postgres    false    200    3146    205            V           2606    16606    fare fare_fkey2    FK CONSTRAINT     �   ALTER TABLE ONLY "THSR".fare
    ADD CONSTRAINT fare_fkey2 FOREIGN KEY (destination_station_id) REFERENCES "THSR".station(station_id);
 9   ALTER TABLE ONLY "THSR".fare DROP CONSTRAINT fare_fkey2;
       THSR          postgres    false    200    3146    205            W           2606    16623    schedule schedule_fkey1    FK CONSTRAINT     }   ALTER TABLE ONLY "THSR".schedule
    ADD CONSTRAINT schedule_fkey1 FOREIGN KEY (train_id) REFERENCES "THSR".train(train_id);
 A   ALTER TABLE ONLY "THSR".schedule DROP CONSTRAINT schedule_fkey1;
       THSR          postgres    false    203    3150    207            X           2606    16628    schedule schedule_fkey2    FK CONSTRAINT     �   ALTER TABLE ONLY "THSR".schedule
    ADD CONSTRAINT schedule_fkey2 FOREIGN KEY (station_id) REFERENCES "THSR".station(station_id);
 A   ALTER TABLE ONLY "THSR".schedule DROP CONSTRAINT schedule_fkey2;
       THSR          postgres    false    200    207    3146            S           2606    16553    train train_fkey1    FK CONSTRAINT     �   ALTER TABLE ONLY "THSR".train
    ADD CONSTRAINT train_fkey1 FOREIGN KEY (starting_station_id) REFERENCES "THSR".station(station_id);
 ;   ALTER TABLE ONLY "THSR".train DROP CONSTRAINT train_fkey1;
       THSR          postgres    false    203    3146    200            T           2606    16558    train train_fkey2    FK CONSTRAINT     �   ALTER TABLE ONLY "THSR".train
    ADD CONSTRAINT train_fkey2 FOREIGN KEY (ending_station_id) REFERENCES "THSR".station(station_id);
 ;   ALTER TABLE ONLY "THSR".train DROP CONSTRAINT train_fkey2;
       THSR          postgres    false    3146    203    200            �   M   x�3�L��KN-.����4�3�2�L/�/- �-M��9S�r*�2�R�"\��y)�E�E�)��%�@1sS�=... #�      �     x�e�Q��*D�s󖂂Υ�?�Ga��9�vG��[U�2gyj)�+O+��_����xy��R��9��Y��������&��1��xr�A�VL�� ͍��=,a�h�^|K�O�0z��*Q�SG�S��#�lBSD��� ������Þ�lK���R�k<U����-|3��$����{�M�3��_��9�+I_��e�P	3F���n��m�%��B�*-��K�S�T	(>���Rz� Z˙}	�*}b���c�;ǡR�=�_�A#��<27	�ʚ�8]+$�R�B��n���l3��qB�B-��}|+8k���*ṭ�N�2����4[�JG�/�:Qc��^J�$ыx٤?&e��1�$�]��KG��l������Ð�a�7"��cY>��w"��	V���F�RM�s�/�R����X$u:r�'I��f�;�F%	�N-k����W�����^
��Q8������r��0"��,Ra-�zF�O,p,�S�����H�t���H�YI��A3�D�)�T8Z�{�m��+|Vԭ�7�g��--0�^.���fs�_��\�����edWե꧴J��9RA�1'y�R�HϘ��6�LR:I��M)��?(N(ǒ�8	lv_<�9� �->1ŤI�W 
����{�J��s���c��'��Hn�j#�[��7�G�H5�v&�T��ԥ��v�A�Y
���>�����en�dW��0\��d��m<D����{��JT�yň4"����"�H�<����<"NA��"c=E�I�l*��bi ��v�T�[�b Y+-��L�=����x�6��羕]R�o���A��Q�D�AԮҹ��QӶI��!U�$v�MiB�WA`����lG%;N��ՅIc̶�l>${O�R�+<ͥ�Y'%;P�Z��ق��QT�^�5b�R����uPv���y��wR�y�H��N��]:k�u6���S�����X�4!����z]W�d/����.��|�2�Q�bG��v�w�}�X� �H�H������d7=�      �      x�m]Q��*�{�^�T0H�e����$sn�Kf*�}>,����<��?�O{���O����nzm����i��/>��������L��aC���Go_<�}������~�{=����W�^g&[0Ղ-,[�؂��²�-Xl�|�e�Z0��Ղ�L��l�b[0��l�f6[0��l�f�Z�²;Z@v� ��d3��l�f3����e3^6�U3^aٌ��xٌ��f�j�"���"�{mzmE�f�����ꊾ��5����EՇ�0������6>&�ll����d�%���m�l��v��}��l|o����j�6���^F6vV��;�ja�l(����l����k��$b/�"��jK"�h$b��F"�xaID/�XE���^[	����+a����a��#"�}]X�HD"fM�?���$����?��%F"�D���$�H��� �L�����ن���|҃����?�p��s��Z�,�pl}��f8���t�.t`���Ѐ��N�S||������t~�i�}�^�� ��)������ce�l�lk��������l� >]#/�l��C�-~�cj��_t���<|O�S��(�&���7�>	n�S�=������l�=zmć��'�њ�~��r��fǙ1A�Ѻ@?S��F<	��|<�F%��=cS�k�����Ԯ�{���D��Xs���~���4�?�?��:N�ן3x��O=~�����I�Oɼw�=��C��C ��� ] :�:���:�T��� ���K�ӟ��Q �p�8|���+�����'�����C�!BL�	D����54��p���kj��`�*,�#�Gz��gL����<Q`
�F �)p�(����gg���������~��,F�=�?�a��iN��V �m�h�V �5C�3���=(�57~;�3�)�[}:�P*���|�Ó�r	� �|2�-����{c��� ^�S�}���O��a p�W���ԥ]V��S4���_z�o��xS�8�3Ҝ�	�8W�9��ˎj��S`N�+F=����:?���������p�3�y�_|�����������Y���|g�Cn[���NN��&9[r���������`f��L���������d��ޟb�f-��>���Cnk�>�C	�W�8�sy�~^��.ڸ����η�o���/��'䶻�}�𘰿':j�����y�|�l�ي���9�Zp	���N�_n����߈����U������_��0����:��F`�߰j�������׃>\��&J�pg?��^�Ǔ?6���]O��G��I��Nw������z<A�.�P���T}� C��k׳lC�x�b� �o0� C��k�����Q����x?��Ώ���`u�j����r
�^G���%0C�u<��-0z�{�5��_<����^w�z�����^w�z��������l�B�-E[�����^��ֆ����Oa��[s���^���)0Cw����[[�ם�����f���'z���ם�>����>��1Ԧ�{�m���{;<6� ��~z�� ������u�:=S�7������lZ�58_��d�S�����'C_�+0C_:mٵ2�6����\��>:��9��E��*��.0C�}���:U��j��9��P5�F'0��b�Z6�X��x�}+���=k���k�dj��R��%���c}4����L��a�	�Y�`x���D��c���:���X��[c�&�s�o����N��9�7�p��b��3�kS3;j����p�N�Ú5���h����qB��?�&0I��ir8�E"��O���p�8��z:�X6w���t8M�B����4:Ĺ�-Cv�o��=öc��_������h6. ����H�M`��S�X��i��x�]`�,���9f��\��[ t�����JF'y��2���|�g:�	p��c���
������t�󽻾�>�����
�	����^���?�/���|�{ůoM�z�M��'~:��\��E��US�p��p��z�]�#�+��w�K�4��USߋ%-B��hWM}_/>�Z��US"��E���K����w][C1<izWmm���QO��
����w���3���.;��Tw�
���<��]v�.p���~`���稧�����k������qʓ�w�{��Ͽ����@�z:��/�
����w��ו@������x��]�R��"��gd��z=�\ ��P�I&@�F���_��_;n]��x���Hk4��]�p��iZ������p	���T� ���߸�1�k��w��7�M���]~�?�-��W���!�x�K�c�4d4«�zg�%8^ێ1t�E��_b���:_=t"U��o4��|�Е�O�v�3|>�e4�k^���7z��y�^e�_��C�h�׾B���^�
ݙ������pw*�^�
�S��F#���T��o4�k_�;SA�f�MC�聿��J��避��]b�V:�G$�>���;�'#t��Bo|��4��G�0t*�F�S���o�>������$}�L�7J_�w����B����vS3����g��]qe?�	�|�>F��>�����nx�e�?�D�t��,s��b�]O7��2���b�����)�Fx?��{�1x��ص}O�pbG.�`m�ǎ#����ؾ�ט���c�Z�c��F�wl_��l*<�~��ӆc����܎��-D�.��s��vn��;���ɝ��_3Ov"7�0����nar�if��O}J�T����)�� ��ls��N{�4��_N�f�'���G#�8o�#k���x��ڜ�髋����̉<2�6w���@6A�Lvڟ̀w-���a���H]��'JI-���w}���gbu���4mok�����/X�ό��)�H�u����$�R<�/��$�����T��'B�O�_����d'I�E֞/���
+R7��I�r������/y�%.���k���8N��	�K�W�z���fv���
��O���.�^���k��ms��F�a��Zğ�������G����Gg�Ӄ ?�CNjީ��CH}���!o��w������X�� ��;�!��)Pjg�Ad�}��TjL`*��FL��S�,6³*����5�O�JŎ|��R��R;S"��L&�#��c�d�=p:��V�f����N�[%�ϰ1�M�z�&�r�AB��`���\_ʵ��6�#<�'�+ړrm��i����$�\�� w��M�B�x���\{�R��\{#?��*���Z}�^�UK�Ώd��U�*ȵ�	��N$��G|�WBg��Ն�Y��S(Ws�!WPô��OH;_��b00�P���kc5�eG�!W3���,�I�6ʵI�=8:rm!�N~�R>Z�v��v,����]`*��ȻuN�m�Rkؠs9��H�6�&��L��qV��ڴ�}	�2l>	n���F�6)��S��JmR*��O�6*�I�#�I�6*�I�#8:Jm�T~2ڵ1Ԍ���N�PA ]`�Sr@Q�L��ژ<i@���W���'ҠT*r[�T0�N�Ri��:JmTj�R9�u��j=0�Ph��:Je����R�ڤTOvR�F�(�=8:J�P*���Z�j��[�{�?"�ֽ\�4�o:�@�G�gĠs��>J��O0ι����F�6)�����F�6)����T�RMJ�An�(�(�Ri�)��Q�J����R�J5)uGG�J�=�kE��[���ڤTc�u(*��<;+j�$�	L�ru�'�F�l�(�Q�MJ�A�v�jT�I�4�֎RYN�6@�Je9%���R�J5)u%;�T���	����(��Ri��ڜՒ��[m���c���F�j�����UkĠs���U���4�v֪��CxB�4�v֪�O�S`*�S�]J�    A��V%��Ri��֪���6*u';��N�v)���R{(��خmϠ���j�ӨT�Ri���=s@Q���V۞F���Jol��iT�I�4�v�U`l�&��J�Tj�Ri��,�K�� Cy�R�?�{�c� [-�~�Ɠ�R�$�x����!��c�)1����*�13�g�.�Z�A_lgYU#� .�^��9 n���և�E �S��J�T�7���:P�7���%�����V�*>�,-�I�*uP��GG�CJt���%(����ޫ��"�X%(PP�%�J�u*�S����ޫ�f�(u��YV�1v
�:��,�@���iS��JT�7���%�����ղ
Č8���N*թ�d��R=�JgܟR�ʋMq�\�Ϙ�'���T��b-q?+�1�\��~VT�^O0Noܟ���3>*�޸�����Ju*եTz�^+*�\J�7�׊ʩTU����R�Ju)�GG�J�3�W*-��)�JT�R�{��r@Q��Ľ_�R�D�.�����R��YQ����#�.0��T�K��ƽVTN���Jo�kE����z�~���Ju)u$;��I���fxpt�:C�t�}�eXT*MqW�5f���ʰ��j��ZQ��Υ-:eX`�޸׊ʩT�R�{���Ju)�޸׊jR�SJ�7����R�����T����LvR��J�R���Rg(�θ_+�����׊ʩT�R�{��r@Q��ĽVT�����ZQ��O�޸׊ʩT�R�{��&�:�Tz�^+�sB���ZQ��gJ���ZQ�eKc%;��E�h�|���(u�R����R�ޠ)�3�ĽVTwaܠ%:#�K[�kEu���8�q�դR��Jo�kE5�T���ƽVTY�E���ZQ�R ��޸_+�E�*�0v��J]T�Rwpt��B�tƣ�Ei���x��(��"�+���4��TZ�Q+�I�*�2h�G��&����Ao<jEŢz���S�YBC���ZQ�����xԊjE��Ao<��]`4�d'��m�(Popt��C�tƿ'��T�)�9	Uc��G���:F�%��:#� v�^��9 �U�ׇJ��T*�MQ#��ƣVTY]�:���u`�9��VT�JU~ϟd'����M�z��R���t�w�tPCS|�J3QՔ�rz�T:���W�4UM�*�-�J�����gNo<jE�DUS���G�����_n�����pJT9���!���kEuŸ%;�T�G=�[pt��*�3׊J�*�)w9f��'w9fU\:-��1�\��Q+�Sv��Ǽj��PQ&�W`*��krz�Q+���R�G�����h*����4��R��jJTy��R#Q�tƿ�IM��!�g� �K`�<i@Q����.t��[�F[<�B��*%�@z�Q+*&��UNo<jE�DUS���G��Ρx�Bo<jEu�A(���ZQ�5,>��P*K����Gp�J�HT9��?w	!�JS��]B��1CO�w�dU	:-�׊�t.m�׊�ʁqzc�:�>��鍽VT�Q5娜��ϊ��P���~VT�i��(՘����d'������!�R-rTNg|��jh�����QEy��_'�s@Q���ޯ�(�o��ޯ�4��S���^+*樚rTNo�gEe�Q�rTNo�gEU0�%0��L��No쵢2�tZ�C��T*w�M9*_��Q*sT� (I:˪��?L{|��`�*G��u��.os�c?k�;�fd?k��}�t�>��>�x�����H ����,�U�l��%�Y[7�uAs�d���1[�>4)J�2[e�V���f#[����I�qݱ�A�u�Nw\�,��E�����ꢸ�� ������f������*S��������*S�������n	�B��gm��%L;�N�쵶2f�L�*���,��M�*���Yf�xeP���z=ʕ��U�w!Zd�W�^��9��V �0]��V��}�OZe?,c�ʔ����~X��O�&0�ʔ�)e5i��,��;즔դU�Z`SVq��|���+SV���|��#�HYM�˪������ɽ��r����a����NX�;�xN�;k�Xf� 6���Tİ���4�y}C܅1�n�-��*&3�?�5��8�V���F5K8=��m���?��!i���Й�x��-�F��T����g>�P�N��o�9�(TQ3��eL���(Ti�QWP��T�<w��!0��xt��d���s����c��E���}���<���Z]�����'~��<6���#wQ�9l�l8��L�oydF駌�X'B�{ej+��#w���B� t��I�(�P!AT����<r�*�s�*a���$�OU�J=�#�B�ܦ6�Қ ����ȣ�G�G�*AI~����o��<�����7��<rI~5��p��H�+Y���xd.5��JsG��-0y���f�7g΀�r�l�Go+g�B���,r摤�J����N�x��<r�JA�G�qS����'m7y�w���#�1�s*��:�wMDBt�+0y<Yt��|��cz�8I�OF�O����'���+��49y�C`���c��u��� �C<�)0y��$%?	R�8��W���x���~���̜�Кٹ&�G�3]7W�<�/A�<��q���|#^C�#�;�� �����%�k
�s�}+ap	L�<�x\[`����%��;�����Q��'=�����ם�&��p=���$��w�2����у�J~�axO��l� �q/��S��<�-�����t����q��)9�������%%?�%����Wr�(n��v��4㙙u���<:yT�c�.0y<�1�S`�8�Ǘ���j���r5c����+W�x\�z}g&y����4���"��<.�z�����a�S�q=C�+�a���\`?�xf����^��5���E���;s�7���q��E���I`���~2	c��N�'���y�S�����]`��������3ytg,=��F�~q��uy��E3𳑬�y5t����Zlѳ���y�[ӥo��u�D�F�ӳ��˲�iW�em�P8�.��f�Y�E�:j"?'�ѧ���&�Lp
����?!�;rj���ڑ����
�6އ���$y�g���^���T$h���R�Y7��)��?\q�}M�����]C�5�j�M�ӃZ\����מ�-0���}��H^��R�|���l���� ��~��r	�� �N��/W?3e�{��p���w�Q�Y�켌�''=��΋��H&��u�%yl�-W?3�ё���{�3S9� ���Fɤq���0nאLW?ӥі�6ע?�3]m�ɖ/�W?�em���̰����!v�q뽝���.W?6���} ��Jz޽��^�n"�oP[��^7�2���-�}�h4��nl!|�/��y�9�����d�p�	�ha��h�����dF	낅���-9�����_�e�k��W�%�Cl�_�-�k�#|����!��[:A� ] V�:qd:n���c�s��N�m(2�����tR��o�_9X�n���J�,��n����&!t��~�D�����������|l�j"1����c{�DZ&v8��]S�8�m��h�B���1��c7���k�t�گ�ڴ�{9?}��=�8���&���k/t�&��؝����3�L0�w�����u�u�\����Z�F?lm�������UiX�)��
�M�[���ʬ*�)�{�޶W�!j9=�Do��г���y2��s�vUyo� 8�!k�ϓ�8�sM��u��A��)���{��ꆝ��ݯ)���d ���5�x~33O��Aڙ� k�{]-qv��7�	��3�K�_��|}��b����3�ݖ�^,�Yެ8|�uQ*�_����$���s�)O� ��q�$�$��=�q�+�|�?yf��h3��ܬZ{�uQ*/����=�W���{�:��ы,�=�8Fly�z��z��������cO���5�=>�iQ��\�Tz�������u���{�zַ�O�?����J���Rh���t���f��_����V*�O�X:������#f��ۑg� X  ���`��~��S
��<�r<�@����;b, 7�o����1n~O\�˂+nД�g�!�/Ku �|�,�.`7��!�r֣�V�.�����|V �	�n٬(\����l�����M01�[5x�0S��I�E���W�|��{m6L/����"��k��j�ܶ��+�J}��E�fI�>�(���daz��Sm�U�?�o]��c
`}�4K�V��c�:���Onr�&{6���+K��	��O���3���e��3tc�:ó��Ѝ��`�S`}�¢#���gN���rǬ8?s0�x_�YV'l�½v�~E��B����l8_�������Я� �`�sx��X�;oi�'��{|=�Q�0��w��[��w����a���������mnƫ��M`}��Rλw{�����w�S��9�p�{>WFZ?Ώ��ϕ��)����s�J�d����Hc��;�_�NF:�-{���c��[�=�u��6���d�~M`P\���^C���u�;��[.����U���?I�S�>}�M
���q�vG�O}��|��d'(:n�6%��'8:�i������߿�'P�      �   �   x�3��4�|�;�َ�\�@v���=ӁlC�gs�?[�d���Ιd��6<_��6�|�=���z��';ւ�ƜO�͙b�s�����<�S�������� v���́��˞������� r�>`      �   �  x�}�K��0D��0S�?��ˬ��E�!�zEU<�[-�h��ʐ�����N�}mB�t��~���l�{��^�����:�Ԁr<q?_�e/�o�
�5_���]�e[������v���ߟmȾt~,k2��>��IW^��im^y@H�uȭQ� }f�f�+!}f�f�pІ̊�J��s{@2~������x����:��O���
S�J�F��**�Be!�
9TȡBUr��C���P%�9D�[o�P#��M���P'�:9�s��$S��g�\������������$�!`��y���H�8$�`�C0Z`�	�x-ꀤB�tb�;u�`��ơ��+0�
j�H��.�vi���U ����u���29ک��4���	# �`+T:u�-���ϲ,��D     