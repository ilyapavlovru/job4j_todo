create table item
(
    id          serial primary key,
    description varchar(255),
    created     timestamp,
    done        boolean
);
ALTER TABLE item
    ADD COLUMN user_id int not null references j_user (id);

create table j_role
(
    id   serial primary key,
    name varchar(50)
);

create table j_user
(
    id       serial primary key,
    name     varchar(50),
    email    varchar(50),
    password varchar(50),
    role_id  int not null references j_role (id)
);
