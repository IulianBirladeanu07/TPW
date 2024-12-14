<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdaugareAngajati.aspx.cs" Inherits="SalaryStatementWebApp.AdaugareAngajati" %>

<!DOCTYPE html>
<html lang="ro">
<head runat="server">
    <meta charset="utf-8" />
    <title>Adăugare Angajat</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f6;
        }
        .form-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-container h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            font-weight: bold;
            display: block;
            margin-bottom: 8px;
            color: #555;
        }
        .form-group input {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .form-group input:focus {
            border-color: #007bff;
            outline: none;
        }
        .form-group .error-message {
            color: red;
            font-size: 14px;
        }
        .form-group .success-message {
            color: green;
            font-size: 16px;
            text-align: center;
        }
        .form-group button {
            width: 100%;
            padding: 12px;
            font-size: 18px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }

        /* Modal styles */
        .modal-content {
            background-color: #fff;
            border-radius: 8px;
        }
        .modal-body {
            font-size: 18px;
            color: #333;
        }

        /* Ensure the form looks good on small screens */
        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
                margin: 20px;
            }
            .form-group input {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

    <div class="form-container">
        <h2>Adăugare Angajat</h2>
        <form id="form1" runat="server">
            <div class="form-group">
                <label for="txtNume">Nume:</label>
                <asp:TextBox ID="txtNume" runat="server" placeholder="Introdu numele" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateName(this, 'Nume')" />
                <span id="errorNume" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="txtPrenume">Prenume:</label>
                <asp:TextBox ID="txtPrenume" runat="server" placeholder="Introdu prenumele" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateName(this, 'Prenume')" />
                <span id="errorPrenume" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="txtFunctie">Funcție:</label>
                <asp:TextBox ID="txtFunctie" runat="server" placeholder="Introdu funcția" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateFunctie(this)" />
                <span id="errorFunctie" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="txtSalarBaza">Salariul de bază:</label>
                <asp:TextBox ID="txtSalarBaza" runat="server" MaxLength="10" placeholder="Introdu salariul de bază" onkeypress="return isDecimalKey(event);" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateSalary(this)" />
                <span id="errorSalarBaza" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="txtSporPercent">Procentul de spor:</label>
                <asp:TextBox ID="txtSporPercent" runat="server" MaxLength="10" placeholder="Introdu procentul de spor" onkeypress="return isDecimalKey(event);" required="true" TextMode="SingleLine" CssClass="form-control" oninput="validateSporPercent(this)" />
                <span id="errorSporPercent" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="txtPremiiBrute">Premii brute:</label>
                <asp:TextBox ID="txtPremiiBrute" runat="server" MaxLength="10" placeholder="Introdu premiile brute" onkeypress="return isDecimalKey(event);" required="true" TextMode="SingleLine" CssClass="form-control" />
                <span id="errorPremiiBrute" class="error-message"></span>
            </div>

            <div class="form-group">
                <label for="filePoza">Poză:</label>
                <asp:FileUpload ID="filePoza" runat="server" CssClass="form-control-file" accept=".jpg, .jpeg, .png" />
                <span id="errorPoza" class="error-message"></span>
            </div>

            <div class="form-group">
                <asp:Button ID="btnAdaugaAngajat" runat="server" Text="Adaugă Angajat" OnClick="btnAdaugaAngajat_Click" CssClass="btn btn-primary" />
                <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="error-message" />
                <asp:Label ID="lblSuccessMessage" runat="server" CssClass="success-message" />
            </div>
        </form>
    </div>

    <!-- Success Modal -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="successModalLabel">Succes!</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Angajatul a fost adăugat cu succes!
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Închide</button>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        function isDecimalKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57) && charCode != 46) {
                return false;
            }
            return true;
        }

        function validateName(input, field) {
            var nameRegex = /^[A-Z][a-zA-Z]*$/;
            var nameValue = input.value;
            var errorElement = document.getElementById("error" + field);
            if (!nameRegex.test(nameValue)) {
                errorElement.innerText = field + " trebuie să conțină doar litere și să înceapă cu literă mare.";
            } else {
                errorElement.innerText = "";
            }
        }

        function validateFunctie(input) {
            var functieRegex = /^[A-Za-zăăîîșșțț\s]+$/; // Allow spaces
            var functieValue = input.value;
            var errorElement = document.getElementById("errorFunctie");
            if (!functieRegex.test(functieValue)) {
                errorElement.innerText = "Funcția trebuie să conțină doar litere și spații.";
            } else {
                errorElement.innerText = "";
            }
        }

        function validateSalary(input) {
            var salaryValue = parseFloat(input.value);
            var errorElement = document.getElementById("errorSalarBaza");
            if (isNaN(salaryValue) || salaryValue <= 0) {
                errorElement.innerText = "Salariul de bază trebuie să fie un număr valid.";
            } else {
                errorElement.innerText = "";
            }
        }

        function validateSporPercent(input) {
            var sporValue = parseFloat(input.value);
            var errorElement = document.getElementById("errorSporPercent");
            if (isNaN(sporValue) || sporValue < 0 || sporValue > 100) {
                errorElement.innerText = "Procentul de spor trebuie să fie un număr între 0 și 100.";
            } else {
                errorElement.innerText = "";
            }
        }

        // Show modal on successful form submission
        function showSuccessModal() {
            var modal = new bootstrap.Modal(document.getElementById('successModal'));
            modal.show();
        }

        // Trigger success modal after successful submission
        document.getElementById("btnAdaugaAngajat").addEventListener("click", function (event) {
            event.preventDefault();
            // Add any form validation here
            showSuccessModal();
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
