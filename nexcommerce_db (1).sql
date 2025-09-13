-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 13/09/2025 às 07:55
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `nexcommerce_db`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedidos`
--

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'Pendente',
  `endereco_entrega` text DEFAULT NULL,
  `data_pedido` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `pedidos`
--

INSERT INTO `pedidos` (`id`, `usuario_id`, `valor_total`, `status`, `endereco_entrega`, `data_pedido`) VALUES
(1, 2, 2549.80, 'Processando', 'Rua das Flores, 123, Apto 45, São Paulo, SP, 01234-567', '2025-09-13 05:06:50'),
(2, 3, 1899.90, 'Enviado', 'Avenida Principal, 789, Rio de Janeiro, RJ, 20000-123', '2025-09-13 05:06:50'),
(3, 4, 2198.80, 'Entregue', 'Praça da Liberdade, 10, Belo Horizonte, MG, 30140-010', '2025-09-13 05:06:50'),
(4, 1, 3348.90, 'Pendente', NULL, '2025-09-13 05:11:18');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pedido_items`
--

CREATE TABLE `pedido_items` (
  `id` int(11) NOT NULL,
  `pedido_id` int(11) DEFAULT NULL,
  `produto_id` int(11) DEFAULT NULL,
  `quantidade` int(11) NOT NULL,
  `preco_unitario` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `pedido_items`
--

INSERT INTO `pedido_items` (`id`, `pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) VALUES
(1, 1, 9, 1, 899.90),
(2, 1, 27, 1, 649.90),
(3, 2, 1, 1, 1899.90),
(4, 3, 16, 2, 349.90),
(5, 3, 15, 1, 1499.00),
(6, 4, 1, 1, 1899.90),
(7, 4, 15, 1, 1449.00);

-- --------------------------------------------------------

--
-- Estrutura para tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `descricao` text DEFAULT NULL,
  `especificacoes` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `estoque` int(11) NOT NULL DEFAULT 0,
  `categoria` varchar(50) DEFAULT NULL,
  `marca` varchar(100) DEFAULT NULL,
  `imagem_url` varchar(255) DEFAULT NULL,
  `imagens_galeria` text DEFAULT NULL,
  `em_oferta` tinyint(1) NOT NULL DEFAULT 0,
  `preco_antigo` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `descricao`, `especificacoes`, `preco`, `estoque`, `categoria`, `marca`, `imagem_url`, `imagens_galeria`, `em_oferta`, `preco_antigo`) VALUES
(1, 'Cadeira DXRacer Acing', 'Cadeira gamer ergonômica com design de corrida, ajuste de altura e encosto reclinável. Ideal para longas sessões de jogos.', '- Material: Couro PU\n- Ajuste de Altura: Sim\n- Encosto Reclinável: Até 135°\n- Peso Suportado: 120kg', 1899.90, 10, 'Móveis', NULL, 'assets/img/produtos/cadeira_dxracer_acing.jpg', NULL, 0, NULL),
(2, 'Cadeira de Escritório Pro', 'Cadeira de escritório profissional com suporte lombar ajustável, material respirável e design moderno para o seu home office.', '- Material do Assento: Espuma de alta densidade\n- Base: Aço, 5 rodízios\n- Ajuste Lombar: Sim\n- Cor: Preto', 999.90, 10, 'Móveis', NULL, 'assets/img/produtos/cadeira_pro.jpg', NULL, 0, NULL),
(3, 'Câmera Intelbras IM3', 'Câmera de segurança Wi-Fi Full HD com visão noturna, áudio bidirecional e inteligência artificial. Monitore sua casa pelo celular.', '- Resolução: Full HD (1080p)\n- Conexão: Wi-Fi\n- Visão Noturna: Sim, até 10m\n- Áudio: Bidirecional', 289.90, 10, 'Redes e Smart Home', NULL, 'assets/img/produtos/camera_intelbras_im3.jpg', NULL, 0, NULL),
(4, 'Carregador Anker PowerWave', 'Base de carregamento sem fio rápida de 10W. Compatível com todos os principais smartphones com tecnologia Qi.', '- Potência: 10W (Máx)\n- Padrão: Qi Wireless\n- Compatibilidade: Universal\n- Entrada: USB-C', 99.90, 10, 'Periféricos', NULL, 'assets/img/produtos/carregador_anker_powerwave.jpg', NULL, 1, 299.90),
(5, 'CPU AMD Ryzen 9 7900X', 'Processador de alta performance com 12 núcleos, 24 threads e frequência de até 5.6GHz. Potência máxima para jogos e criação.', '- Núcleos: 12\n- Threads: 24\n- Clock Base: 4.7GHz\n- Clock Turbo: 5.6GHz\n- Soquete: AM5', 3499.90, 10, 'Hardware', NULL, 'assets/img/produtos/cpu_amd_ryzen9_7900x.jpg', NULL, 0, NULL),
(6, 'Fita LED Philips Hue', 'Fita de LED inteligente e colorida. Crie ambientes incríveis e controle a iluminação pelo seu smartphone ou assistente de voz.', '- Comprimento: 2 metros\n- Cores: 16 milhões (RGB)\n- Conectividade: Bluetooth\n- App: Philips Hue', 499.00, 10, 'Redes e Smart Home', NULL, 'assets/img/produtos/fita_led_phillips_hue.jpg', NULL, 0, NULL),
(7, 'Gabinete Lian Li O11 Dynamic', 'Gabinete premium com design de vidro duplo, excelente fluxo de ar e amplo espaço para montagens customizadas.', '- Tipo: Mid-Tower\n- Material: Alumínio e Vidro Temperado\n- Suporte a Water Cooler: Sim, até 360mm\n- Cor: Branco', 1299.90, 10, 'Gabinetes', NULL, 'assets/img/produtos/gabinete_lian_li_o11.jpg', NULL, 0, NULL),
(8, 'GPU Gigabyte RTX 4070', 'Placa de vídeo NVIDIA GeForce RTX 4070 com 12GB de memória GDDR6X. Desempenho extremo para rodar jogos em 4K.', '- Memória: 12GB GDDR6X\n- Interface: PCI Express 4.0\n- Conexões: 3x DisplayPort 1.4a, 1x HDMI 2.1', 4599.90, 10, 'Hardware', NULL, 'assets/img/produtos/gpu_gigabyte_rtx_4070.jpg', NULL, 0, NULL),
(9, 'Headset Corsair HS80 RGB Wireless', 'Headset gamer sem fio com áudio espacial Dolby Atmos, microfone de alta qualidade e iluminação RGB.', '- Conexão: Wireless 2.4GHz\n- Áudio: Dolby Atmos\n- Microfone: Unidirecional, qualidade de transmissão\n- Bateria: Até 20 horas', 899.90, 10, 'Periféricos', NULL, 'assets/img/produtos/headset_corsair_hs80.jpg', NULL, 0, NULL),
(10, 'Headset Gamer Genérico', '**OFERTA!** Headset gamer de entrada com som estéreo, microfone flexível e conexão P2. Ótimo custo-benefício.', '- Conexão: P2 (3.5mm)\n- Áudio: Estéreo\n- Microfone: Flexível\n- Compatibilidade: PC, Consoles', 49.90, 10, 'Periféricos', NULL, 'assets/img/produtos/headset_gamer.jpg', NULL, 1, 249.90),
(11, 'Headset Sony WH-1000XM5', 'Fone de ouvido sem fio com o melhor cancelamento de ruído do mercado, áudio de alta resolução e design confortável.', '- Cancelamento de Ruído: Ativo (Líder da Indústria)\n- Conexão: Bluetooth 5.2\n- Bateria: Até 30 horas\n- Áudio: Hi-Res Audio Wireless', 2299.00, 10, 'Periféricos', NULL, 'assets/img/produtos/headset_sony_wh1000xm5.jpg', NULL, 0, NULL),
(12, 'Impressora Epson EcoTank L3250', 'Impressora multifuncional com tanques de tinta de alta capacidade, Wi-Fi integrado e baixo custo de impressão.', '- Tipo: Multifuncional (Imprime, Copia, Digitaliza)\n- Tecnologia: EcoTank (Tanque de Tinta)\n- Conexão: Wi-Fi, USB\n- Rendimento: Até 7.500 págs coloridas', 1249.00, 10, 'Impressoras', NULL, 'assets/img/produtos/impressora_epson_l3250.jpg', NULL, 0, NULL),
(13, 'Mesa de Escritório Gamer', 'Mesa espaçosa com design moderno, superfície texturizada para mouse e estrutura reforçada em aço.', '- Dimensões: 140cm x 60cm\n- Material: MDF e Aço\n- Cor: Preto com detalhes em vermelho\n- Extras: Porta-copos, suporte para headset', 799.90, 10, 'Móveis', NULL, 'assets/img/produtos/mesa_escritorio.jpg', NULL, 0, NULL),
(14, 'Monitor Alienware AW2723DF', 'Monitor gamer de 27 polegadas, Quad HD (2560x1440), taxa de atualização de 280Hz e tempo de resposta de 1ms.', '- Tamanho: 27 polegadas\n- Resolução: QHD (2560x1440)\n- Taxa de Atualização: 280Hz\n- Tempo de Resposta: 1ms\n- Painel: Fast IPS', 4999.90, 10, 'Monitores', NULL, 'assets/img/produtos/monitor_alienware_aw2723df.jpg', NULL, 0, NULL),
(15, 'Monitor LG Ultrawide 29\"', '**OFERTA!** Monitor LG Ultrawide de 29 polegadas com tela Full HD IPS. Perfeito para produtividade e imersão em jogos.', '- Tamanho: 29 polegadas\n- Proporção: 21:9 (Ultrawide)\n- Resolução: Full HD (2560x1080)\n- Painel: IPS\n- HDR: Sim, HDR10', 1449.00, 10, 'Monitores', NULL, 'assets/img/produtos/monitor_lg.jpg', NULL, 1, 1649.00),
(16, 'Mouse Logitech G502 Hero', 'Mouse gamer com sensor Hero de 25K DPI, 11 botões programáveis e pesos ajustáveis para uma pegada perfeita.', '- Sensor: HERO 25K\n- DPI: 100 - 25.600\n- Botões Programáveis: 11\n- Peso Ajustável: Sim\n- Iluminação: RGB Lightsync', 349.90, 10, 'Periféricos', NULL, 'assets/img/produtos/mouse_logitech_g502.jpg', NULL, 0, NULL),
(17, 'Mouse Logitech MX Master 3S', 'Mouse sem fio de alta precisão para produtividade, com scroll eletromagnético e design ergonômico.', '- Sensor: Darkfield 8K DPI\n- Scroll: Eletromagnético MagSpeed\n- Conexão: Bluetooth, Logi Bolt USB\n- Bateria: Recarregável, até 70 dias', 599.90, 10, 'Periféricos', NULL, 'assets/img/produtos/mouse_mx.jpg', NULL, 0, NULL),
(18, 'Notebook Acer Nitro 5', 'Notebook gamer com processador Intel Core i5, 8GB RAM, 512GB SSD e placa de vídeo NVIDIA GTX 1650.', '- Processador: Intel Core i5\n- Memória RAM: 8GB DDR4\n- Armazenamento: 512GB SSD NVMe\n- Placa de Vídeo: NVIDIA GeForce GTX 1650', 4899.00, 10, 'Notebooks e Tablets', NULL, 'assets/img/produtos/notebook_acer_nitro5.jpg', NULL, 0, NULL),
(19, 'Notebook Dell Inspiron 15', 'Notebook para trabalho e estudos com tela de 15.6\" Full HD, processador Intel Core i7, 16GB RAM e 512GB SSD.', '- Processador: Intel Core i7 12ª Gen\n- Memória RAM: 16GB DDR4\n- Armazenamento: 512GB SSD NVMe\n- Tela: 15.6\" Full HD WVA', 5299.00, 10, 'Notebooks e Tablets', NULL, 'assets/img/produtos/notebook_dell.jpg', NULL, 0, NULL),
(20, 'Projetor Samsung The Freestyle', 'Projetor smart portátil Full HD, com rotação 180°, ajuste automático de imagem e alto-falante 360°. Leve o cinema com você.', '- Resolução: Full HD\n- Brilho: 550 Lumens\n- Rotação: 180°\n- Sistema: Tizen Smart TV\n- Áudio: 360 graus', 3999.00, 10, 'Áudio e Vídeo', NULL, 'assets/img/produtos/projetor_samsung_freestyle.jpg', NULL, 0, NULL),
(21, 'Roteador TP-Link Archer AX55', 'Roteador Wi-Fi 6 Dual-Band para conexões ultrarrápidas, estáveis e com maior cobertura para sua casa.', '- Padrão Wi-Fi: Wi-Fi 6 (802.11ax)\n- Velocidade: Até 3000 Mbps\n- Portas: 1x WAN Gigabit, 4x LAN Gigabit\n- Segurança: WPA3', 549.90, 10, 'Redes e Smart Home', NULL, 'assets/img/produtos/roteador_tplink_ax55.jpg', NULL, 0, NULL),
(22, 'Smart Speaker Amazon Echo Dot 5', 'O Echo Dot com o melhor som já lançado. Ouça músicas, crie alarmes e controle sua casa inteligente com a Alexa.', '- Assistente de Voz: Alexa\n- Conectividade: Wi-Fi, Bluetooth\n- Alto-falante: 1.73\" com áudio aprimorado\n- Cor: Preto', 379.00, 10, 'Redes e Smart Home', NULL, 'assets/img/produtos/smart_speaker_echo_dot5.jpg', NULL, 0, NULL),
(23, 'Soundbar JBL SB170', 'Soundbar 2.1 canais com subwoofer sem fio, 220W de potência e tecnologia Dolby Digital para um som de cinema.', '- Potência: 220W\n- Canais: 2.1\n- Subwoofer: Sem Fio\n- Conexões: HDMI ARC, Óptica, Bluetooth', 1299.00, 10, 'Áudio e Vídeo', NULL, 'assets/img/produtos/soundbar_jbl_sb170.jpg', NULL, 0, NULL),
(24, 'SSD Kingston NV2 1TB', '**OFERTA!** SSD NVMe PCIe 4.0 com velocidades de leitura de até 3.500MB/s. Deixe seu PC ou notebook muito mais rápido.', '- Capacidade: 1TB\n- Formato: M.2 2280\n- Interface: NVMe PCIe 4.0\n- Velocidade de Leitura: Até 3.500MB/s', 349.90, 10, 'Hardware', NULL, 'assets/img/produtos/ssd_kingston.jpg', NULL, 1, 549.90),
(25, 'SSD WD Black SN770 1TB', 'SSD de alta performance para gamers, com velocidades de leitura de até 5.150MB/s. Carregue seus jogos instantaneamente.', '- Capacidade: 1TB\n- Formato: M.2 2280\n- Interface: NVMe PCIe 4.0\n- Velocidade de Leitura: Até 5.150MB/s', 699.90, 10, 'Hardware', NULL, 'assets/img/produtos/ssd_wd_sn770.jpg', NULL, 0, NULL),
(26, 'Tablet Samsung Galaxy Tab S9', 'Tablet premium com tela AMOLED de 11\", processador Snapdragon 8 Gen 2, 8GB de RAM e 128GB de armazenamento. Inclui S Pen.', '- Tela: 11\" AMOLED Dinâmico 2X\n- Processador: Snapdragon 8 Gen 2\n- Armazenamento: 128GB\n- RAM: 8GB\n- Caneta S Pen: Inclusa', 5999.00, 10, 'Notebooks e Tablets', NULL, 'assets/img/produtos/tablet_samsung_tab_s9.jpg', NULL, 0, NULL),
(27, 'Teclado Mecânico HyperX Alloy Origins', 'Teclado mecânico gamer com switches HyperX Red, estrutura em alumínio e iluminação RGB personalizável.', '- Tipo: Mecânico\n- Switches: HyperX Red (Linear)\n- Material: Alumínio Aeronáutico\n- Iluminação: RGB por tecla', 649.90, 10, 'Periféricos', NULL, 'assets/img/produtos/teclado_hyperx.jpg', NULL, 0, NULL),
(28, 'Teclado Logitech MX Keys', 'Teclado sem fio avançado com teclas inteligentes iluminadas, digitação confortável e conexão multidispositivo.', '- Tipo: Membrana (Digitação Silenciosa)\n- Conexão: Bluetooth, Logi Bolt USB\n- Iluminação: Retroiluminação Inteligente\n- Bateria: Recarregável', 729.90, 10, 'Periféricos', NULL, 'assets/img/produtos/teclado_logitech_mxkeys.jpg', NULL, 0, NULL),
(29, 'Webcam Logitech C920 Pro', 'Webcam Full HD 1080p para videochamadas e streaming com alta qualidade de imagem e som estéreo.', '- Resolução: 1080p a 30fps\n- Foco: Automático\n- Microfone: Estéreo integrado\n- Conexão: USB-A', 449.90, 10, 'Periféricos', NULL, 'assets/img/produtos/webcam_logitech.jpg', NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `data_cadastro` timestamp NOT NULL DEFAULT current_timestamp(),
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `tipo` enum('cliente','admin') NOT NULL DEFAULT 'cliente',
  `foto_perfil` varchar(255) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `cep` varchar(9) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `estado` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `data_cadastro`, `nome`, `email`, `senha`, `tipo`, `foto_perfil`, `telefone`, `data_nascimento`, `cpf`, `cep`, `endereco`, `numero`, `bairro`, `cidade`, `estado`) VALUES
(1, '2025-09-13 04:28:10', 'Administrador', 'admin@nexcommerce.com', '$2y$10$IAPOYdyZ50spY7Ro/W3C1uipaau71qZzGLJ9xSpfukAlFp7.lgK8G', 'admin', 'assets/img/avatars/user_1_1757736280.jpg', '11978762734', '1998-03-13', '452.528.798-50', '07159-600', 'Rua Amarilis', '752', 'Parque Residencial Bambi', 'Guarulhos', 'SP'),
(2, '2025-09-13 04:28:10', 'Ana Silva', 'ana.silva@exemplo.com', '$2y$10$iRn7K.w2T.b.r5Q3gY2k/eW8i2J5U5s3gT6q.Z1fX.nK9Z3c.H6uW', 'cliente', NULL, '(11) 98765-4321', NULL, '111.222.333-44', NULL, NULL, NULL, NULL, 'São Paulo', 'SP'),
(3, '2025-09-13 04:28:10', 'Bruno Costa', 'bruno.costa@exemplo.com', '$2y$10$iRn7K.w2T.b.r5Q3gY2k/eW8i2J5U5s3gT6q.Z1fX.nK9Z3c.H6uW', 'cliente', NULL, '(21) 91234-5678', NULL, '222.333.444-55', NULL, NULL, NULL, NULL, 'Rio de Janeiro', 'RJ'),
(4, '2025-09-13 04:28:10', 'Carla Dias', 'carla.dias@exemplo.com', '$2y$10$iRn7K.w2T.b.r5Q3gY2k/eW8i2J5U5s3gT6q.Z1fX.nK9Z3c.H6uW', 'cliente', NULL, '(31) 95555-8888', NULL, '333.444.555-66', NULL, NULL, NULL, NULL, 'Belo Horizonte', 'MG'),
(5, '2025-09-13 05:38:47', 'GABRIEL costa', 'gabriel.costarib@hotmail.com', '$2y$10$lY8jvVxlHXdKDEYj2oXQ/.VlX8arrfY80HJ6JsI/C1lXcbs1foz1K', 'cliente', NULL, '11978762734', '1998-03-13', '452.528.798-50', NULL, NULL, NULL, NULL, NULL, NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`);

--
-- Índices de tabela `pedido_items`
--
ALTER TABLE `pedido_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pedido_id` (`pedido_id`),
  ADD KEY `produto_id` (`produto_id`);

--
-- Índices de tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `pedido_items`
--
ALTER TABLE `pedido_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`);

--
-- Restrições para tabelas `pedido_items`
--
ALTER TABLE `pedido_items`
  ADD CONSTRAINT `pedido_items_ibfk_1` FOREIGN KEY (`pedido_id`) REFERENCES `pedidos` (`id`),
  ADD CONSTRAINT `pedido_items_ibfk_2` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
