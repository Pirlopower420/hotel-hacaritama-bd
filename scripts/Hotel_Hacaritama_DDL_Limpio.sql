

BEGIN;

CREATE TABLE public.country (
    id_country integer NOT NULL,
    name character varying(100) NOT NULL
);

CREATE TABLE public.state (
    id_state integer NOT NULL,
    name character varying(100) NOT NULL,
    id_country integer NOT NULL
);

CREATE TABLE public.city (
    id_city integer NOT NULL,
    name character varying(100) NOT NULL,
    id_state integer NOT NULL
);

CREATE TABLE public.customer (
    id_customer integer NOT NULL,
    name_1 character varying(50) NOT NULL,
    name_2 character varying(50),
    last_name_1 character varying(50) NOT NULL,
    last_name_2 character varying(50),
    address character varying(255),
    email character varying(120),
    id_city integer NOT NULL
);

CREATE TABLE public.employee (
    id_employee integer NOT NULL,
    name_1 character varying(50) NOT NULL,
    name_2 character varying(50),
    last_name_1 character varying(50) NOT NULL,
    last_name_2 character varying(50),
    phone character varying(20),
    email character varying(120)
);

CREATE TABLE public.room (
    id_room integer NOT NULL,
    room_number character varying(20) NOT NULL,
    type character varying(50) NOT NULL,
    description character varying(255)
);

CREATE TABLE public.service (
    id_service integer NOT NULL,
    service_name character varying(100) NOT NULL,
    description character varying(255)
);

CREATE TABLE public.reservation (
    id_reservation integer NOT NULL,
    check_in_date date NOT NULL,
    check_out_date date NOT NULL,
    total_amount numeric(10,2),
    status character varying(50) NOT NULL,
    id_customer integer NOT NULL,
    id_employee integer NOT NULL,
    CONSTRAINT chk_fechas_logicas CHECK ((check_out_date > check_in_date))
);

CREATE TABLE public.reservation_room (
    line_room_id integer NOT NULL,
    id_reservation integer NOT NULL,
    id_room integer NOT NULL
);

CREATE TABLE public.reservation_service (
    id_reservation integer NOT NULL,
    id_service integer NOT NULL
);

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (id_country);

ALTER TABLE ONLY public.state
    ADD CONSTRAINT state_pkey PRIMARY KEY (id_state);

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id_city);

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (id_customer);

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (id_employee);

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (id_room);

ALTER TABLE ONLY public.service
    ADD CONSTRAINT service_pkey PRIMARY KEY (id_service);

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (id_reservation);

ALTER TABLE ONLY public.reservation_room
    ADD CONSTRAINT reservation_room_pkey PRIMARY KEY (line_room_id);

ALTER TABLE ONLY public.reservation_service
    ADD CONSTRAINT reservation_service_pkey PRIMARY KEY (id_reservation, id_service);

ALTER TABLE ONLY public.state
    ADD CONSTRAINT state_id_country_fkey FOREIGN KEY (id_country) REFERENCES public.country(id_country) ON UPDATE CASCADE;

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_id_state_fkey FOREIGN KEY (id_state) REFERENCES public.state(id_state) ON UPDATE CASCADE;

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_id_city_fkey FOREIGN KEY (id_city) REFERENCES public.city(id_city) ON UPDATE CASCADE;

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_id_customer_fkey FOREIGN KEY (id_customer) REFERENCES public.customer(id_customer) ON UPDATE CASCADE;

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_id_employee_fkey FOREIGN KEY (id_employee) REFERENCES public.employee(id_employee) ON UPDATE CASCADE;

ALTER TABLE ONLY public.reservation_room
    ADD CONSTRAINT reservation_room_id_reservation_fkey FOREIGN KEY (id_reservation) REFERENCES public.reservation(id_reservation) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.reservation_room
    ADD CONSTRAINT reservation_room_id_room_fkey FOREIGN KEY (id_room) REFERENCES public.room(id_room) ON UPDATE CASCADE;

ALTER TABLE ONLY public.reservation_service
    ADD CONSTRAINT reservation_service_id_reservation_fkey FOREIGN KEY (id_reservation) REFERENCES public.reservation(id_reservation) ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY public.reservation_service
    ADD CONSTRAINT reservation_service_id_service_fkey FOREIGN KEY (id_service) REFERENCES public.service(id_service) ON UPDATE CASCADE;

CREATE FUNCTION public.trg_validar_disponibilidad() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    v_check_in DATE;
    v_check_out DATE;
    v_conflictos INT;
BEGIN
  
    SELECT CHECK_IN_DATE, CHECK_OUT_DATE INTO v_check_in, v_check_out
    FROM RESERVATION WHERE ID_RESERVATION = NEW.ID_RESERVATION;

    SELECT COUNT(*) INTO v_conflictos
    FROM RESERVATION_ROOM rr
    JOIN RESERVATION r ON rr.ID_RESERVATION = r.ID_RESERVATION
    WHERE rr.ID_ROOM = NEW.ID_ROOM
      AND rr.ID_RESERVATION != NEW.ID_RESERVATION
      AND (r.CHECK_IN_DATE < v_check_out AND r.CHECK_OUT_DATE > v_check_in);

    IF v_conflictos > 0 THEN
        RAISE EXCEPTION 'Error: La habitación con ID % ya está ocupada en ese rango de fechas.', NEW.ID_ROOM;
    END IF;

    RETURN NEW;
END;
$$;

CREATE TRIGGER tg_validar_disponibilidad BEFORE INSERT OR UPDATE ON public.reservation_room FOR EACH ROW EXECUTE FUNCTION public.trg_validar_disponibilidad();

COMMIT;

