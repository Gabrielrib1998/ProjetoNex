CREATE DATABASE IF NOT EXISTS projectnex_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE projectnex_db;

-- Tabela de Usuários
-- Inferido de: cadastro.php, login.php, minha-conta.php, admin/usuarios.php
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo ENUM('cliente', 'admin') NOT NULL DEFAULT 'cliente',
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Produtos
-- Inferido de: produtos.php, produto.php, admin/produtos.php, admin/produto_form.php
CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT NOT NULL DEFAULT 0,
    imagem_url VARCHAR(255),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Pedidos
-- Inferido de: meus-pedidos.php, checkout.php, admin/pedidos.php
CREATE TABLE pedidos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT,
    valor_total DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'Pendente',
    endereco_entrega TEXT,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabela de Itens do Pedido
-- Necessária para conectar produtos aos pedidos
CREATE TABLE pedido_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- Tabela de Contato (Opcional, mas provável)
-- Inferido de: fale-conosco.php
CREATE TABLE mensagens_contato (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    mensagem TEXT NOT NULL,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lido BOOLEAN NOT NULL DEFAULT FALSE
);
INSERT INTO `produtos` (`nome`, `descricao`, `preco`, `estoque`, `imagem_url`) VALUES
('Cadeira DXRacer Acing', 'Cadeira gamer ergonômica com design de corrida, ajuste de altura e encosto reclinável. Ideal para longas sessões de jogos.', 1899.90, 10, 'assets/img/produtos/cadeira_dxracer_acing.jpg'),
('Cadeira de Escritório Pro', 'Cadeira de escritório profissional com suporte lombar ajustável, material respirável e design moderno para o seu home office.', 999.90, 10, 'assets/img/produtos/cadeira_pro.jpg'),
('Câmera Intelbras IM3', 'Câmera de segurança Wi-Fi Full HD com visão noturna, áudio bidirecional e inteligência artificial. Monitore sua casa pelo celular.', 289.90, 10, 'assets/img/produtos/camera_intelbras_im3.jpg'),
('Carregador Anker PowerWave', 'Base de carregamento sem fio rápida de 10W. Compatível com todos os principais smartphones com tecnologia Qi.', 149.90, 10, 'assets/img/produtos/carregador_anker_powerwave.jpg'),
('CPU AMD Ryzen 9 7900X', 'Processador de alta performance com 12 núcleos, 24 threads e frequência de até 5.6GHz. Potência máxima para jogos e criação.', 3499.90, 10, 'assets/img/produtos/cpu_amd_ryzen9_7900x.jpg'),
('Fita LED Philips Hue', 'Fita de LED inteligente e colorida. Crie ambientes incríveis e controle a iluminação pelo seu smartphone ou assistente de voz.', 499.00, 10, 'assets/img/produtos/fita_led_phillips_hue.jpg'),
('Gabinete Lian Li O11 Dynamic', 'Gabinete premium com design de vidro duplo, excelente fluxo de ar e amplo espaço para montagens customizadas.', 1299.90, 10, 'assets/img/produtos/gabinete_lian_li_o11.jpg'),
('GPU Gigabyte RTX 4070', 'Placa de vídeo NVIDIA GeForce RTX 4070 com 12GB de memória GDDR6X. Desempenho extremo para rodar jogos em 4K.', 4599.90, 10, 'assets/img/produtos/gpu_gigabyte_rtx_4070.jpg'),
('Headset Corsair HS80 RGB Wireless', 'Headset gamer sem fio com áudio espacial Dolby Atmos, microfone de alta qualidade e iluminação RGB.', 899.90, 10, 'assets/img/produtos/headset_corsair_hs80.jpg'),
('Headset Gamer Genérico', '**OFERTA!** Headset gamer de entrada com som estéreo, microfone flexível e conexão P2. Ótimo custo-benefício.', 99.90, 10, 'assets/img/produtos/headset_gamer.jpg'),
('Headset Sony WH-1000XM5', 'Fone de ouvido sem fio com o melhor cancelamento de ruído do mercado, áudio de alta resolução e design confortável.', 2299.00, 10, 'assets/img/produtos/headset_sony_wh1000xm5.jpg'),
('Impressora Epson EcoTank L3250', 'Impressora multifuncional com tanques de tinta de alta capacidade, Wi-Fi integrado e baixo custo de impressão.', 1249.00, 10, 'assets/img/produtos/impressora_epson_l3250.jpg'),
('Mesa de Escritório Gamer', 'Mesa espaçosa com design moderno, superfície texturizada para mouse e estrutura reforçada em aço.', 799.90, 10, 'assets/img/produtos/mesa_escritorio.jpg'),
('Monitor Alienware AW2723DF', 'Monitor gamer de 27 polegadas, Quad HD (2560x1440), taxa de atualização de 280Hz e tempo de resposta de 1ms.', 4999.90, 10, 'assets/img/produtos/monitor_alienware_aw2723df.jpg'),
('Monitor LG Ultrawide 29"', '**OFERTA!** Monitor LG Ultrawide de 29 polegadas com tela Full HD IPS. Perfeito para produtividade e imersão em jogos.', 1499.00, 10, 'assets/img/produtos/monitor_lg.jpg'),
('Mouse Logitech G502 Hero', 'Mouse gamer com sensor Hero de 25K DPI, 11 botões programáveis e pesos ajustáveis para uma pegada perfeita.', 349.90, 10, 'assets/img/produtos/mouse_logitech_g502.jpg'),
('Mouse Logitech MX Master 3S', 'Mouse sem fio de alta precisão para produtividade, com scroll eletromagnético e design ergonômico.', 599.90, 10, 'assets/img/produtos/mouse_mx.jpg'),
('Notebook Acer Nitro 5', 'Notebook gamer com processador Intel Core i5, 8GB RAM, 512GB SSD e placa de vídeo NVIDIA GTX 1650.', 4899.00, 10, 'assets/img/produtos/notebook_acer_nitro5.jpg'),
('Notebook Dell Inspiron 15', 'Notebook para trabalho e estudos com tela de 15.6" Full HD, processador Intel Core i7, 16GB RAM e 512GB SSD.', 5299.00, 10, 'assets/img/produtos/notebook_dell.jpg'),
('Projetor Samsung The Freestyle', 'Projetor smart portátil Full HD, com rotação 180°, ajuste automático de imagem e alto-falante 360°. Leve o cinema com você.', 3999.00, 10, 'assets/img/produtos/projetor_samsung_freestyle.jpg'),
('Roteador TP-Link Archer AX55', 'Roteador Wi-Fi 6 Dual-Band para conexões ultrarrápidas, estáveis e com maior cobertura para sua casa.', 549.90, 10, 'assets/img/produtos/roteador_tplink_ax55.jpg'),
('Smart Speaker Amazon Echo Dot 5', 'O Echo Dot com o melhor som já lançado. Ouça músicas, crie alarmes e controle sua casa inteligente com a Alexa.', 379.00, 10, 'assets/img/produtos/smart_speaker_echo_dot5.jpg'),
('Soundbar JBL SB170', 'Soundbar 2.1 canais com subwoofer sem fio, 220W de potência e tecnologia Dolby Digital para um som de cinema.', 1299.00, 10, 'assets/img/produtos/soundbar_jbl_sb170.jpg'),
('SSD Kingston NV2 1TB', '**OFERTA!** SSD NVMe PCIe 4.0 com velocidades de leitura de até 3.500MB/s. Deixe seu PC ou notebook muito mais rápido.', 399.90, 10, 'assets/img/produtos/ssd_kingston.jpg'),
('SSD WD Black SN770 1TB', 'SSD de alta performance para gamers, com velocidades de leitura de até 5.150MB/s. Carregue seus jogos instantaneamente.', 699.90, 10, 'assets/img/produtos/ssd_wd_sn770.jpg'),
('Tablet Samsung Galaxy Tab S9', 'Tablet premium com tela AMOLED de 11", processador Snapdragon 8 Gen 2, 8GB de RAM e 128GB de armazenamento. Inclui S Pen.', 5999.00, 10, 'assets/img/produtos/tablet_samsung_tab_s9.jpg'),
('Teclado Mecânico HyperX Alloy Origins', 'Teclado mecânico gamer com switches HyperX Red, estrutura em alumínio e iluminação RGB personalizável.', 649.90, 10, 'assets/img/produtos/teclado_hyperx.jpg'),
('Teclado Logitech MX Keys', 'Teclado sem fio avançado com teclas inteligentes iluminadas, digitação confortável e conexão multidispositivo.', 729.90, 10, 'assets/img/produtos/teclado_logitech_mxkeys.jpg'),
('Webcam Logitech C920 Pro', 'Webcam Full HD 1080p para videochamadas e streaming com alta qualidade de imagem e som estéreo.', 449.90, 10, 'assets/img/produtos/webcam_logitech.jpg'),
('Kit Mouse e Teclado sem Fio Logitech MK235', 'Kit ABNT2 resistente a derramamentos, com mouse ambidestro e conexão sem fio plug-and-play de longo alcance.', 159.90, 10, 'assets/img/produtos/kit_logitech_mk235.jpg');
INSERT INTO usuarios (nome, email, senha, tipo) VALUES ('Administrador', 'admin@nexcommerce.com', 'admin123', 'admin');
ALTER TABLE `produtos`
ADD COLUMN `em_oferta` BOOLEAN NOT NULL DEFAULT FALSE,
ADD COLUMN `preco_antigo` DECIMAL(10, 2) NULL DEFAULT NULL;
UPDATE `produtos` SET `em_oferta` = 1, `preco_antigo` = `preco` + 150, `preco` = `preco` - 50 WHERE `id` IN (10, 15, 24, 4);
ALTER TABLE `produtos`
ADD COLUMN `categoria` VARCHAR(50) NULL DEFAULT NULL AFTER `estoque`;
-- Móveis e Cadeiras
UPDATE `produtos` SET `categoria` = 'Móveis' WHERE `id` IN (1, 2, 13);

