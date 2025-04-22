<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log-in</title>
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, Helvetica, sans-serif;
        }
        @keyframes body{
            0% {
                opacity: 0;
            }
            100%{
                opacity: 1;
            }
        }

        body{
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 15%;
            background-image: url(images/bg.jpg);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            animation-name: body;
            animation-duration: 2s;
            animation-iteration-count: 1;
            animation-timing-function: cubic-bezier(0.5,0,0.5,1);
        }
        .Wrapper{
            background-color: transparent;
            border:2px solid rgba(255, 255, 255, 0.8);
            backdrop-filter: blur(0px);
            color: rgb(247, 250, 250);
            width: 420px;
            border-radius: 20px;
            padding: 35px 45px;
        }
        .Wrapper h1{
            font-size: 50px;
            text-align: center;
        }
        .Wrapper h1::after{
            content: '';
            width: 30px;
            height: 4px;
            border-radius: 3px;
            background: #3c00a0;
            position: absolute;
            bottom: -12px;
            left: 50%;
            transform: translateX(-50%);
        }
        .Wrapper .inputbox{
            position: relative;
            width: 100%;
            height: 50px;
            margin: 20px 0;
        }
        .inputbox input{
            width: 100%;
            height: 100%;
            background: transparent;
            border: none;
            outline: none;
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 40px;
            color:#fff;
            padding: 20px 45px 20px 20px;
        }
        .inputbox input::placeholder{
            color: #fff;
        }
        .inputbox i {
            position: absolute;
            right: 20px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 20px;
        }
        .Wrapper .remember-forget{
            display: flex;
            justify-content: space-between;
            font-size: 14px;
            margin: -15px 0 15px;
        }
        .remember-forget label input{
            accent-color: #fff;
            margin-right: 3px;
        }
        .remember-forget a{
            color: #fff;
            text-decoration: none;
        }
        .remember-forget a:hover{
            text-decoration: underline;
        }
        .Wrapper button{
            width:100%;
            height: 45px;
            background: #fff;
            border: none;
            outline: none;
            border-radius: 45px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
        }
        .Wrapper .register-link{
            font-size: 14px;
            text-align: center;
            margin-top: 20px;
        }
        .register-link p a{
            color: #fff;
            text-decoration: none;
            font-weight: 600;
        }
        .register-link p a:hover{
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="Wrapper">
    <form action="">
        <h1>Log-in</h1>
        <div class="inputbox">
            <input type="text" placeholder="Username" required>
            <i class='bx bxs-user'></i>
        </div>
        <div class="inputbox">
            <input type="password" placeholder="Password" required>
            <i class='bx bxs-lock'></i>
        </div>
        <div class="remember-forget">
            <label>
                <br><input type="checkbox">Remember me
            </label>
            <a href=""><br>Forgot Password ?</a>
        </div>
        <button type="submit" class="button">Login</button>
        <div class="register-link">
            <p>Don't have an account? <a href="" >Register</a></p>
        </div>
    </form>
</div>
</body>
</html>