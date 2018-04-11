use BD_ROP
go

--#############################################################################################
--#                  Seguridad y acceso de sistema                                            #
--#############################################################################################

--create table mdb_seg_cat_estatus_usr
--(
-- fi_id_estatus int primary key ,
-- fc_desc_estatus varchar(100),
-- fl_estatus_estatus_usr bit default 1
--)
--with(data_compression = page)

--create table mdb_seg_tbl_usuario
--(
-- fc_usuario varchar(100) primary key,
-- fc_llave_usuario varchar(255),
-- fc_extension_usuario varchar(50),
-- fi_no_sesiones int default 0,
-- fi_id_estatus int,
-- fd_fecha_vencimiento datetime,
-- fc_celular varchar(30),
-- fc_nombre varchar(50),
-- fc_apellido_p varchar(50),
-- fc_apellido_m varchar(50),
-- fd_fecha_registro datetime,
-- fiIdUsuario  int 

-- foreign key(fi_id_estatus) references mdb_seg_cat_estatus_usr(fi_id_estatus)
 
--)
--with(data_compression = page)

--create table mdb_seg_cat_pais
--(
-- fi_id_pais int primary key,
-- fc_pais varchar(100),
-- fl_activo bit default 1
--)
--with(data_compression = page)


--create table mdb_seg_tbl_rol
--(
-- fi_id_rol int primary key,
-- fc_nombre_rol varchar(100),
-- fc_descripcion_rol varchar(100),
-- fl_estatus_rol bit default 1,
-- fi_id_pais int

-- foreign key (fi_id_pais) references mdb_seg_cat_pais(fi_id_pais)
--)
--with(data_compression = page)

--create table mdb_seg_tbl_usuario_rol
--(
-- fi_id_usuario_rol int primary key,
-- fc_usuario varchar(100),
-- fi_id_pais int

-- foreign key (fi_id_rol) references mdb_seg_tbl_rol(fi_id_rol),
-- foreign key (fc_usuario) references mdb_seg_tbl_usuario(fc_usuario) 
--)
--with(data_compression = page)



--create table mdb_seg_tbl_bit_acceso
--(
-- fi_id_bitacora_acc int primary key,
-- fc_usuario varchar(100),
-- fc_ip_usuario varchar(35),
-- fd_fecha_acceso datetime,
-- fd_fecha_cierre datetime,
-- fc_sistema_acceso varchar(30)

-- foreign key (fc_usuario) references mdb_seg_tbl_usuario(fc_usuario),

--)
--with(data_compression = page)



--create table mdb_seg_tbl_bit_error
--(
-- fi_id_bitacora_error int primary key,
-- fi_id_bitacora_acc int,  
-- fc_datos_explorador varchar(500),
-- fc_version_sistema varchar(15),
-- fc_nombre_sistema varchar(100),
-- fc_error_generado varchar(1024),
-- fc_stack_trace varchar(3000),
-- fc_target_site varchar(50),
-- fd_fecha_error datetime

-- foreign key (fi_id_bitacora_acc) references mdb_seg_tbl_bit_acceso(fi_id_bitacora_acc)
--)
--with(data_compression = page)


--create table mdb_seg_cat_sistema
--(
-- fi_id_sistema int primary key,
-- fc_nombre_sistema varchar(50),
-- fl_estatus_sistema bit default 1,
-- fc_logo varchar(255),
-- fc_url_home varchar(255) not null,
-- fl_embebido bit default 0
--)
--with(data_compression = page)




--create table mdb_seg_cat_modulo
--(
--  fi_id_modulo int primary key,
--  fc_nombre_modulo varchar(50),
--  fc_url_icono varchar(100),
--  fc_url_destino varchar(100),
--  fi_id_sistema int,
--  fl_estatus_modulo bit default 1,
--  fc_db_conexion varchar(255)
--  fi_orden int not null default 0 ,
--  fc_tooltip varchar(255) default '' ,

--  foreign key (fi_id_sistema) references mdb_seg_cat_sistema(fi_id_sistema)
--)
--with(data_compression = page)



--create table mdb_seg_cat_item_de_modulo
--(
-- fi_id_item_modulo int primary key,
-- fc_desc_item varchar(100),
-- fc_url varchar(255),
-- fc_url_icono varchar(255),
-- fi_id_item_padre int,
-- fi_id_modulo int,
-- fl_estatus_item bit default 1,
-- fi_id_orden int

-- foreign key (fi_id_modulo) references mdb_seg_cat_modulo(fi_id_modulo)
--)
--with(data_compression = page)



