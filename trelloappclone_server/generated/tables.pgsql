--
-- Class User as table user
--

CREATE TABLE "user" (
  "id" serial,
  "name" text NOT NULL,
  "email" text NOT NULL,
  "password" text NOT NULL,
  "handle" text NOT NULL
);

ALTER TABLE ONLY "user"
  ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Class Workspace as table workspace
--

CREATE TABLE "workspace" (
  "id" serial,
  "userId" integer NOT NULL,
  "name" text NOT NULL,
  "handle" text NOT NULL,
  "description" text NOT NULL,
  "visibility" text NOT NULL
);

ALTER TABLE ONLY "workspace"
  ADD CONSTRAINT workspace_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "workspace"
  ADD CONSTRAINT workspace_fk_0
    FOREIGN KEY("userId")
      REFERENCES user(id)
        ON DELETE CASCADE;

--
-- Class Member as table member
--

CREATE TABLE "member" (
  "id" serial,
  "workspaceId" integer NOT NULL,
  "userId" integer NOT NULL,
  "name" text NOT NULL,
  "role" text NOT NULL
);

ALTER TABLE ONLY "member"
  ADD CONSTRAINT member_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "member"
  ADD CONSTRAINT member_fk_0
    FOREIGN KEY("workspaceId")
      REFERENCES workspace(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "member"
  ADD CONSTRAINT member_fk_1
    FOREIGN KEY("userId")
      REFERENCES user(id)
        ON DELETE CASCADE;

--
-- Class Board as table board
--

CREATE TABLE "board" (
  "id" serial,
  "workspaceId" integer NOT NULL,
  "userId" integer NOT NULL,
  "name" text NOT NULL,
  "discription" text,
  "visibility" text NOT NULL,
  "background" text NOT NULL,
  "stared" boolean,
  "enableCover" boolean,
  "watch" boolean,
  "availableOffline" boolean,
  "label" text,
  "emailAddress" text,
  "commenting" integer,
  "memberType" integer,
  "pinned" boolean,
  "selfJoin" boolean,
  "close" boolean
);

ALTER TABLE ONLY "board"
  ADD CONSTRAINT board_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "board"
  ADD CONSTRAINT board_fk_0
    FOREIGN KEY("workspaceId")
      REFERENCES workspace(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "board"
  ADD CONSTRAINT board_fk_1
    FOREIGN KEY("userId")
      REFERENCES user(id)
        ON DELETE CASCADE;

--
-- Class Listboard as table listboard
--

CREATE TABLE "listboard" (
  "id" serial,
  "boardId" integer NOT NULL,
  "userId" integer NOT NULL,
  "name" text NOT NULL,
  "archived" boolean
);

ALTER TABLE ONLY "listboard"
  ADD CONSTRAINT listboard_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "listboard"
  ADD CONSTRAINT listboard_fk_0
    FOREIGN KEY("boardId")
      REFERENCES board(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "listboard"
  ADD CONSTRAINT listboard_fk_1
    FOREIGN KEY("userId")
      REFERENCES user(id)
        ON DELETE CASCADE;

--
-- Class Card as table card
--

CREATE TABLE "card" (
  "id" serial,
  "listId" integer NOT NULL,
  "userId" integer NOT NULL,
  "name" text NOT NULL,
  "description" text,
  "startDate" timestamp without time zone,
  "dueDate" timestamp without time zone,
  "attachment" boolean,
  "archived" boolean,
  "checklist" boolean,
  "comments" boolean
);

ALTER TABLE ONLY "card"
  ADD CONSTRAINT card_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "card"
  ADD CONSTRAINT card_fk_0
    FOREIGN KEY("listId")
      REFERENCES listboard(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "card"
  ADD CONSTRAINT card_fk_1
    FOREIGN KEY("userId")
      REFERENCES user(id)
        ON DELETE CASCADE;

--
-- Class Attachment as table attachment
--

CREATE TABLE "attachment" (
  "id" serial,
  "userId" integer NOT NULL,
  "cardId" integer NOT NULL,
  "attachment" text NOT NULL
);

ALTER TABLE ONLY "attachment"
  ADD CONSTRAINT attachment_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "attachment"
  ADD CONSTRAINT attachment_fk_0
    FOREIGN KEY("userId")
      REFERENCES user(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "attachment"
  ADD CONSTRAINT attachment_fk_1
    FOREIGN KEY("cardId")
      REFERENCES card(id)
        ON DELETE CASCADE;

--
-- Class Checklist as table checklist
--

CREATE TABLE "checklist" (
  "id" serial,
  "cardId" integer NOT NULL,
  "name" text NOT NULL,
  "status" boolean NOT NULL
);

ALTER TABLE ONLY "checklist"
  ADD CONSTRAINT checklist_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "checklist"
  ADD CONSTRAINT checklist_fk_0
    FOREIGN KEY("cardId")
      REFERENCES card(id)
        ON DELETE CASCADE;

--
-- Class Comment as table comment
--

CREATE TABLE "comment" (
  "id" serial,
  "cardId" integer NOT NULL,
  "userId" integer NOT NULL,
  "description" text NOT NULL
);

ALTER TABLE ONLY "comment"
  ADD CONSTRAINT comment_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "comment"
  ADD CONSTRAINT comment_fk_0
    FOREIGN KEY("cardId")
      REFERENCES card(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "comment"
  ADD CONSTRAINT comment_fk_1
    FOREIGN KEY("userId")
      REFERENCES user(id)
        ON DELETE CASCADE;

--
-- Class Activity as table activity
--

CREATE TABLE "activity" (
  "id" serial,
  "boardId" integer,
  "userId" integer NOT NULL,
  "cardId" integer,
  "desctiption" text NOT NULL,
  "dateCreated" timestamp without time zone NOT NULL
);

ALTER TABLE ONLY "activity"
  ADD CONSTRAINT activity_pkey PRIMARY KEY (id);

ALTER TABLE ONLY "activity"
  ADD CONSTRAINT activity_fk_0
    FOREIGN KEY("boardId")
      REFERENCES board(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "activity"
  ADD CONSTRAINT activity_fk_1
    FOREIGN KEY("userId")
      REFERENCES user(id)
        ON DELETE CASCADE;
ALTER TABLE ONLY "activity"
  ADD CONSTRAINT activity_fk_2
    FOREIGN KEY("cardId")
      REFERENCES card(id)
        ON DELETE CASCADE;

