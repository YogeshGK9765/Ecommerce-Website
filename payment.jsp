<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment - PhonePe UPI</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 40px;
        }

        .qr-container {
            margin: 30px auto;
            max-width: 300px;
        }

        img.qr-code {
            width: 100%;
            border: 2px solid #ccc;
            padding: 10px;
            border-radius: 10px;
        }

        h1 {
            color: #5e00a3;
        }

        .details {
            margin-top: 20px;
            font-size: 18px;
        }

        .success-msg {
            margin-top: 40px;
            color: green;
            font-weight: bold;
        }
    </style>
</head>
<body>

    <h1>Pay with PhonePe</h1>
    <p>Scan the QR code below using your PhonePe app to complete the payment.</p>

    <div class="qr-container">
        <!-- QR Code from uploaded file -->
        <img src="images/pay1.png" alt="PhonePe UPI QR" class="qr-code">
    </div>

    <div class="details">
        <p><strong>Recipient:</strong> Yogesh Gangadhar Kalyankar</p>
        <p><strong>Payment Method:</strong> UPI (PhonePe)</p>
    </div>

    <div class="success-msg">
        <p>After completing the payment, your order will be processed automatically.</p>
        <p>Thank you for your purchase!</p>
    </div>

</body>
</html>
