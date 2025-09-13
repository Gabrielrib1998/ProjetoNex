<?php
include 'db_connect.php';
// Inicia a sessão apenas se não houver uma ativa
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$error = null;

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email']; // Não precisa de real_escape_string com prepared statements
    $senha = $_POST['senha'];

    // --- CÓDIGO CORRIGIDO E SEGURO ---
    // Prepara a consulta para evitar SQL Injection
    $sql = "SELECT id, nome, senha, tipo, foto_perfil FROM usuarios WHERE email = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    // --- FIM DO CÓDIGO CORRIGIDO ---

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        
        // Verifica a senha usando o hash
        if (password_verify($senha, $row['senha'])) {
            // Login bem-sucedido, armazena TODOS os dados na sessão
            $_SESSION['usuario_id'] = $row['id'];
            $_SESSION['usuario_nome'] = $row['nome'];
            $_SESSION['usuario_tipo'] = $row['tipo']; // A informação crucial!
            $_SESSION['usuario_foto'] = $row['foto_perfil'];
            
            header("Location: index.php");
            exit();
        } else {
            $error = "Senha incorreta.";
        }
    } else {
        $error = "Nenhum usuário encontrado com este email.";
    }
    $stmt->close();
}
include 'templates/header.php';
?>

<div class="container form-container">
    <form method="POST" action="login.php" class="auth-form">
        <h2>Login</h2>
        <?php if(isset($error)) { echo "<p class='error' style='color: #ef4444; background: rgba(239,68,68,0.1); padding: 10px; border-radius: 5px;'>".$error."</p>"; } ?>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" required>
        </div>
        <button type="submit" class="btn">Entrar</button>
        <p>Não tem uma conta? <a href="cadastro.php">Cadastre-se</a></p>
    </form>
</div>

<?php 
$conn->close();
include 'templates/footer.php'; 
?>