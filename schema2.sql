DROP TABLE IF EXISTS provider_project_detail_number;
DROP TABLE IF EXISTS provider;
DROP TABLE IF EXISTS detail;
DROP TABLE IF EXISTS project;


CREATE TABLE provider (
    id     VARCHAR(64)  PRIMARY KEY,
    name   VARCHAR(64)  NOT NULL,
    status SMALLINT     NOT NULL,
    city   VARCHAR(128) NOT NULL
);

CREATE TABLE detail (
    id    VARCHAR(64) PRIMARY KEY,
    name  VARCHAR(64) NOT NULL,
    color VARCHAR(64) NOT NULL,
    size  SMALLINT    NOT NULL,
    city  VARCHAR(64) NOT NULL
);

CREATE TABLE project (
    id   VARCHAR(64) PRIMARY KEY,
    name VARCHAR(64) NOT NULL,
    city VARCHAR(64) NOT NULL
);

CREATE TABLE provider_project_detail_number (
    id          SERIAL      PRIMARY KEY, 
    provider_id VARCHAR(64) NOT NULL,
    detail_id   VARCHAR(64) NOT NULL,
    project_id  VARCHAR(64) NOT NULL,
    quantity    BIGINT      NOT NULL,
    CONSTRAINT FK_provider_project_detail_number_supplier_id FOREIGN KEY (provider_id) REFERENCES provider(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_provider_project_detail_number_detail_id   FOREIGN KEY (detail_id)   REFERENCES detail(id)   ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_provider_project_detail_number_project_id  FOREIGN KEY (project_id)  REFERENCES project(id)  ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO provider(id, name, status, city) VALUES ('P1', 'Petrov', 20, 'Moscow');
INSERT INTO provider(id, name, status, city) VALUES ('P2', 'Sinitsyn', 10, 'Tallin');
INSERT INTO provider(id, name, status, city) VALUES ('P3', 'Fedorov', 30, 'Tallin');
INSERT INTO provider(id, name, status, city) VALUES ('P4', 'Chayanov', 20, 'Minsk');
INSERT INTO provider(id, name, status, city) VALUES ('P5', 'Kryakov', 30, 'Kyiv');

INSERT INTO detail(id, name, color, size, city) VALUES ('D1', 'bolt', 'Red', 12, 'Moscow');
INSERT INTO detail(id, name, color, size, city) VALUES ('D2', 'nut', 'Green', 17, 'Minsk');
INSERT INTO detail(id, name, color, size, city) VALUES ('D3', 'Disk', 'Black', 17, 'Vilnius');
INSERT INTO detail(id, name, color, size, city) VALUES ('D4', 'Disk', 'Black', 14, 'Moscow');
INSERT INTO detail(id, name, color, size, city) VALUES ('D5', 'body', 'Red', 12, 'Minsk');
INSERT INTO detail(id, name, color, size, city) VALUES ('D6', 'caps', 'Red', 19, 'Moscow');

INSERT INTO project(id, name, city) VALUES ('PR1', 'NPR1', 'Minsk');
INSERT INTO project(id, name, city) VALUES ('PR2', 'NPR2', 'Tallin');
INSERT INTO project(id, name, city) VALUES ('PR3', 'NPR3', 'Pskov');
INSERT INTO project(id, name, city) VALUES ('PR4', 'NPR4', 'Pskov');
INSERT INTO project(id, name, city) VALUES ('PR5', 'NPR5', 'Moscow');
INSERT INTO project(id, name, city) VALUES ('PR6', 'NPR6', 'Saratov');
INSERT INTO project(id, name, city) VALUES ('PR7', 'NPR7', 'Moscow');

INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (1, 'P1', 'D1', 'PR1', 200);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (2, 'P1', 'D1', 'PR2', 700);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (3, 'P2', 'D3', 'PR1', 400);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (4, 'P2', 'D2', 'PR2', 200);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (5, 'P2', 'D3', 'PR3', 200);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (6, 'P2', 'D3', 'PR4', 500);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (7, 'P2', 'D3', 'PR5', 600);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (8, 'P2', 'D3', 'PR6', 400);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (9, 'P2', 'D3', 'PR7', 800);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (10, 'P2', 'D5', 'PR2', 100);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (11, 'P3', 'D3', 'PR1', 200);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (12, 'P3', 'D4', 'PR2', 500);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (13, 'P4', 'D6', 'PR3', 300);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (14, 'P4', 'D6', 'PR7', 300);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (15, 'P5', 'D2', 'PR2', 200);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (16, 'P5', 'D2', 'PR4', 100);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (17, 'P5', 'D5', 'PR5', 500);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (18, 'P5', 'D5', 'PR7', 100);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (19, 'P5', 'D6', 'PR2', 200);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (20, 'P5', 'D1', 'PR2', 100);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (21, 'P5', 'D3', 'PR4', 200);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (22, 'P5', 'D4', 'PR4', 800);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (23, 'P5', 'D5', 'PR4', 400);
INSERT INTO provider_project_detail_number(id, provider_id, detail_id, project_id, quantity) VALUES (24, 'P5', 'D6', 'PR4', 500);