-- Periféricos (Mouses, Teclados, Headsets, etc.)
UPDATE `produtos` SET `categoria` = 'Periféricos' WHERE `id` IN (4, 9, 10, 11, 16, 17, 27, 28, 29, 30);

-- Hardware (Peças de computador)
UPDATE `produtos` SET `categoria` = 'Hardware' WHERE `id` IN (5, 8, 24, 25, 7);

-- Notebooks e Tablets
UPDATE `produtos` SET `categoria` = 'Notebooks' WHERE `id` IN (18, 19);
UPDATE `produtos` SET `categoria` = 'Tablets' WHERE `id` IN (26);

-- Monitores e Projetores
UPDATE `produtos` SET `categoria` = 'Monitores' WHERE `id` IN (14, 15);
UPDATE `produtos` SET `categoria` = 'Áudio e Vídeo' WHERE `id` IN (20, 23);

-- Redes e Smart Home
UPDATE `produtos` SET `categoria` = 'Redes e Smart Home' WHERE `id` IN (3, 6, 21, 22);

-- Impressoras
UPDATE `produtos` SET `categoria` = 'Impressoras' WHERE `id` IN (12);
UPDATE `produtos` 
SET `categoria` = 'Tecnologia' 
WHERE `categoria` IN ('Periféricos', 'Hardware', 'Notebooks', 'Tablets', 'Monitores', 'Áudio e Vídeo', 'Redes e Smart Home');
ALTER TABLE `usuarios`
ADD COLUMN `foto_perfil` VARCHAR(255) NULL DEFAULT NULL AFTER `tipo`;
ALTER TABLE `usuarios`
ADD COLUMN `telefone` VARCHAR(20) NULL DEFAULT NULL,
ADD COLUMN `data_nascimento` DATE NULL DEFAULT NULL,
ADD COLUMN `cpf` VARCHAR(14) NULL DEFAULT NULL,
ADD COLUMN `cep` VARCHAR(9) NULL DEFAULT NULL,
ADD COLUMN `endereco` VARCHAR(255) NULL DEFAULT NULL,
ADD COLUMN `numero` VARCHAR(10) NULL DEFAULT NULL,
ADD COLUMN `bairro` VARCHAR(100) NULL DEFAULT NULL,
ADD COLUMN `cidade` VARCHAR(100) NULL DEFAULT NULL,
ADD COLUMN `estado` VARCHAR(2) NULL DEFAULT NULL;
-- Categoria para Mouses, Teclados, Headsets, etc.
UPDATE `produtos` SET `categoria` = 'Periféricos' WHERE `id` IN (4, 9, 10, 11, 16, 17, 27, 28, 29, 30);

