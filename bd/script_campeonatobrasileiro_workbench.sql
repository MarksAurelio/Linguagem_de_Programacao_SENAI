use campeonatobrasileiro;

show create table jogador;

CREATE TABLE `jogador` (
   `id_jogador` int NOT NULL,
   `nome` varchar(150) DEFAULT NULL,
   `numero` int DEFAULT NULL,
   `data_nascimento` date DEFAULT NULL,
   `posicao` varchar(150) DEFAULT NULL,
   `id_time` int NOT NULL,
   PRIMARY KEY (`id_jogador`),
   KEY `FK_JogadorTime` (`id_time`),
   CONSTRAINT `FK_JogadorTime` FOREIGN KEY (`id_time`) REFERENCES `time` (`id_time`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
 show create table time;
 
 CREATE TABLE `time` (
   `id_time` int NOT NULL,
   `nome_completo` varchar(150) DEFAULT NULL,
   `nome` varchar(3) DEFAULT NULL,
   `cidade` varchar(150) DEFAULT NULL,
   `estado` varchar(150) DEFAULT NULL,
   `id_estadio` int NOT NULL,
   PRIMARY KEY (`id_time`),
   KEY `FK_EstadioTime` (`id_estadio`),
   CONSTRAINT `FK_EstadioTime` FOREIGN KEY (`id_estadio`) REFERENCES `estadio` (`id_estadio`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
 show create table partida;
 
 CREATE TABLE `partida` (
   `id_partida` int NOT NULL,
   `rodada` int NOT NULL,
   `horario` datetime NOT NULL,
   `gol_mandante` int NOT NULL,
   `gol_visitante` int NOT NULL,
   `id_mandante` int NOT NULL,
   `id_visitante` int NOT NULL,
   `id_estadio` int NOT NULL,
   PRIMARY KEY (`id_partida`),
   KEY `FK_TimeMandante` (`id_mandante`),
   KEY `FK_TimeVisitante` (`id_visitante`),
   KEY `FK_PartidaEstadio` (`id_estadio`),
   CONSTRAINT `FK_PartidaEstadio` FOREIGN KEY (`id_estadio`) REFERENCES `estadio` (`id_estadio`),
   CONSTRAINT `FK_TimeMandante` FOREIGN KEY (`id_mandante`) REFERENCES `time` (`id_time`),
   CONSTRAINT `FK_TimeVisitante` FOREIGN KEY (`id_visitante`) REFERENCES `time` (`id_time`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
 show create table evento;
 
 CREATE TABLE `evento` (
   `id_evento` int NOT NULL,
   `minuto` int NOT NULL,
   `descricao` varchar(150) DEFAULT NULL,
   `id_partida` int NOT NULL,
   `id_jogador` int NOT NULL,
   PRIMARY KEY (`id_evento`),
   KEY `FK_EventoPartida` (`id_partida`),
   KEY `FK_EventoJogador` (`id_jogador`),
   CONSTRAINT `FK_EventoJogador` FOREIGN KEY (`id_jogador`) REFERENCES `jogador` (`id_jogador`),
   CONSTRAINT `FK_EventoPartida` FOREIGN KEY (`id_partida`) REFERENCES `partida` (`id_partida`)
 ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
 
 -- apagando a regra de chave estrangeira

alter table jogador drop constraint FK_JogadorTime;
alter table partida drop constraint FK_TimeMandante;
alter table partida drop constraint FK_TimeVisitante;
-- incluindo o auto_increment
alter table time modify id_time int auto_increment;
-- incluir novamente a regra da chave estrangeira
alter table jogador add constraint FK_JogadorTime foreign key(id_time) references time(id_time);
alter table partida add constraint FK_TimeMandante foreign key(id_mandante) references time(id_time);
alter table partida add constraint FK_TimeVisitante foreign key(id_visitante) references time(id_time);
desc time;
desc partida;
alter table evento drop constraint FK_EventoPartida;
alter table partida modify id_partida int auto_increment;
alter table evento add constraint FK_EventoPartida foreign key(id_partida) references partida(id_partida);
