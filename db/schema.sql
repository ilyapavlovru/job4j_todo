create table item
(
    id          serial primary key,
    description varchar(255),
    created     timestamp,
    done        boolean
);