-- Categoria para Peças de Computador (CPU, GPU, SSD)
UPDATE `produtos` SET `categoria` = 'Hardware' WHERE `id` IN (5, 8, 24, 25);

-- Categoria para Gabinetes
UPDATE `produtos` SET `categoria` = 'Gabinetes' WHERE `id` IN (7);

-- Categoria para Notebooks e Tablets
UPDATE `produtos` SET `categoria` = 'Notebooks e Tablets' WHERE `id` IN (18, 19, 26);

-- Categoria para Monitores
UPDATE `produtos` SET `categoria` = 'Monitores' WHERE `id` IN (14, 15);

-- Categoria para Áudio e Vídeo (Projetores, Soundbars)
UPDATE `produtos` SET `categoria` = 'Áudio e Vídeo' WHERE `id` IN (20, 23);

-- Categoria para Conectividade e Casa Inteligente
UPDATE `produtos` SET `categoria` = 'Redes e Smart Home' WHERE `id` IN (3, 6, 21, 22);
ALTER TABLE `produtos`
ADD COLUMN `marca` VARCHAR(100) NULL DEFAULT NULL AFTER `categoria`,
ADD COLUMN `imagens_galeria` TEXT NULL DEFAULT NULL AFTER `imagem_url`;
-- Primeiro, pegamos os IDs dos usuários para usar nos pedidos.
-- Lembre-se que o seu ID pode ser diferente, mas para o exemplo, vamos assumir 2, 3 e 4.
SET @ana_id = 2;
SET @bruno_id = 3;
SET @carla_id = 4;

