/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     2021/5/8 12:50:49                            */
/*==============================================================*/


drop table House;

drop table Own;

drop table Owner;

drop table "User";

drop table UsingRelationship;

/*==============================================================*/
/* Table: House                                                 */
/*==============================================================*/
create table House (
   HouseID              CHAR(32)             not null,
   Price                MONEY                not null,
   Location             TEXT                 not null,
   Name                 TEXT                 not null,
   Kind                 TEXT                 not null,
   isAvailable          BOOL                 not null,
   OwnerName            VARCHAR(20)          not null,
   constraint PK_HOUSE primary key (HouseID)
);

/*==============================================================*/
/* Table: Own                                                   */
/*==============================================================*/
create table Own (
   HouseID              CHAR(32)             not null,
   OwnerID              CHAR(18)             not null,
   constraint PK_OWN primary key (HouseID, OwnerID)
);

/*==============================================================*/
/* Table: Owner                                                 */
/*==============================================================*/
create table Owner (
   OwnerID              CHAR(18)             not null,
   OwnerName            VARCHAR(20)          not null,
   OwnerPhoneNumber     CHAR(11)             not null,
   OwnerGender          CHAR(2)              not null,
   constraint PK_OWNER primary key (OwnerID)
);

/*==============================================================*/
/* Table: "User"                                                */
/*==============================================================*/
create table "User" (
   UserID               CHAR(18)             not null,
   HouseID              CHAR(32)             null,
   UserName             VARCHAR(20)          not null,
   UserGender           CHAR(2)              not null,
   isHomeless           BOOL                 not null,
   UseHouseID           CHAR(32)             null,
   constraint PK_USER primary key (UserID)
);

/*==============================================================*/
/* Table: UsingRelationship                                     */
/*==============================================================*/
create table UsingRelationship (
   OwnerID              CHAR(18)             null,
   UserID               CHAR(18)             null,
   HouseID              CHAR(32)             null,
   DealID               CHAR(64)             not null,
   constraint PK_USINGRELATIONSHIP primary key (DealID)
);

alter table Own
   add constraint FK_OWN_REFERENCE_HOUSE foreign key (HouseID)
      references House (HouseID)
      on delete restrict on update restrict;

alter table Own
   add constraint FK_OWN_REFERENCE_OWNER foreign key (OwnerID)
      references Owner (OwnerID)
      on delete restrict on update restrict;

alter table "User"
   add constraint FK_USER_REFERENCE_HOUSE foreign key (HouseID)
      references House (HouseID)
      on delete restrict on update restrict;

alter table UsingRelationship
   add constraint FK_USINGREL_REFERENCE_OWNER foreign key (OwnerID)
      references Owner (OwnerID)
      on delete restrict on update restrict;

alter table UsingRelationship
   add constraint FK_USINGREL_REFERENCE_USER foreign key (UserID)
      references "User" (UserID)
      on delete restrict on update restrict;

alter table UsingRelationship
   add constraint FK_USINGREL_REFERENCE_HOUSE foreign key (HouseID)
      references House (HouseID)
      on delete restrict on update restrict;

