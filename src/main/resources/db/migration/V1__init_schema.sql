CREATE TABLE app_users
(
    id            bigserial primary key,
    username      text not null,
    name          text not null,
    surname       text not null,
    email         text not null,
    password      text not null,
    app_user_role text default 'USER',
    link_img      text default 'https://i.ibb.co/9HHWVWf/Pngtree-smiling-people-avatar-set-different-7690733-1.png'
);

CREATE TABLE activation_tokens
(
    token       text primary key,
    app_user_id bigint not null,
    constraint fk_activation_tokens_app_user_id foreign key (app_user_id) references app_users (id)
);

CREATE TABLE question
(
    id                 bigserial primary key,
    title              text   not null,
    question_text      text   not null,
    parent_question_id bigint    default null,
    app_user_id        bigint not null,
    views              bigint    default 0,
    date               timestamp default now(),
    constraint fk_question_user_id foreign key (app_user_id) references app_users (id),
    constraint fk_question_parent_question_id foreign key (parent_question_id) references question (id)
);

CREATE TABLE tag
(
    id          bigserial primary key,
    name        text not null,
    description text not null
);

CREATE TABLE question_tag
(
    id          bigserial primary key,
    question_id bigint not null,
    tag_id      bigint not null,
    constraint fk_question_question_id foreign key (question_id) references question (id),
    constraint fk_tag_tag_id foreign key (tag_id) references tag (id)
);
CREATE TABLE like_unlike_question
(
    id          bigserial primary key,
    app_user_id bigint not null,
    question_id bigint not null,
    like_unlike boolean default null,
    constraint fk_question_question_id foreign key (question_id) references question (id),
    constraint fk_app_user_id foreign key (app_user_id) references app_users (id)
)