-- ################# PEDIDO 1 (Ana Silva - 1 Headset e 1 Teclado) #################
-- Insere o pedido principal na tabela 'pedidos'
INSERT INTO `pedidos` (`usuario_id`, `valor_total`, `status`, `endereco_entrega`) 
VALUES (@ana_id, 2549.80, 'Processando', 'Rua das Flores, 123, Apto 45, São Paulo, SP, 01234-567');

-- Pega o ID do pedido que acabamos de criar
SET @pedido1_id = LAST_INSERT_ID();

-- Insere os itens deste pedido na tabela 'pedido_items'
INSERT INTO `pedido_items` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) 
VALUES
(@pedido1_id, 9, 1, 899.90),  -- Headset Corsair HS80
(@pedido1_id, 27, 1, 649.90); -- Teclado Mecânico HyperX (Preço de quando inserimos, não o de oferta)

-- ################# PEDIDO 2 (Bruno Costa - 1 Cadeira Gamer) #################
INSERT INTO `pedidos` (`usuario_id`, `valor_total`, `status`, `endereco_entrega`) 
VALUES (@bruno_id, 1899.90, 'Enviado', 'Avenida Principal, 789, Rio de Janeiro, RJ, 20000-123');
SET @pedido2_id = LAST_INSERT_ID();
INSERT INTO `pedido_items` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) 
VALUES
(@pedido2_id, 1, 1, 1899.90); -- Cadeira DXRacer Acing

