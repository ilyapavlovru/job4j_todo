create table item
(
    id          serial primary key,
    description varchar(255),
    user_name   varchar(50),
    created     timestamp,
    done        boolean
);

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
