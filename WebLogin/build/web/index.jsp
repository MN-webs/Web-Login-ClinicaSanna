<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Clínica Sanna - Login Web</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f0f4f8; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 320px; }
        h2 { text-align: center; color: #0056b3; margin-top: 0; margin-bottom: 25px; font-weight: 600; }
        .input-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #4a5568; font-size: 14px; }
        input[type="text"], input[type="password"] { width: 100%; padding: 10px; box-sizing: border-box; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 14px; }
        input[type="text"]:focus, input[type="password"]:focus { border-color: #0056b3; outline: none; }
        button { width: 100%; padding: 12px; background-color: #0056b3; border: none; color: white; border-radius: 6px; cursor: pointer; font-size: 16px; font-weight: bold; transition: background 0.2s; }
        button:hover { background-color: #004085; }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Clínica Sanna</h2>
    <form action="Login_Web_Bridge" method="POST">
        <div class="input-group">
            <label for="usuario">Usuario:</label>
            <input type="text" id="usuario" name="txtUsuario" required>
        </div>
        <div class="input-group">
            <label for="password">Contraseña:</label>
            <input type="password" id="password" name="txtPassword" required>
        </div>
        <button type="submit">Iniciar Sesión</button>
    </form>
</div>

</body>
</html>