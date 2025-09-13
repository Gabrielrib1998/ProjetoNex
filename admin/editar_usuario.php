<?php
include 'auth.php';
include '../db_connect.php';

$error = null;
$success = null;
$user_id = isset($_GET['id']) ? intval($_GET['id']) : 0;

if ($user_id <= 0) {
    header("Location: usuarios.php");
    exit();
}

// Lógica para salvar os dados quando o formulário é enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Pegar os dados do formulário
    $nome = $_POST['nome'];
    $telefone = $_POST['telefone'];
    $cpf = $_POST['cpf'];
    $cep = $_POST['cep'];
    $endereco = $_POST['endereco'];
    $numero = $_POST['numero'];
    $bairro = $_POST['bairro'];
    $cidade = $_POST['cidade'];
    $estado = $_POST['estado'];
    $tipo = $_POST['tipo'];

    // Atualizar no banco de dados
    $sql_update = "UPDATE usuarios SET nome=?, telefone=?, cpf=?, cep=?, endereco=?, numero=?, bairro=?, cidade=?, estado=?, tipo=? WHERE id=?";
    $stmt_update = $conn->prepare($sql_update);
    $stmt_update->bind_param("ssssssssssi", $nome, $telefone, $cpf, $cep, $endereco, $numero, $bairro, $cidade, $estado, $tipo, $user_id);
    
    if ($stmt_update->execute()) {
        $success = "Usuário atualizado com sucesso!";
    } else {
        $error = "Erro ao atualizar o usuário: " . $stmt_update->error;
    }
    $stmt_update->close();
}

// Busca os dados atuais do usuário para exibir no formulário
$sql_fetch = "SELECT * FROM usuarios WHERE id = ?";
$stmt_fetch = $conn->prepare($sql_fetch);
$stmt_fetch->bind_param("i", $user_id);
$stmt_fetch->execute();
$result = $stmt_fetch->get_result();
if ($result->num_rows > 0) {
    $user = $result->fetch_assoc();
} else {
    // Se não encontrar o usuário, redireciona de volta para a lista
    header("Location: usuarios.php");
    exit();
}
$stmt_fetch->close();

include 'templates/header.php';
?>

<div class="admin-header">
    <h1>Editar Usuário</h1>
    <a href="usuarios.php" class="btn">&larr; Voltar para a Lista</a>
</div>

<?php if (isset($error)): ?>
    <p class="error-msg"><?php echo $error; ?></p>
<?php endif; ?>
<?php if (isset($success)): ?>
    <p class="success-msg"><?php echo $success; ?></p>
<?php endif; ?>

<form action="editar_usuario.php?id=<?php echo $user_id; ?>" method="POST" class="admin-form">
    
    <div class="form-section">
        <h3>Informações Pessoais</h3>
        <div class="form-row">
            <div class="form-group">
                <label for="nome">Nome Completo</label>
                <input type="text" id="nome" name="nome" value="<?php echo htmlspecialchars($user['nome']); ?>" required>
            </div>
            <div class="form-group">
                <label for="email">Email (não pode ser alterado)</label>
                <input type="email" id="email" name="email" value="<?php echo htmlspecialchars($user['email']); ?>" disabled>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label for="telefone">Telefone</label>
                <input type="text" id="telefone" name="telefone" value="<?php echo htmlspecialchars($user['telefone']); ?>">
            </div>
            <div class="form-group">
                <label for="cpf">CPF</label>
                <input type="text" id="cpf" name="cpf" value="<?php echo htmlspecialchars($user['cpf']); ?>">
            </div>
        </div>
    </div>

    <div class="form-section">
        <h3>Endereço de Entrega</h3>
         <div class="form-row">
            <div class="form-group">
                <label for="cep">CEP</label>
                <input type="text" id="cep" name="cep" value="<?php echo htmlspecialchars($user['cep']); ?>">
            </div>
            <div class="form-group">
                <label for="endereco">Endereço (Rua, Av.)</label>
                <input type="text" id="endereco" name="endereco" value="<?php echo htmlspecialchars($user['endereco']); ?>">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label for="numero">Número</label>
                <input type="text" id="numero" name="numero" value="<?php echo htmlspecialchars($user['numero']); ?>">
            </div>
            <div class="form-group">
                <label for="bairro">Bairro</label>
                <input type="text" id="bairro" name="bairro" value="<?php echo htmlspecialchars($user['bairro']); ?>">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label for="cidade">Cidade</label>
                <input type="text" id="cidade" name="cidade" value="<?php echo htmlspecialchars($user['cidade']); ?>">
            </div>
            <div class="form-group">
                <label for="estado">Estado (UF)</label>
                <input type="text" id="estado" name="estado" maxlength="2" value="<?php echo htmlspecialchars($user['estado']); ?>">
            </div>
        </div>
    </div>

     <div class="form-section">
        <h3>Permissões</h3>
        <div class="form-group">
            <label for="tipo">Tipo de Usuário</label>
            <select id="tipo" name="tipo">
                <option value="cliente" <?php echo ($user['tipo'] == 'cliente') ? 'selected' : ''; ?>>Cliente</option>
                <option value="admin" <?php echo ($user['tipo'] == 'admin') ? 'selected' : ''; ?>>Administrador</option>
            </select>
        </div>
    </div>
    
    <div class="form-actions">
        <button type="submit" class="btn btn-primary">Salvar Alterações</button>
    </div>
</form>

<?php 
$conn->close();
include 'templates/footer.php'; 
?>