-- ################# PEDIDO 3 (Carla Dias - 2 Mouses e 1 Monitor em Oferta) #################
INSERT INTO `pedidos` (`usuario_id`, `valor_total`, `status`, `endereco_entrega`) 
VALUES (@carla_id, 2198.80, 'Entregue', 'Praça da Liberdade, 10, Belo Horizonte, MG, 30140-010');
SET @pedido3_id = LAST_INSERT_ID();
INSERT INTO `pedido_items` (`pedido_id`, `produto_id`, `quantidade`, `preco_unitario`) 
VALUES
(@pedido3_id, 16, 2, 349.90), -- 2x Mouse Logitech G502 Hero
(@pedido3_id, 15, 1, 1499.00); -- Monitor LG Ultrawide 29" (Preço de oferta)
UPDATE `produtos` SET `especificacoes` = '- Material: Couro PU\n- Ajuste de Altura: Sim\n- Encosto Reclinável: Até 135°\n- Peso Suportado: 120kg' WHERE `id` = 1;
UPDATE `produtos` SET `especificacoes` = '- Material do Assento: Espuma de alta densidade\n- Base: Aço, 5 rodízios\n- Ajuste Lombar: Sim\n- Cor: Preto' WHERE `id` = 2;
UPDATE `produtos` SET `especificacoes` = '- Resolução: Full HD (1080p)\n- Conexão: Wi-Fi\n- Visão Noturna: Sim, até 10m\n- Áudio: Bidirecional' WHERE `id` = 3;
UPDATE `produtos` SET `especificacoes` = '- Potência: 10W (Máx)\n- Padrão: Qi Wireless\n- Compatibilidade: Universal\n- Entrada: USB-C' WHERE `id` = 4;
UPDATE `produtos` SET `especificacoes` = '- Núcleos: 12\n- Threads: 24\n- Clock Base: 4.7GHz\n- Clock Turbo: 5.6GHz\n- Soquete: AM5' WHERE `id` = 5;
UPDATE `produtos` SET `especificacoes` = '- Comprimento: 2 metros\n- Cores: 16 milhões (RGB)\n- Conectividade: Bluetooth\n- App: Philips Hue' WHERE `id` = 6;
UPDATE `produtos` SET `especificacoes` = '- Tipo: Mid-Tower\n- Material: Alumínio e Vidro Temperado\n- Suporte a Water Cooler: Sim, até 360mm\n- Cor: Branco' WHERE `id` = 7;
UPDATE `produtos` SET `especificacoes` = '- Memória: 12GB GDDR6X\n- Interface: PCI Express 4.0\n- Conexões: 3x DisplayPort 1.4a, 1x HDMI 2.1' WHERE `id` = 8;
UPDATE `produtos` SET `especificacoes` = '- Conexão: Wireless 2.4GHz\n- Áudio: Dolby Atmos\n- Microfone: Unidirecional, qualidade de transmissão\n- Bateria: Até 20 horas' WHERE `id` = 9;
UPDATE `produtos` SET `especificacoes` = '- Conexão: P2 (3.5mm)\n- Áudio: Estéreo\n- Microfone: Flexível\n- Compatibilidade: PC, Consoles' WHERE `id` = 10;
UPDATE `produtos` SET `especificacoes` = '- Cancelamento de Ruído: Ativo (Líder da Indústria)\n- Conexão: Bluetooth 5.2\n- Bateria: Até 30 horas\n- Áudio: Hi-Res Audio Wireless' WHERE `id` = 11;
UPDATE `produtos` SET `especificacoes` = '- Tipo: Multifuncional (Imprime, Copia, Digitaliza)\n- Tecnologia: EcoTank (Tanque de Tinta)\n- Conexão: Wi-Fi, USB\n- Rendimento: Até 7.500 págs coloridas' WHERE `id` = 12;
UPDATE `produtos` SET `especificacoes` = '- Dimensões: 140cm x 60cm\n- Material: MDF e Aço\n- Cor: Preto com detalhes em vermelho\n- Extras: Porta-copos, suporte para headset' WHERE `id` = 13;
UPDATE `produtos` SET `especificacoes` = '- Tamanho: 27 polegadas\n- Resolução: QHD (2560x1440)\n- Taxa de Atualização: 280Hz\n- Tempo de Resposta: 1ms\n- Painel: Fast IPS' WHERE `id` = 14;
UPDATE `produtos` SET `especificacoes` = '- Tamanho: 29 polegadas\n- Proporção: 21:9 (Ultrawide)\n- Resolução: Full HD (2560x1080)\n- Painel: IPS\n- HDR: Sim, HDR10' WHERE `id` = 15;
UPDATE `produtos` SET `especificacoes` = '- Sensor: HERO 25K\n- DPI: 100 - 25.600\n- Botões Programáveis: 11\n- Peso Ajustável: Sim\n- Iluminação: RGB Lightsync' WHERE `id` = 16;
UPDATE `produtos` SET `especificacoes` = '- Sensor: Darkfield 8K DPI\n- Scroll: Eletromagnético MagSpeed\n- Conexão: Bluetooth, Logi Bolt USB\n- Bateria: Recarregável, até 70 dias' WHERE `id` = 17;
UPDATE `produtos` SET `especificacoes` = '- Processador: Intel Core i5\n- Memória RAM: 8GB DDR4\n- Armazenamento: 512GB SSD NVMe\n- Placa de Vídeo: NVIDIA GeForce GTX 1650' WHERE `id` = 18;
UPDATE `produtos` SET `especificacoes` = '- Processador: Intel Core i7 12ª Gen\n- Memória RAM: 16GB DDR4\n- Armazenamento: 512GB SSD NVMe\n- Tela: 15.6" Full HD WVA' WHERE `id` = 19;
UPDATE `produtos` SET `especificacoes` = '- Resolução: Full HD\n- Brilho: 550 Lumens\n- Rotação: 180°\n- Sistema: Tizen Smart TV\n- Áudio: 360 graus' WHERE `id` = 20;
UPDATE `produtos` SET `especificacoes` = '- Padrão Wi-Fi: Wi-Fi 6 (802.11ax)\n- Velocidade: Até 3000 Mbps\n- Portas: 1x WAN Gigabit, 4x LAN Gigabit\n- Segurança: WPA3' WHERE `id` = 21;
UPDATE `produtos` SET `especificacoes` = '- Assistente de Voz: Alexa\n- Conectividade: Wi-Fi, Bluetooth\n- Alto-falante: 1.73" com áudio aprimorado\n- Cor: Preto' WHERE `id` = 22;
UPDATE `produtos` SET `especificacoes` = '- Potência: 220W\n- Canais: 2.1\n- Subwoofer: Sem Fio\n- Conexões: HDMI ARC, Óptica, Bluetooth' WHERE `id` = 23;
UPDATE `produtos` SET `especificacoes` = '- Capacidade: 1TB\n- Formato: M.2 2280\n- Interface: NVMe PCIe 4.0\n- Velocidade de Leitura: Até 3.500MB/s' WHERE `id` = 24;
UPDATE `produtos` SET `especificacoes` = '- Capacidade: 1TB\n- Formato: M.2 2280\n- Interface: NVMe PCIe 4.0\n- Velocidade de Leitura: Até 5.150MB/s' WHERE `id` = 25;
UPDATE `produtos` SET `especificacoes` = '- Tela: 11" AMOLED Dinâmico 2X\n- Processador: Snapdragon 8 Gen 2\n- Armazenamento: 128GB\n- RAM: 8GB\n- Caneta S Pen: Inclusa' WHERE `id` = 26;
UPDATE `produtos` SET `especificacoes` = '- Tipo: Mecânico\n- Switches: HyperX Red (Linear)\n- Material: Alumínio Aeronáutico\n- Iluminação: RGB por tecla' WHERE `id` = 27;
UPDATE `produtos` SET `especificacoes` = '- Tipo: Membrana (Digitação Silenciosa)\n- Conexão: Bluetooth, Logi Bolt USB\n- Iluminação: Retroiluminação Inteligente\n- Bateria: Recarregável' WHERE `id` = 28;
UPDATE `produtos` SET `especificacoes` = '- Resolução: 1080p a 30fps\n- Foco: Automático\n- Microfone: Estéreo integrado\n- Conexão: USB-A' WHERE `id` = 29;
UPDATE `produtos` SET `especificacoes` = '- Padrão Teclado: ABNT2\n- Conexão: Wireless 2.4GHz\n- Bateria: Pilhas (longa duração)\n- Design: Resistente a derramamentos' WHERE `id` = 30;