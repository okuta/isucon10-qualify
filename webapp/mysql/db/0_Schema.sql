DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL
);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL
);

ALTER TABLE isuumo.estate ADD COLUMN door_size0 INT GENERATED ALWAYS AS (GREATEST(door_width, door_height)) STORED;
ALTER TABLE isuumo.estate ADD COLUMN door_size1 INT GENERATED ALWAYS AS (LEAST(door_width, door_height)) STORED;
ALTER TABLE isuumo.estate ADD COLUMN popularity2 BIGINT GENERATED ALWAYS AS (popularity * 100000000 - id) STORED;
ALTER TABLE isuumo.chair ADD COLUMN popularity2 BIGINT GENERATED ALWAYS AS (popularity * 100000000 - id) STORED;

--
-- テーブルのインデックス `estate`
--
ALTER TABLE isuumo.estate
  ADD KEY `latitude` (`latitude`,`longitude`),
  ADD KEY `door_size0` (`door_size0`),
  ADD KEY `door_size1` (`door_size1`),
  ADD KEY `door_height` (`door_height`),
  ADD KEY `door_width` (`door_width`),
  ADD KEY `rent` (`rent`),
  ADD KEY `rent2` (`rent`,`popularity`),
  Add KEY `popularity2` (`popularity2`),
  ADD KEY `popularity` (`popularity`);

--
-- テーブルのインデックス `chair`
--
ALTER TABLE isuumo.chair
  ADD KEY `price` (`price`),
  ADD KEY `height` (`height`),
  ADD KEY `width` (`width`),
  ADD KEY `depth` (`depth`) USING BTREE,
  ADD KEY `kind` (`kind`),
  ADD KEY `color` (`color`),
  ADD KEY `stock` (`stock`),
  Add KEY `popularity2` (`popularity2`),
  ADD KEY `popularity` (`popularity`);
