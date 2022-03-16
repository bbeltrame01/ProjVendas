-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 16-Mar-2022 03:47
-- Versão do servidor: 10.4.22-MariaDB
-- versão do PHP: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+03:00";


--
-- Banco de dados: `proj_wk`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cad_clientes`
--

CREATE TABLE `cad_clientes` (
  `cli_cod` int(11) NOT NULL,
  `cli_nome` varchar(100) NOT NULL,
  `cli_cidade` varchar(100) DEFAULT NULL,
  `cli_uf` char(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `cad_clientes`
--

INSERT INTO `cad_clientes` (`cli_cod`, `cli_nome`, `cli_cidade`, `cli_uf`) VALUES
(1, 'cliente 01', 'SÃ£o Paulo', 'SP'),
(2, 'cliente 02', 'SÃ£o Paulo', 'SP'),
(3, 'cliente 03', 'SÃ£o Paulo', 'SP'),
(4, 'cliente 04', 'SÃ£o Paulo', 'SP'),
(5, 'cliente 05', 'Curitiba', 'PR'),
(6, 'cliente 06', 'SÃ£o Paulo', 'SP'),
(7, 'cliente 07', 'VitÃ³ria', 'ES'),
(8, 'cliente 08', 'SÃ£o Paulo', 'SP'),
(9, 'cliente 09', 'Minas Gerais', 'MG'),
(10, 'cliente 10', 'SÃ£o Paulo', 'SP'),
(11, 'cliente 11', 'Minas Gerais', 'MG'),
(12, 'cliente 12', 'SÃ£o Paulo', 'SP'),
(13, 'cliente 13', 'Minas Gerais', 'MG'),
(14, 'cliente 14', 'SÃ£o Paulo', 'SP'),
(15, 'cliente 15', 'SÃ£o Paulo', 'SP'),
(16, 'cliente 16', 'Rio de janeiro', 'RJ'),
(17, 'cliente 17', 'SÃ£o Paulo', 'SP'),
(18, 'cliente 18', 'SÃ£o Paulo', 'SP'),
(19, 'cliente 19', 'Rio de janeiro', 'RJ'),
(20, 'cliente 20', 'SÃ£o Paulo', 'SP');

-- --------------------------------------------------------

--
-- Estrutura da tabela `cad_produtos`
--

CREATE TABLE `cad_produtos` (
  `pro_cod` int(11) NOT NULL,
  `pro_desc` varchar(100) NOT NULL,
  `pro_preco_venda` float DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `cad_produtos`
--

INSERT INTO `cad_produtos` (`pro_cod`, `pro_desc`, `pro_preco_venda`) VALUES
(1, 'teste 01', 10),
(2, 'teste 02', 10),
(3, 'teste 03', 10),
(4, 'teste 04', 10),
(5, 'teste 05', 11),
(6, 'teste 06', 10),
(7, 'teste 07', 5),
(8, 'teste 08', 10),
(9, 'teste 09', 36),
(10, 'teste 10', 10),
(11, 'teste 11', 14),
(12, 'teste 12', 10),
(13, 'teste 13', 55),
(14, 'teste 14', 10),
(15, 'teste 15', 10),
(16, 'teste 16', 72),
(17, 'teste 17', 10),
(18, 'teste 18', 10),
(19, 'teste 19', 66),
(20, 'teste 20', 10);

-- --------------------------------------------------------

--
-- Estrutura da tabela `mov_prodven`
--

CREATE TABLE `mov_prodven` (
  `proven_cod` int(11) NOT NULL,
  `proven_codven` int(11) NOT NULL,
  `proven_codpro` int(11) NOT NULL,
  `proven_qtd` float NOT NULL,
  `proven_vlrun` float NOT NULL,
  `proven_vlrtotal` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `mov_vendas`
--

CREATE TABLE `mov_vendas` (
  `ven_cod` int(11) NOT NULL,
  `ven_dtemi` date NOT NULL DEFAULT current_timestamp(),
  `ven_cliente` int(11) NOT NULL,
  `ven_vlrtotal` double NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Ã�ndices para tabelas despejadas
--

--
-- Ã�ndices para tabela `cad_clientes`
--
ALTER TABLE `cad_clientes`
  ADD PRIMARY KEY (`cli_cod`);

--
-- Ã�ndices para tabela `cad_produtos`
--
ALTER TABLE `cad_produtos`
  ADD PRIMARY KEY (`pro_cod`);

--
-- Ã�ndices para tabela `mov_prodven`
--
ALTER TABLE `mov_prodven`
  ADD PRIMARY KEY (`proven_cod`),
  ADD KEY `fk_produto` (`proven_codpro`),
  ADD KEY `fk_vendas` (`proven_codven`) USING BTREE;

--
-- Ã�ndices para tabela `mov_vendas`
--
ALTER TABLE `mov_vendas`
  ADD PRIMARY KEY (`ven_cod`),
  ADD KEY `fk_cliente` (`ven_cliente`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cad_clientes`
--
ALTER TABLE `cad_clientes`
  MODIFY `cli_cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `cad_produtos`
--
ALTER TABLE `cad_produtos`
  MODIFY `pro_cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `mov_prodven`
--
ALTER TABLE `mov_prodven`
  MODIFY `proven_cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `mov_vendas`
--
ALTER TABLE `mov_vendas`
  MODIFY `ven_cod` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Limitadores para a tabela `mov_prodven`
--
ALTER TABLE `mov_prodven`
  ADD CONSTRAINT `fk_produto` FOREIGN KEY (`proven_codpro`) REFERENCES `cad_produtos` (`pro_cod`),
  ADD CONSTRAINT `fk_venda` FOREIGN KEY (`proven_codven`) REFERENCES `mov_vendas` (`ven_cod`);

--
-- Limitadores para a tabela `mov_vendas`
--
ALTER TABLE `mov_vendas`
  ADD CONSTRAINT `fk_cliente` FOREIGN KEY (`ven_cliente`) REFERENCES `cad_clientes` (`cli_cod`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