--create table mdb_seg_tbl_rol_item
--(
-- fi_id_rol_item int primary key,
-- fi_id_rol int,
-- fi_id_item_modulo int,
-- fl_permiso_escritura bit default 1

-- foreign key (fi_id_rol) references mdb_seg_tbl_rol(fi_id_rol),
-- foreign key (fi_id_item_modulo) references mdb_seg_cat_item_de_modulo(fi_id_item_modulo)
--)
--with(data_compression = page)



create table mdb_seg_tbl_usuario_permisos
(
  fi_id_usuario_permisos int primary key identity(1,1) not null,
  fi_id_item_modulo int not null,
  fc_usuario varchar(100) not null,
  fl_write bit default 0 not null,
  fl_delete  bit default 0 not null,
  fi_id_rol int not null,
  
  foreign key(fi_id_item_modulo) references mdb_seg_cat_item_de_modulo(fi_id_item_modulo),
  foreign key(fc_usuario) references mdb_seg_tbl_usuario(fc_usuario)
  --foreign key (fi_id_rol) references dbo.mdb_seg_tbl_rol_item(fi_id_rol)
)
with (data_compression = page)

create table mdb_seg_tbl_item_herramientas
(
  fi_id_herramienta int primary key identity(1,1) not null,
  fi_id_item_modulo int not null,
  fc_nombre varchar(255) not null,
  fl_activo bit default 1 not null

  foreign key(fi_id_item_modulo) references mdb_seg_cat_item_de_modulo(fi_id_item_modulo)
)
with (data_compression = page)

create table mdb_seg_tbl_usuario_herramientas
( 
 fi_id_usuario_permisos int not null,
 
 fi_id_herramienta int not null,
 fl_permitir bit default 0 not null

 foreign key(fi_id_usuario_permisos) references mdb_seg_tbl_usuario_permisos(fi_id_usuario_permisos),
 foreign key(fi_id_herramienta) references mdb_seg_tbl_item_herramientas(fi_id_herramienta)

)with (data_compression = page)


create table mdb_seg_tbl_token
( 
 fc_token varchar(4092) not null,
 fd_fecha_caduca datetime not null,
 fl_token_sesion bit not null,
 fc_usuario varchar(255) not null

)with (data_compression = page)


CREATE TABLE [dbo].[mdb_seg_cat_tipo_app](
	[fi_id_tipo_app] [int] NOT NULL primary key,
	[fc_descripcion] [varchar](50) NOT NULL,
	[fl_activo] [bit] NOT NULL DEFAULT ((1))
)with (data_compression = page)

CREATE TABLE [dbo].[mdb_seg_cat_tipo_transaccion](
	[fi_id_tipo_transaccion] [int] NOT NULL PRIMARY KEY,
	[fc_descripcion] [varchar](50) NOT NULL,
	[fl_activo] [bit] NOT NULL DEFAULT ((1))
	)with (data_compression = page)

CREATE TABLE [dbo].[mdb_seg_tbl_bit_transaccion](
	[fi_id_sistema] [int] NOT NULL,
	[fi_id_tipo_transaccion] [int] NOT NULL,
	[fc_neusuario] [varchar](100) NOT NULL,
	[fc_url] [text] NOT NULL,
	[fi_id_tipo_app] [int] NOT NULL,
	[fc_hostname] [varchar](50) NOT NULL,
	[fc_ipclient] [varchar](50) NOT NULL,
	[fc_mensaje] [text] NOT NULL,
	[fc_dominio] [varchar](50) NOT NULL,
	[fd_fecha_inicio_proceso] [datetime] NULL,
	[fd_fecha_fin_proceso] [datetime] NULL,
	[fd_fecha_sistema] [smalldatetime] NOT NULL,
	[fi_id_app] [int] ,
	[fi_id_usuario] [int] ,
	fc_tipo_acceso varchar(10),


	 CONSTRAINT [fk_bittransaccion_tipoapp] FOREIGN KEY([fi_id_tipo_app]) REFERENCES [dbo].[mdb_seg_cat_tipo_app] ([fi_id_tipo_app]),
	 CONSTRAINT [fk_bittransaccion_tipotransaccion] FOREIGN KEY([fi_id_tipo_transaccion]) REFERENCES [dbo].[mdb_seg_cat_tipo_transaccion] ([fi_id_tipo_transaccion])

) with (data_compression = page)


